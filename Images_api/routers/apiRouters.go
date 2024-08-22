package routers

import (
	"Images_api/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{
		wxapiRouters.POST("/images/uploadImage", api.ImagesController{}.UploadImage)
		wxapiRouters.POST("/images/avatarUploadImage", api.ImagesController{}.AvatarUploadImage)
		wxapiRouters.POST("/images/compressUploadImage", api.ImagesController{}.CompressUploadImage)
		wxapiRouters.GET("/images/contaactCompressImage", api.ImagesController{}.ContaactCompressImage)

	}
}
