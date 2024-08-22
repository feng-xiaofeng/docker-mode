package main

import (
	"log"
	"sync"

	"School/routers"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"
)

var wg sync.WaitGroup

func main() {
	// 创建一个默认的路由引擎
	r := gin.Default()

	store := cookie.NewStore([]byte("secret111"))
	//配置session的中间件 store是前面创建的存储引擎，我们可以替换成其他存储引擎
	r.Use(sessions.Sessions("mysession", store))
	// r.Use(middleware.CORSMiddleware())
	wg.Add(1)
	go func() {
		routers.ApiRoutersInit(r)
	}()

	err := r.Run(":8089")
	if err != nil {
		log.Fatal(err)
	}
}
