package api

import (
	"Images_api/models"
	"fmt"
	"net/http"
	"sync"

	"github.com/gin-gonic/gin"
)

var wg sync.WaitGroup

type ImagesController struct {
}

// 图库上传图片
func (con ImagesController) UploadImage(c *gin.Context) {
	//上传图片

	imgDir, _ := models.UploadImg(c, "file") //注意：可以在网络里面看到传递的参数
	c.JSON(http.StatusOK, gin.H{
		"imgDir": imgDir,
	})

}
func (con ImagesController) AvatarUploadImage(c *gin.Context) {
	//上传图片

	imgDir, _ := models.LocalAvatarUploadImg(c, "file") //注意：可以在网络里面看到传递的参数
	c.JSON(http.StatusOK, gin.H{
		"imgDir": imgDir,
	})

}
func (con ImagesController) CompressUploadImage(c *gin.Context) {
	//上传图片
	YSimgDir, _ := models.CompressUploadImg(c, "file") //注意：可以在网络里面看到传递的参数
	c.JSON(http.StatusOK, gin.H{

		"YSimgDir": YSimgDir,
	})

}

func (con ImagesController) ContaactCompressImage(c *gin.Context) {
	//上传图片
	filePath := c.Query("file_path")
	wg.Add(1)
	go func() {
		defer wg.Done()
		compressImg, imgErr := models.CompressImg(filePath, 50, 4)
		if imgErr != nil {
			fmt.Println("图片解压失败：", imgErr)
			return
		}
		c.JSON(http.StatusOK, gin.H{
			"YSimgDir": compressImg,
		})

	}()
	wg.Wait()

}

// func (con ReleaseController) CompressUploadImage(c *gin.Context) {
// 	//上传图片

// 	YSimgDir, _ := models.CompressUploadImg(c, "file") //注意：可以在网络里面看到传递的参数
// 	c.JSON(http.StatusOK, gin.H{

// 		"YSimgDir": YSimgDir,
// 	})

// }

// if err != nil {
// 	c.JSON(http.StatusOK, gin.H{
// 		"link": "",
// 	})
// } else {
// 	if models.GetOssStatus() != 1 {
// 		wg.Add(1)
// 		go func() {
// 			models.ResizeGoodsImage(imgDir)
// 			wg.Done()
// 		}()

// 	}
// 	c.JSON(http.StatusOK, gin.H{
// 		"link": imgDir,
// 	})

// }
