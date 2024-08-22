package models

import (
	"bytes"
	"fmt"
	"sync"
	"sync/atomic"
	"time"
)

type Hub struct {
	clients         map[*Client]bool
	userIDToClient  map[string]*Client // 用户ID到客户端的映射
	broadcast       chan []byte
	register        chan *Client
	unregister      chan *Client
	pendingMessages map[string][][]byte // 存储未连接WebSocket的用户的消息
	mutex           sync.Mutex
}

// 修改NewHub函数以初始化userIDToClient映射。
func NewHub() *Hub {
	return &Hub{
		broadcast:       make(chan []byte),
		register:        make(chan *Client),
		unregister:      make(chan *Client),
		clients:         make(map[*Client]bool),
		userIDToClient:  make(map[string]*Client),
		pendingMessages: make(map[string][][]byte),
		mutex:           sync.Mutex{},
	}
}

func (h *Hub) Rrun() {

	ticker := time.NewTicker(heartbeatPeriod)
	defer ticker.Stop()

	go h.handleHeartbeat()

	for {
		select {

		case client := <-h.register:
			h.mutex.Lock()
			h.clients[client] = true
			h.userIDToClient[client.userID] = client
			h.mutex.Unlock()
			UserIDs := h.GetConnectedUserIDs()
			// 新客户端注册时执行函数
			CacheDb.Del("ConnectedUserIDs")
			CacheDb.Set("ConnectedUserIDs", UserIDs, 60*60)
		case client := <-h.unregister:
			h.mutex.Lock()
			if _, ok := h.clients[client]; ok {
				delete(h.clients, client)
				delete(h.userIDToClient, client.userID)
				close(client.send)

			}
			h.mutex.Unlock()
			// 客户端注销时执行函数
			UserIDs := h.GetConnectedUserIDs()
			CacheDb.Del("ConnectedUserIDs")
			CacheDb.Set("ConnectedUserIDs", UserIDs, 60*60)

		case message := <-h.broadcast:
			h.processMessage(message)

		case <-ticker.C:
			h.mutex.Lock()
			h.checkClientConnections()
			h.mutex.Unlock()
		}
	}
}

// 新建一个处理消息的函数用来减少在主函数链接中的代码污染
func (h *Hub) processMessage(message []byte) {
	h.mutex.Lock()
	defer h.mutex.Unlock()
	for client := range h.clients {
		if bytes.HasPrefix(message, []byte("/pm")) {
			pmMessage := bytes.TrimPrefix(message, []byte("/pm "))
			parts := bytes.SplitN(pmMessage, []byte(" "), 2)
			if len(parts) == 2 {
				userID := string(parts[0])
				msg := parts[1]

				if client.userID == userID {
					select {
					case client.send <- msg:
					default:
					}
				}
			} else {
				handleError("无效的私聊消息格式")
			}
		} else {
			select {
			case client.send <- message:
			default:
				close(client.send)
				delete(h.clients, client)
				delete(h.userIDToClient, client.userID)
			}
		}
	}
}

func (h *Hub) checkClientConnections() {
	for client := range h.clients {
		if atomic.LoadInt32(&client.isReading) == 0 {
			delete(h.clients, client)
			delete(h.userIDToClient, client.userID)
			close(client.send)
		}
	}
}
func (h *Hub) handleHeartbeat() {
	for {
		time.Sleep(heartbeatPeriod)

		h.mutex.Lock()
		for client := range h.clients {
			select {
			case client.send <- []byte("heartbeat"):
			default:
				close(client.send)
				delete(h.clients, client)
				delete(h.userIDToClient, client.userID)
			}
		}
		h.mutex.Unlock()
	}
}

func handleError(errMsg string) {
	fmt.Println("error:", errMsg)
	return
}
