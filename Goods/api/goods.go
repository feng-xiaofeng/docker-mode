package api

import (
	"Goods/models"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type GoodsController struct {
}

func (con GoodsController) UserIssue(c *gin.Context) {
	var number int
	var checkedTrue int
	var checkedFalse int
	var checkedTrading int
	id, err1 := models.Int(c.Query("id"))
	if err1 != nil {
		panic(err1)
	}

	user := models.User{}
	models.DB.Where("id=?", id).Find(&user)
	fmt.Println(user)
	userPutawayGodos := []models.Goods{}
	models.DB.Where("user_id=?", user.Id).Find(&userPutawayGodos)

	for i := 0; i < len(userPutawayGodos); i++ {
		if userPutawayGodos[i].Checked == 1 {
			checkedTrue++
		} else if userPutawayGodos[i].Checked == 2 {
			checkedFalse++
		} else if userPutawayGodos[i].Checked == 3 {
			checkedTrading++
		}
		number++

	}
	c.JSON(http.StatusOK, gin.H{
		"number":         number,
		"checkedTrue":    checkedTrue,
		"checkedFalse":   checkedFalse,
		"checkedTrading": checkedTrading,
	})
}

func (con GoodsController) DoUserIssue(c *gin.Context) {
	user_id, err1 := models.Int(c.Query("user_id"))
	checked, err2 := models.Int(c.Query("checked"))
	fmt.Println("--------------", user_id)
	fmt.Println(checked)
	if err1 != nil || err2 != nil {
		fmt.Println(err1, err2)
		return
	} else {
		goods := []models.Goods{}
		if checked == 0 {
			models.DB.Where("user_id=?", user_id).Find(&goods)
		} else {
			models.DB.Where("user_id=? AND checked=?", user_id, checked).Find(&goods)
		}
		c.JSON(http.StatusOK, gin.H{
			"getUserGoods": goods,
		})
	}

}
