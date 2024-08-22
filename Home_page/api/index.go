package api

import (
	"fmt"
	"math"
	"math/rand"
	"net/http"
	"os"
	"strconv"

	"Home_page/models"

	"github.com/gin-gonic/gin"
	"gopkg.in/ini.v1"
)

type WxController struct {
}

func (con WxController) Index(c *gin.Context) {
	config, iniErr := ini.Load("./conf/app.ini")
	if iniErr != nil {
		fmt.Printf("Fail to read file: %v", iniErr)
		os.Exit(1)
	}
	var connectedUserIDs []string
	if hasConnectedUserIDs := models.CacheDb.Get("ConnectedUserIDs", &connectedUserIDs); !hasConnectedUserIDs {
		fmt.Println("ConnectedUserIDs 数据错误")
	}
	fmt.Println("1111", connectedUserIDs)
	pageSize, _ := models.Int(config.Section("indelsPageCount").Key("pageSize").String())

	id := c.Query("id")
	// 将页码从查询字符串中获取, 如果没有提供则默认为1
	page, _ := strconv.Atoi(c.DefaultQuery("page", "1"))
	// pageSize,_ := models.Int(c.Query("limit"))``

	// 获取用户，并根据用户所在学校查询出对应商品
	user := models.User{}
	models.DB.Where("id = ?", id).Find(&user)

	var total int64
	goods := []models.Goods{}

	// 查询总记录数以计算总页数
	if user.SchoolId <= 0 {
		models.DB.Model(&models.Goods{}).Where("checked=?", 1).Count(&total)
		models.DB.Where("checked=?", 1).Offset((page - 1) * pageSize).Limit(pageSize).Order("id desc").Preload("User").Find(&goods)
	} else {
		models.DB.Model(&models.Goods{}).Where("checked=1 AND school_id=?", user.SchoolId).Count(&total)
		models.DB.Where("checked=1 AND school_id=?", user.SchoolId).Offset((page - 1) * pageSize).Limit(pageSize).Order("id desc").Preload("User").Find(&goods)
	}

	totalPages := int(math.Ceil(float64(total) / float64(pageSize)))

	// rand.Seed(time.Now().Unix())
	//采用rand.Shuffle，将切片随机化处理后返回
	rand.Shuffle(len(goods), func(i, j int) { goods[i], goods[j] = goods[j], goods[i] })

	c.JSON(http.StatusOK, gin.H{
		"goods":           goods,
		"currentPage":     page,
		"totalPages":      totalPages,
		"onnectedUserIDs": connectedUserIDs,
	})
}
func (con WxController) TypeIdIndex(c *gin.Context) {
	var where string
	typeId, _ := models.Int((c.Query("type_id")))
	user_id, err1 := models.Int(c.Query("user_id"))
	fmt.Println(user_id)
	if err1 != nil {
		fmt.Println(err1)
		return
	}

	user := models.User{}
	models.DB.Where("id=?", user_id).Find(&user)

	goods := []models.Goods{}
	userId := models.String(user.SchoolId)
	if user.SchoolId == 0 {
		where = "checked=1"
	} else {
		where = "checked=1 AND school_id=" + userId
	}

	if typeId == 3 {
		models.DB.Where(where).Preload("User").Find(&goods)
	} else {
		goodsTypeId := models.String(typeId)
		where += " AND goods_type_id=" + goodsTypeId
		models.DB.Where(where).Order("add_time desc").Preload("User").Find(&goods)
	}

	c.JSON(http.StatusOK, gin.H{
		"goods": goods,
	})
}
func (con WxController) SearchGoods(c *gin.Context) {
	search := c.Query("search")
	signature := c.Query("signature")
	user := models.User{}
	models.DB.Where("signature=?", signature).Find(&user)
	userId := models.String(user.SchoolId)
	where := "checked=1 AND school_id=" + userId
	if len(search) > 0 {
		where += " AND title like \"%" + search + "%\""
		goods := []models.Goods{}
		models.DB.Where(where).Order("add_time desc").Preload("User").Find(&goods)
		c.JSON(http.StatusOK, gin.H{
			"searchGoods": goods,
		})
	}
}
