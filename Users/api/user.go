package api

import (
	"Users/models"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type UserController struct{}

func (con UserController) GetUser(c *gin.Context) {
	id, err1 := models.Int(c.PostForm("id"))
	fmt.Println(id)
	if err1 != nil {
		fmt.Println(err1.Error())

	}
	user := models.User{}
	models.DB.Where("id=?", id).Find(&user)
	userSchool := models.School{}
	models.DB.Where("id=?", user.SchoolId).Find(&userSchool)
	fmt.Println(user)
	c.JSON(http.StatusOK, gin.H{
		"user":        user,
		"user_school": userSchool,
	})

}

func (con UserController) DoAdd(c *gin.Context) {
	user_name := c.PostForm("user_name")
	signature := c.PostForm("signature")
	avatar_url := c.PostForm("avatar_url")
	if signature == "" {
		fmt.Println("接收不到")
		return
	}
	user := []models.User{}
	models.DB.Where("signature", signature).Find(&user)
	if len(user) == 0 {
		user := models.User{
			UserName:  user_name,
			Signature: signature,
			AvatarUrl: avatar_url,
			AddTime:   int(models.GetUnix()),
		}
		err := models.DB.Create(&user).Error
		if err != nil {
			fmt.Println(err)
		}
		fmt.Println(user)
		c.JSON(http.StatusOK, gin.H{
			"user": user,
		})

	}

	for i := 0; i < len(user); i++ {
		c.JSON(http.StatusOK, gin.H{
			"user": user[0],
		})
	}

	fmt.Println(user)
}
func (con UserController) DoEdit(c *gin.Context) {
	userName := c.PostForm("user_name")
	id, err1 := models.Int(c.PostForm("id"))
	avatarUrl := c.PostForm("avatar_url")

	if err1 != nil {
		fmt.Println("接收不到")
		return
	}
	schoolId, _ := models.Int(c.PostForm("school_id"))
	school_name := c.PostForm("school_name")
	userPhone := c.PostForm("user_phone")
	user := models.User{Id: id}
	models.DB.Find(&user)
	if schoolId > 0 {
		user.SchoolId = schoolId
	}
	if userPhone != "" {
		user.UserPhone = userPhone
	}
	if userName != "" {
		user.UserName = userName
	}
	if avatarUrl != "" {
		user.AvatarUrl = avatarUrl
	}
	if school_name != "" {
		user.SchoolName = school_name
	}

	err := models.DB.Save(&user).Error
	if err != nil {
		fmt.Println("修改数据失败！", err)
	} else {
		fmt.Println("修改数据成功！")
	}
	fmt.Println(user)
	c.JSON(http.StatusOK, gin.H{
		"user": user,
	})
}
