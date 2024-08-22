package models

import (
	"math/rand"
	"strconv"
	"time"
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

// 获取时间戳
func GetUnix() int64 {
	return time.Now().Unix()
}

// 表示把string转换成Float64
func Float(str string) (float64, error) {
	n, err := strconv.ParseFloat(str, 64)
	return n, err
}

// GetOrderId
func GetOrderId() string {
	// 2022020312233
	template := "20060102150405"
	return time.Now().Format(template) + GetRandomNum()
}

// 生成随机数
func GetRandomNum() string {
	var str string

	for i := 0; i < 4; i++ {
		current := rand.Intn(10)

		str += String(current)
	}
	return str
}
