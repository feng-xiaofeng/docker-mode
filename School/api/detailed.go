package api

import (
	"School/models"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type DetailedController struct {
}

func (con DetailedController) Add(c *gin.Context) {
	var id, _ = models.Int(c.Query("id"))
	goods := models.Goods{}
	models.DB.Where("id=?", id).Find(&goods)
	goodImage := []models.GoodsImage{}
	models.DB.Where("goods_id=?", id).Find(&goodImage)
	c.JSON(http.StatusOK, gin.H{
		"goods":     goods,
		"goodImage": goodImage,
	})
}

func (con DetailedController) DstrSchool(c *gin.Context) {
	school := []models.School{}
	models.DB.Find(&school)
	// for i, s := range school {
	// 	fmt.Println(i, s.Id, s.Status, s.SchoolName)
	// 	mp[i] := {s.Id, s.Status, s.SchoolName }
	// }
	fmt.Println(school)
	c.JSON(http.StatusOK, gin.H{
		"school": school,
	})
}

func (con DetailedController) UserSchoolId(c *gin.Context) {
	userSchoolId, err := models.Int(c.Query("school_id"))
	if err != nil {
		fmt.Printf("Id接收错误")
		return
	} else {
		fmt.Println(userSchoolId)
	}

}
