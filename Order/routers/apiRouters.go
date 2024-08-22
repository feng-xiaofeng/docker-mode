package routers

import (
	"Order/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{

		wxapiRouters.GET("/order/add", api.OrderController{}.Add)
		wxapiRouters.POST("/order/doAdd", api.OrderController{}.DoAdd)
		wxapiRouters.GET("/order/getCount", api.OrderController{}.GetCount)
		wxapiRouters.GET("/order/getOrderGoods", api.OrderController{}.GetOrderGoods)
		wxapiRouters.GET("/order/delete", api.OrderController{}.Delete)
	}
}
