// go build main.go
package main

import (
	"Images_api/routers"
	"log"
	"sync"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"
)

var wg sync.WaitGroup

// 初始化配置文件

func main() {
	// 创建一个默认的路由引擎
	r := gin.Default()
	//配置静态web目录   第一个参数表示路由, 第二个参数表示映射的目录
	r.Static("/images", "../images")
	store := cookie.NewStore([]byte("secret111"))
	//配置session的中间件 store是前面创建的存储引擎，我们可以替换成其他存储引擎
	r.Use(sessions.Sessions("mysession", store))
	// r.Use(middleware.CORSMiddleware())
	wg.Add(1)
	go func() {

		routers.ApiRoutersInit(r)

		wg.Done()
	}()

	err := r.Run(":8089")
	if err != nil {
		log.Fatal(err)
	}
}
