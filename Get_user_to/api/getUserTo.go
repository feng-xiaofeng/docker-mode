package api

import (
	"Get_user_to/models"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetUserTo(c *gin.Context) {
	userTo := c.Query("user_to")
	user := models.User{}
	models.DB.Where("id=?", userTo).Find(&user)
	fmt.Println(user)
	c.JSON(http.StatusOK, gin.H{
		"user": user,
	})
}
