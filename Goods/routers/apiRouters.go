package routers

import (
	"Goods/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{

		wxapiRouters.GET("/goods/userIssue", api.GoodsController{}.UserIssue)
		wxapiRouters.GET("/goods/doUserIssue", api.GoodsController{}.DoUserIssue)

	}
}
