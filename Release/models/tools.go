package models

import (
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
