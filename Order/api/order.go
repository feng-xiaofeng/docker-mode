package api

import (
	"Order/models"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type OrderController struct{}

func (con OrderController) Add(c *gin.Context) {
	goodsId, err := models.Int(c.Query("goods_id"))
	fmt.Println(goodsId)
	if err != nil {
		fmt.Println(err)
		return
	}
	goods := models.Goods{Id: goodsId}
	models.DB.Preload("User").Find(&goods)

	c.JSON(http.StatusOK, gin.H{
		"goods": goods,
	})

}

func (con OrderController) DoAdd(c *gin.Context) {
	goodsId, err1 := models.Int(c.PostForm("goods_id"))
	checked, err2 := models.Int(c.PostForm("checked"))
	userId, err3 := models.Int(c.PostForm("user_id"))
	sellerId, _ := models.Int(c.PostForm("seller_id"))
	price, _ := models.Float(c.PostForm("price"))
	goodsName := c.PostForm("goods_name")
	schoolName := c.PostForm("school_name")
	goodsImage := c.PostForm("goods_image")
	remark := c.PostForm("remark")

	if err1 != nil && err2 != nil && err3 != nil {
		fmt.Println(err1)
		return
	}
	goods := models.Goods{Id: goodsId}
	models.DB.Find(&goods)
	goods.Checked = checked
	err := models.DB.Save(&goods).Error
	if err != nil {
		fmt.Println("修改数据失败")
	} else {
		fmt.Println("修改数据成功")

	}
	order := models.Order{
		UserId:      userId,
		Price:       price,
		GoodsName:   goodsName,
		GoodsImage:  goodsImage,
		SchoolName:  schoolName,
		Remark:      remark,
		SellerId:    sellerId,
		AddTime:     int(models.GetUnix()),
		OrderNumber: models.GetOrderId(),
		Checked:     1,
		GoodsId:     goodsId,
	}
	err5 := models.DB.Create(&order).Error
	if err5 != nil {
		fmt.Println(err5)
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"goods": goods,
	})
}

func (con OrderController) GetCount(c *gin.Context) {
	var all int
	var checked1 int
	var checked2 int
	userId, err := models.Int(c.Query("id"))
	fmt.Println("-------------", userId)
	if err != nil {
		fmt.Println(err)
		return
	}
	order := []models.Order{}
	models.DB.Where("user_id", userId).Find(&order)
	for i := 0; i < len(order); i++ {
		if order[i].Checked == 1 {
			checked1++
		}
		if order[i].Checked == 2 {
			checked2++
		}
		all++
	}
	fmt.Println("-----------------------", order)

	c.JSON(http.StatusOK, gin.H{
		"all":      all,
		"checked1": checked1,
		"checked2": checked2,
	})

}

func (con OrderController) GetOrderGoods(c *gin.Context) {

	userId, err1 := models.Int(c.Query("user_id"))
	checked, err2 := models.Int(c.Query("checked"))
	if err1 != nil && err2 != nil {
		fmt.Println(err1)
		return
	}
	order := []models.Order{}
	if checked == 0 {
		models.DB.Where("user_id=?", userId).Preload("User").Find(&order)
		c.JSON(http.StatusOK, gin.H{
			"getOrderGoods": order,
		})
	} else {
		models.DB.Where("checked=? AND user_id=?", checked, userId).Preload("User").Find(&order)
		c.JSON(http.StatusOK, gin.H{
			"getOrderGoods": order,
		})
	}

}
func (con OrderController) Delete(c *gin.Context) {
	orderId, err1 := models.Int(c.Query("order_id"))
	userId, err2 := models.Int(c.Query("user_id"))
	// GoodsId, _ := models.Int(c.Query("goods_id"))
	if err1 != nil && err2 != nil {
		fmt.Println("传入数据错误", err1, err2)
	} else {
		//获取我们要删除的数据
		order := models.Order{Id: orderId}
		models.DB.Find(&order)

		models.DB.Delete(&order)
		getOrder := []models.Order{}
		fmt.Println(userId)
		models.DB.Where("user_id", userId).Find(&getOrder)
		fmt.Println("---------------", getOrder)
		c.JSON(http.StatusOK, gin.H{
			"getOrderGoods": getOrder,
		})

	}
}
