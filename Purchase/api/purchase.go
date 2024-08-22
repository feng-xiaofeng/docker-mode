package api

import (
	"Purchase/models"
	"fmt"
	"net/http"
	"strings"
	"sync"

	"github.com/gin-gonic/gin"
)

type PurchaseController struct{}

var wg sync.WaitGroup

func (con PurchaseController) Add(c *gin.Context) {
	goodsId, err := models.Int(c.Query("goods_id"))
	checked, err1 := models.Int(c.Query("checked"))
	if checked == 0 && err1 != nil && err != nil {
		return
	}
	goods := models.Goods{Id: goodsId}

	models.DB.Find(&goods)
	goods.Checked = checked
	err2 := models.DB.Save(&goods).Error
	if err2 != nil {
		fmt.Println("修改数据失败")
	} else {
		fmt.Println("修改数据成功")
	}
	c.JSON(http.StatusOK, gin.H{
		"purchaseGodos": goods,
	})
}
func (con PurchaseController) DoEdit(c *gin.Context) {
	goodsId, _ := models.Int(c.PostForm("goods_id"))
	goodsSate, _ := models.Int(c.PostForm("goods_sate"))
	checked, _ := models.Int(c.PostForm("checked"))
	goods := models.Goods{Id: goodsId}
	models.DB.Find(&goods)
	if checked == 1 || checked == 4 {
		goods.GoodsSate = goodsSate
		goods.Checked = checked
		err := models.DB.Save(&goods).Error
		if err != nil {
			fmt.Println("修改数据失败")
		} else {
			fmt.Println("修改数据成功")

		}
	}

}

func (con PurchaseController) DoEditChecked(c *gin.Context) {
	goodsId, err1 := models.Int(c.PostForm("goods_id"))
	checked, err2 := models.Int(c.PostForm("checked"))
	fmt.Println(checked)
	fmt.Println(goodsId)
	if err1 != nil || err2 != nil {
		fmt.Println(err1, err2)
		return
	}
	goods := models.Goods{Id: goodsId}
	models.DB.Find(&goods)
	if checked == 1 {
		goods.AddTime = int(models.GetUnix())
	}
	goods.Checked = checked
	err := models.DB.Save(&goods).Error
	if err != nil {
		fmt.Println("修改数据失败")
		return
	} else {
		fmt.Println("修改数据成功")

		c.JSON(http.StatusOK, gin.H{
			"returnChecked": goods,
		})

	}

}
func (con PurchaseController) Delete(c *gin.Context) {
	id, err1 := models.Int(c.Query("goods_id"))
	user_id, err2 := models.Int(c.Query("user_id"))
	if err1 != nil && err2 != nil {
		fmt.Println("传入数据错误", err1, err2)
	} else {
		//获取我们要删除的数据
		goods := models.Goods{Id: id}
		models.DB.Find(&goods)

		goodsImage := []models.GoodsImage{}
		models.DB.Where("goods_id", id).Delete(&goodsImage)
		models.DB.Delete(&goods)
		fmt.Println("--------------------goods", goods)
		getGoods := []models.Goods{}
		models.DB.Where("user_id", user_id).Find(&getGoods)
		c.JSON(http.StatusOK, gin.H{
			"getGoods": getGoods,
		})

	}
}

func (con PurchaseController) Modification(c *gin.Context) {
	goodsId, err1 := models.Int(c.Query("goods_id"))
	// user_id, err2 := models.Int(c.Query("user_id"))
	fmt.Println(goodsId)
	if err1 != nil {
		fmt.Println(err1)
		return
	} else {
		goods := models.Goods{Id: goodsId}
		models.DB.Find(&goods)
		goodsImage := []models.GoodsImage{}
		models.DB.Where("goods_id", goodsId).Find(&goodsImage)
		c.JSON(http.StatusOK, gin.H{
			"userGoods":  goods,
			"goodsImage": goodsImage,
		})

	}

}
func (con PurchaseController) DoEditModification(c *gin.Context) {
	var str_arr []string
	goods_id, err1 := models.Int(c.PostForm("goods_id"))
	if err1 != nil {
		fmt.Println(err1)
		return
	}
	typeId, err2 := models.Int(c.PostForm("type_id"))
	goodsPrice, err3 := models.Float(c.PostForm("goods_price"))
	state, _ := models.Float(c.PostForm("state"))

	goodsState := c.PostForm("goods_state")
	goodsName := c.PostForm("goods_name")
	checked, err4 := models.Int(c.PostForm("checked"))
	goodsImageList := c.PostForm("images_list")
	if len(goodsImageList) > 0 {
		str_arr = strings.Split(goodsImageList, `,`)
	}

	fmt.Println("str_arr", str_arr)
	fmt.Println("str_arr", len(str_arr))
	if str_arr == nil {
		fmt.Println("---------------")
	}
	if err2 != nil && err3 != nil && err4 != nil {
		fmt.Println(err2)
		return
	} else {
		goods := models.Goods{Id: goods_id}
		models.DB.Find(&goods)
		goods.AddTime = int(models.GetUnix())
		goods.Checked = checked
		goods.GoodsTypeId = typeId
		goods.Title = goodsName
		goods.GoodsDetails = goodsState
		goods.Price = goodsPrice
		if len(goodsImageList) > 0 {
			goods.FirstImage = str_arr[0]
		}

		err := models.DB.Save(&goods).Error
		if err != nil {
			fmt.Println(err)
			return
		}

		if state == 1 {
			goodsImage := []models.GoodsImage{}
			models.DB.Where("Goods_id", goods.Id).Delete(&goodsImage)
			//5、增加图库 信息
			wg.Add(1)
			go func() {

				for _, v := range str_arr {
					goodsImgObj := models.GoodsImage{}
					goodsImgObj.GoodsId = goods.Id
					goodsImgObj.ImgUrl = v
					goodsImgObj.Status = 1
					goodsImgObj.AddTime = int(models.GetUnix())
					models.DB.Create(&goodsImgObj)
				}

				wg.Done()
			}()
		}

		c.JSON(http.StatusOK, gin.H{
			"getGoods": goods,
		})
	}
}
