package routers

import (
	"Goods_type/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{

		wxapiRouters.GET("/goodsType", api.WxGoodsType{}.GoodsType)
	}
}
