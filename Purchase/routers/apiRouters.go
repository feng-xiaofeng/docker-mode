package routers

import (
	"Purchase/api"

	"github.com/gin-gonic/gin"
)

func ApiRoutersInit(r *gin.Engine) {
	wxapiRouters := r.Group("/api")
	{

		wxapiRouters.GET("/purchase/add", api.PurchaseController{}.Add)
		wxapiRouters.POST("/purchase/doEdit", api.PurchaseController{}.DoEdit)
		wxapiRouters.POST("/purchase/doEditChecked", api.PurchaseController{}.DoEditChecked)
		wxapiRouters.GET("/purchase/modification", api.PurchaseController{}.Modification)
		wxapiRouters.POST("/purchase/doEditModification", api.PurchaseController{}.DoEditModification)
		wxapiRouters.GET("/purchase/addgoods", api.PurchaseController{}.Delete)
		wxapiRouters.GET("/purchase/delete", api.PurchaseController{}.Delete)
	}
}
