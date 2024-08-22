package models

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"sync"
	"sync/atomic"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

const (
	// 允许向对等体写消息的时间。
	writeWait = 10 * time.Second

	// 允许从对等端读取下一个pong消息的时间。
	pongWait = 60 * time.Second

	// 在此时间段向对等体发送ping。肯定比乒乓小，等等。
	pingPeriod = (pongWait * 9) / 10

	// 允许来自对等体的最大消息大小。
	maxMessageSize  = 512
	heartbeatPeriod = 30 * time.Second
)

var (
	newline = []byte{'\n'}
	space   = []byte{' '}
)

type Message struct {
	Type            string `json:"type"`
	Speaker         string `json:"speaker"`
	UserIDTo        string `json:"user_id_to"`
	Content         string `json:"content"`
	InformationTime string `json:"information_time"`
	UserId          string `json:"user_id"`
}

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

type Client struct {
	hub       *Hub
	conn      *websocket.Conn
	send      chan []byte
	userID    string // 存储用户ID的新字段
	isReading int32  // 使用int32原子标志表示是否正在读取消息
}

func (h *Hub) HandleMessage(message []byte) {
	var msg Message

	if err := json.Unmarshal(message, &msg); err != nil {
		log.Printf("error: %v", err)
		return
	}

	h.mutex.Lock()
	defer h.mutex.Unlock()

	if client, ok := h.userIDToClient[msg.UserIDTo]; ok {
		msg.Speaker = "server"
		jsonData, err := json.Marshal(msg)
		if err != nil {
			log.Printf("error: %v", err)
			return
		}

		if atomic.LoadInt32(&client.isReading) == 1 {
			select {
			case client.send <- jsonData:
			default:
				log.Println("Error: 无法向客户端发送消息")
			}
		} else {
			ticker := time.NewTicker(pingPeriod)
			defer ticker.Stop()

			for {
				select {
				case client.send <- jsonData:
					return
				case <-ticker.C:
					if atomic.LoadInt32(&client.isReading) == 0 {
						return
					}
				}
			}
		}
	} else {
		fmt.Println("用户离线")
		// h.pendingMessages[msg.UserIDTo] = append(h.pendingMessages[msg.UserIDTo], message)

		aqlMessage := AqlMessage{
			Type:            msg.Type,
			Speaker:         msg.Speaker,
			UserIDTo:        msg.UserIDTo,
			Content:         msg.Content,
			InformationTime: msg.InformationTime,
			UserId:          msg.UserId,
		}
		if err := saveUnreadMessageToDB(aqlMessage); err != nil {
			log.Printf("error 离线信息存储错误: %v", err)
		}
	}
}

func saveUnreadMessageToDB(message AqlMessage) error {

	err := DB.Create(&message).Error
	if err != nil {
		fmt.Println(err)
	}

	return nil
}
func (c *Client) readPump() {

	atomic.StoreInt32(&c.isReading, 1)
	defer func() {
		c.hub.unregister <- c
		c.conn.Close()
		atomic.StoreInt32(&c.isReading, 0)
	}()

	c.conn.SetReadLimit(maxMessageSize)
	c.conn.SetReadDeadline(time.Now().Add(pongWait))
	c.conn.SetPongHandler(func(string) error { c.conn.SetReadDeadline(time.Now().Add(pongWait)); return nil })

	for {
		_, message, err := c.conn.ReadMessage()
		if err != nil {
			if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseAbnormalClosure) {
				log.Printf("error: %v", err)
			}
			break
		}

		msgStr := string(bytes.TrimSpace(bytes.Replace(message, newline, space, -1)))

		if msgStr == "u" {
			continue
		}

		var msg Message
		if err := json.Unmarshal([]byte(msgStr), &msg); err != nil {
			// log.Printf("Error parsing JSON: %v", err)
			continue
		}

		c.hub.HandleMessage(message)
	}
}

func (c *Client) writePump() {
	ticker := time.NewTicker(pingPeriod)
	defer func() {
		ticker.Stop()
		c.conn.Close()
	}()
	for {
		select {
		case message, ok := <-c.send:
			c.conn.SetWriteDeadline(time.Now().Add(writeWait))
			if !ok {
				c.conn.WriteMessage(websocket.CloseMessage, []byte{})
				return
			}

			w, err := c.conn.NextWriter(websocket.TextMessage)
			if err != nil {
				return
			}
			w.Write(message)

			n := len(c.send)
			for i := 0; i < n; i++ {
				w.Write(newline)
				w.Write(<-c.send)
			}

			if err := w.Close(); err != nil {
				return
			}
		case <-ticker.C:
			c.conn.SetWriteDeadline(time.Now().Add(writeWait))
			if err := c.conn.WriteMessage(websocket.PingMessage, nil); err != nil {
				return
			}
		}
	}
}

// 修改ServeWs函数，在注册时接受一个用户ID参数，并将其与客户端关联。
func (h *Hub) GetConnectedUserIDs() []string {
	var userIDs []string

	h.mutex.Lock()
	for userID := range h.userIDToClient {
		userIDs = append(userIDs, userID)
	}
	h.mutex.Unlock()

	return userIDs
}

func (h *Hub) ServeWs(c *gin.Context) {

	userID := c.Query("user_id")
	conn, err := upgrader.Upgrade(c.Writer, c.Request, nil)
	if err != nil {
		panic(err)
	}

	client := &Client{hub: h, conn: conn, send: make(chan []byte, 2048), userID: userID}
	// 注册客户端
	h.register <- client
	// 发送离线消息
	go func() {
		// 从数据库中获取离线消息
		offlineMessages, err := getOfflineMessages(userID)
		if err != nil {
			log.Println("Error:", err)
			return
		}

		// 启动多个 goroutine 并发处理转发离线消息给用户
		var wg sync.WaitGroup
		for _, offlineMessage := range offlineMessages {
			wg.Add(1)
			go func(message AqlMessage) {
				defer wg.Done()

				// 转换消息格式并发送给客户端
				msg := convertToMessageFormat(message)
				jsonData, err := json.Marshal(msg)
				if err != nil {
					log.Printf("Error: %v", err)
					return
				}
				// 发送消息到客户端
				select {
				case client.send <- jsonData:
					fmt.Println("消息发送成功")
				default:
					log.Println("Error: 无法向客户端发送消息")
				}
				time.Sleep(800 * time.Millisecond)
			}(offlineMessage)
		}

		wg.Wait()

		DB.Where("user_id_to", userID).Delete(&offlineMessages)
	}()

	go client.writePump()
	go client.readPump()

}
func convertToMessageFormat(aqlMessage AqlMessage) Message {
	message := Message{
		Type:            aqlMessage.Type,
		Speaker:         "server",
		UserIDTo:        aqlMessage.UserIDTo,
		Content:         aqlMessage.Content,
		InformationTime: aqlMessage.InformationTime,
		UserId:          aqlMessage.UserId,
	}

	return message
}
func getOfflineMessages(userID string) ([]AqlMessage, error) {
	aqlMessages := []AqlMessage{}
	result := DB.Where("user_id_to = ?", userID).Find(&aqlMessages)
	if result.Error != nil {
		return nil, result.Error
	}
	return aqlMessages, nil
}
