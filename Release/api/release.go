package api

import (
	"Release/models"
	"fmt"
	"net/http"
	"strings"
	"sync"

	"github.com/gin-gonic/gin"
)

var wg sync.WaitGroup

type ReleaseController struct {
}

func (con ReleaseController) Index(c *gin.Context) {
	goodsType := []models.GoodsType{}
	models.DB.Where("module_id=?", 2).Find(&goodsType)
	c.JSON(http.StatusOK, gin.H{
		"goodsType": goodsType,
	})
}

func (con ReleaseController) DoAdd(c *gin.Context) {
	module_id, _ := models.Int(c.PostForm("goods_id"))
	goods_title := c.PostForm("goods_name")
	goods_price, _ := models.Float(c.PostForm("goods_price"))
	goods_details := c.PostForm("goods_state")
	checked, _ := models.Int(c.PostForm("chec_ked"))
	goodsImageList := c.PostForm("images_list")
	str_arr := strings.Split(goodsImageList, `,`)
	type_id, _ := models.Int(c.PostForm("type_id"))
	userId, _ := models.Int(c.PostForm("user_id"))
	schoolId, _ := models.Int(c.PostForm("school_id"))

	fmt.Println("str_arr", str_arr)

	if userId <= 0 && schoolId <= 0 {
		fmt.Println("用户未登录！")
	} else {

		goods := models.Goods{
			Title:        goods_title,
			Price:        goods_price,
			ModuleId:     module_id,
			GoodsDetails: goods_details,
			Checked:      checked,
			AddTime:      int(models.GetUnix()),
			FirstImage:   str_arr[0],
			UserId:       userId,
			SchoolId:     schoolId,
			GoodsTypeId:  type_id,
		}
		err := models.DB.Create(&goods).Error
		if err != nil {
			fmt.Println(err)
		}
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

}
