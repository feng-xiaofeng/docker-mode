package routers

import (
	"Release/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{

		wxapiRouters.POST("/release", api.ReleaseController{}.Index)
		wxapiRouters.POST("/release/doAdd", api.ReleaseController{}.DoAdd)
	}
}
