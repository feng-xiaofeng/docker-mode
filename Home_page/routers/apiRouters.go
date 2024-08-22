package routers

import (
	"Home_page/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{

		wxapiRouters.GET("/", api.WxController{}.Index)
		wxapiRouters.GET("/typeIdIndex", api.WxController{}.TypeIdIndex)
		wxapiRouters.GET("/searchGoods", api.WxController{}.SearchGoods)

	}
}
