package routers

import (
	"Users/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{

		wxapiRouters.POST("/users/getUsers", api.UserController{}.GetUser)
		wxapiRouters.POST("/users/doAdd", api.UserController{}.DoAdd)
		wxapiRouters.POST("/users/doEdit", api.UserController{}.DoEdit)

	}
}
