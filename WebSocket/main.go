// go build main.go
package main

import (
	"WebSocket/models"
	"log"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"
)

// 初始化配置文件

func main() {
	// 创建一个默认的路由引擎
	r := gin.Default()

	// 创建基于 cookie 的存储引擎，secret11111 参数是用于加密的密钥
	store := cookie.NewStore([]byte("secret111"))
	//配置session的中间件 store是前面创建的存储引擎，我们可以替换成其他存储引擎
	r.Use(sessions.Sessions("mysession", store))
	// r.Use(middleware.CORSMiddleware())
	hub := models.NewHub()
	go hub.Rrun()
	r.GET("/ws", hub.ServeWs)

	err := r.Run(":9000")
	if err != nil {
		log.Fatal(err)
	}
}
