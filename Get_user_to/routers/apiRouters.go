package routers

import (
	"Get_user_to/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{

		wxapiRouters.GET("/getUserTo", api.GetUserTo)
	}
}
