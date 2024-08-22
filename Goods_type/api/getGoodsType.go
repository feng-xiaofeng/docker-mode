package api

import (
	"Goods_type/models"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type WxGoodsType struct {
}

func (con WxGoodsType) GoodsType(c *gin.Context) {
	goodsType := []models.GoodsType{}
	if hasGoodsTypeList := models.CacheDb.Get("goodsTypeList", &goodsType); !hasGoodsTypeList {
		models.DB.Where("module_id=?", 2).Order("sort").Find(&goodsType)
		fmt.Println("11")
		models.CacheDb.Set("goodsTypeList", goodsType, 60*60)
	}

	c.JSON(http.StatusOK, gin.H{
		"goodsType": goodsType,
	})
}
