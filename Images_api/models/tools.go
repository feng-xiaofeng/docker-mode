package models

import (
	"errors"
	"fmt"
	"image"
	"image/jpeg"
	"log"
	"mime/multipart"
	"os"
	"path"
	"path/filepath"
	"reflect"
	"strconv"
	"time"

	"github.com/aliyun/aliyun-oss-go-sdk/oss"
	"github.com/gin-gonic/gin"
	"github.com/nfnt/resize"
	"gopkg.in/ini.v1"
)

type Setting struct{}

// 表示把string转换成int
func Int(str string) (int, error) {
	n, err := strconv.Atoi(str)
	return n, err
}

// 表示把int转换成string
func String(n int) string {
	str := strconv.Itoa(n)
	return str
}

// 表示把string转换成Float64
func Float(str string) (float64, error) {
	n, err := strconv.ParseFloat(str, 64)
	return n, err
}

// 获取时间戳
func GetUnix() int64 {
	return time.Now().Unix()
}

// 获取年月日
func GetDay() string {
	template := "20060102"
	return time.Now().Format(template)
}

// 获取纳秒
func GetUnixNano() int64 {
	return time.Now().UnixNano()
}

// 通过列获取值
func GetSettingFromColumn(columnName string) string {
	//redis file
	setting := Setting{}
	DB.First(&setting)
	//反射来获取
	v := reflect.ValueOf(setting)
	val := v.FieldByName(columnName).String()
	return val
}

// 获取Oss的状态
func GetOssStatus() int {
	config, iniErr := ini.Load("./conf/app.ini")
	if iniErr != nil {
		fmt.Printf("Fail to read file: %v", iniErr)
		os.Exit(1)
	}
	ossStatus, _ := Int(config.Section("oss").Key("status").String())
	return ossStatus
}

// 格式化输出图片
func FormatImg(str string) string {
	ossStatus := GetOssStatus()
	// fmt.Println(ossStatus)
	if ossStatus == 1 {
		return GetSettingFromColumn("OssDomain") + str
	} else {
		return "/" + str
	}
}

// Oss上传
func OssUplod(file *multipart.FileHeader, dst string) (string, error) {

	f, err := file.Open()
	if err != nil {
		return "", err
	}
	defer f.Close()

	// 创建OSSClient实例。
	client, err := oss.New("oss-cn-beijing.aliyuncs.com", "LTAI5tLwjFeu3UR15kbs8UK3", "BLYxwebOfiUoEUvkBZpt00BpuLltTq")
	if err != nil {
		return "", err
	}

	// 获取存储空间。
	bucket, err := client.Bucket("weixinxiaochengxguangguang")
	if err != nil {
		return "", err
	}

	// 上传文件流。
	err = bucket.PutObject(dst, f)
	if err != nil {
		return "", err
	}
	return dst, nil
}

// 上传图片
func UploadImg(c *gin.Context, picName string) (string, error) {
	ossStatus := GetOssStatus()

	if ossStatus == 1 {
		return OssUploadImg(c, picName)
	} else {
		return LocalUploadImg(c, picName)
	}

}

// 上传图片到Oss
func OssUploadImg(c *gin.Context, picName string) (string, error) {
	// 1、获取上传的文件
	file, err := c.FormFile(picName)
	if err != nil {
		return "", err
	}

	// 2、获取后缀名 判断类型是否正确  .jpg .png .gif .jpeg
	extName := path.Ext(file.Filename)
	allowExtMap := map[string]bool{
		".jpg":  true,
		".png":  true,
		".gif":  true,
		".jpeg": true,
	}

	if _, ok := allowExtMap[extName]; !ok {
		return "", errors.New("文件后缀名不合法")
	}

	// 3、定义图片保存目录  static/upload/20210624

	day := GetDay()
	dir := "/images/goods_images/" + day

	// 4、生成文件名称和文件保存的目录   111111111111.jpeg
	fileName := strconv.FormatInt(GetUnixNano(), 20) + extName

	// 5、执行上传
	dst := path.Join(dir, fileName)
	fmt.Println("dst", dst)

	OssUplod(file, dst)
	return dst, nil

}

// 压缩并保存照片
func CompressUploadImg(c *gin.Context, picName string) (string, error) {
	// 1、获取上传的文件
	file, err := c.FormFile(picName)
	if err != nil {
		return "", err
	}

	// 2、获取后缀名 判断类型是否正确  .jpg .png .gif .jpeg
	extName := path.Ext(file.Filename)

	allowExtMap := map[string]bool{
		".jpg":  true,
		".png":  true,
		".gif":  true,
		".jpeg": true,
	}

	if _, ok := allowExtMap[extName]; !ok {
		return "", errors.New("文件后缀名不合法")
	}

	// 3、创建图片保存目录  static/upload/20210624

	day := GetDay()
	dir := "./images/compress_images/" + day

	err1 := os.MkdirAll(dir, 0666)
	if err1 != nil {
		fmt.Println(err1)
		return "", err1
	}

	// 4、生成文件名称和文件保存的目录   111111111111.jpeg
	fileName := strconv.FormatInt(GetUnixNano(), 20) + extName

	// 5、执行上传
	dst := path.Join(dir, fileName)
	c.SaveUploadedFile(file, dst)
	return dst, nil

}

// 压缩并保存照片
// func CompressImg(filePath string, quality, width int) (string, error) {
// 	// Open the file
// 	uploadedFile, err := os.Open(filePath)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}
// 	defer uploadedFile.Close()

// 	// Decode the image
// 	img, _, err := image.Decode(uploadedFile)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}

// 	// Set the target width
// 	originalWidth := img.Bounds().Max.X
// 	targetWidth := originalWidth / width

// 	// Calculate adaptive height
// 	originalHeight := img.Bounds().Max.Y
// 	targetHeight := (targetWidth * originalHeight) / originalWidth

// 	// Resize the image
// 	resizedImg := resize.Resize(uint(targetWidth), uint(targetHeight), img, resize.Lanczos3)

// 	extName := path.Ext(filePath)
// 	allowExtMap := map[string]bool{
// 		".jpg":  true,
// 		".png":  true,
// 		".gif":  true,
// 		".jpeg": true,
// 	}

// 	if _, ok := allowExtMap[extName]; !ok {
// 		return "", errors.New("Invalid file extension")
// 	}

// 	// Generate file name and directory for saving the file
// 	fileName := strconv.FormatInt(GetUnixNano(), 20) + extName

// 	day := GetDay()
// 	dir := "./static/compress_upload/" + day

// 	// Create directory
// 	err = os.MkdirAll(dir, 0755)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}

// 	dst := path.Join(dir, fileName)
// 	// Generate the output file path for the compressed image
// 	outputFile := dst

// 	// Create the destination file
// 	output, err := os.Create(outputFile)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}
// 	defer output.Close()

// 	// Save the compressed image in JPEG format to the destination file
// 	options := &jpeg.Options{
// 		Quality: quality,
// 	}
// 	err = jpeg.Encode(output, resizedImg, options)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}

// 	log.Println("Image compression completed")

// 	return outputFile, nil
// }

func CompressImg(filePath string, quality, width int) (string, error) {
	// Open the file
	uploadedFile, err := os.Open(filePath)
	if err != nil {
		log.Fatal(err)
		return "", err
	}
	defer uploadedFile.Close()

	// Decode the image
	img, _, err := image.Decode(uploadedFile)
	if err != nil {
		log.Fatal(err)
		return "", err
	}

	// Set the target width
	originalWidth := img.Bounds().Max.X
	targetWidth := originalWidth / width

	// Calculate adaptive height
	originalHeight := img.Bounds().Max.Y
	targetHeight := (targetWidth * originalHeight) / originalWidth

	// Resize the image
	resizedImg := resize.Resize(uint(targetWidth), uint(targetHeight), img, resize.Lanczos3)
	fileName := filePath[14:]
	dir := "./static/compress_images/"

	// Generate the output file path for the compressed image
	outputFile := path.Join(dir, fileName)

	// Create parent directory
	if err := os.MkdirAll(filepath.Dir(outputFile), 0755); err != nil {
		log.Fatal(err)
		return "", err
	}

	// Create the destination file
	output, err := os.Create(outputFile)
	if err != nil {
		log.Fatal(err)
		return "", err
	}
	defer output.Close()

	// Save the compressed image in JPEG format to the destination file
	options := &jpeg.Options{
		Quality: quality,
	}
	err = jpeg.Encode(output, resizedImg, options)
	if err != nil {
		log.Fatal(err)
		return "", err
	}

	return outputFile, nil
}

// func CompressUploadImg(c *gin.Context, picName string) (string, error) {
// 	file, err := c.FormFile(picName)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}
// 	// Open the uploaded file
// 	uploadedFile, err := file.Open()
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}
// 	defer uploadedFile.Close()

// 	// 解码照片
// 	img, _, err := image.Decode(uploadedFile)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}

// 	// 设置目标宽度
// 	originalWidth := img.Bounds().Max.X
// 	targetWidth := originalWidth / 3

// 	// 计算高度自适应
// 	originalHeight := img.Bounds().Max.Y
// 	targetHeight := (targetWidth * originalHeight) / originalWidth

// 	// 压缩照片
// 	resizedImg := resize.Resize(uint(targetWidth), uint(targetHeight), img, resize.Lanczos3)

// 	extName := path.Ext(file.Filename)
// 	allowExtMap := map[string]bool{
// 		".jpg":  true,
// 		".png":  true,
// 		".gif":  true,
// 		".jpeg": true,
// 	}

// 	if _, ok := allowExtMap[extName]; !ok {
// 		return "", errors.New("文件后缀名不合法")
// 	}

// 	// 生成文件名称和文件保存的目录
// 	fileName := strconv.FormatInt(GetUnixNano(), 20) + extName

// 	day := GetDay()
// 	dir := "./static/compress_upload/" + day

// 	// 创建目录
// 	err = os.MkdirAll(dir, 0755)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}

// 	dst := path.Join(dir, fileName)
// 	// 生成压缩后的文件路径
// 	outputFile := dst

// 	// 创建目标文件
// 	output, err := os.Create(outputFile)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}
// 	defer output.Close()

// 	// 以 JPEG 格式保存压缩后的照片到目标文件
// 	options := &jpeg.Options{
// 		Quality: 50,
// 	}
// 	err = jpeg.Encode(output, resizedImg, options)
// 	if err != nil {
// 		log.Fatal(err)
// 		return "", err
// 	}
// 	return outputFile, nil

// }

// 上传图片到本地
func LocalUploadImg(c *gin.Context, picName string) (string, error) {
	// 1、获取上传的文件
	file, err := c.FormFile(picName)
	if err != nil {
		return "", err
	}

	// 2、获取后缀名 判断类型是否正确  .jpg .png .gif .jpeg
	extName := path.Ext(file.Filename)

	allowExtMap := map[string]bool{
		".jpg":  true,
		".png":  true,
		".gif":  true,
		".jpeg": true,
	}

	if _, ok := allowExtMap[extName]; !ok {
		return "", errors.New("文件后缀名不合法")
	}

	// 3、创建图片保存目录  static/upload/20210624

	day := GetDay()
	dir := "./images/goods_images/" + day

	err1 := os.MkdirAll(dir, 0666)
	if err1 != nil {
		fmt.Println(err1)
		return "", err1
	}

	// 4、生成文件名称和文件保存的目录   111111111111.jpeg
	fileName := strconv.FormatInt(GetUnixNano(), 20) + extName

	// 5、执行上传
	dst := path.Join(dir, fileName)
	c.SaveUploadedFile(file, dst)
	return dst, nil

}
func LocalAvatarUploadImg(c *gin.Context, picName string) (string, error) {
	// 1、获取上传的文件
	file, err := c.FormFile(picName)
	if err != nil {
		return "", err
	}

	// 2、获取后缀名 判断类型是否正确  .jpg .png .gif .jpeg
	extName := path.Ext(file.Filename)

	allowExtMap := map[string]bool{
		".jpg":  true,
		".png":  true,
		".gif":  true,
		".jpeg": true,
	}

	if _, ok := allowExtMap[extName]; !ok {
		return "", errors.New("文件后缀名不合法")
	}

	// 3、创建图片保存目录  static/upload/20210624

	day := GetDay()
	dir := "./images/avatar_images/" + day

	err1 := os.MkdirAll(dir, 0666)
	if err1 != nil {
		fmt.Println(err1)
		return "", err1
	}

	// 4、生成文件名称和文件保存的目录   111111111111.jpeg
	fileName := strconv.FormatInt(GetUnixNano(), 20) + extName

	// 5、执行上传
	dst := path.Join(dir, fileName)
	c.SaveUploadedFile(file, dst)
	return dst, nil

}
