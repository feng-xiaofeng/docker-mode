package routers

import (
	"School/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{

		wxapiRouters.GET("/detailed/add", api.DetailedController{}.Add)
		wxapiRouters.GET("/perslnfo/dstrSchool", api.DetailedController{}.DstrSchool)
		wxapiRouters.GET("/perslnfo/userSchoolId", api.DetailedController{}.UserSchoolId)
	}
}
