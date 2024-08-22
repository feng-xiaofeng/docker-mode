package models

import (
	"fmt"
	"os"
	"time"

	"gopkg.in/ini.v1"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var DB *gorm.DB

func init() {
	config, iniErr := ini.Load("./conf/app.ini")
	if iniErr != nil {
		fmt.Printf("Fail to read file: %v", iniErr)
		os.Exit(1)
	}

	ip := config.Section("mysql").Key("ip").String()
	port := config.Section("mysql").Key("port").String()
	user := config.Section("mysql").Key("user").String()
	password := config.Section("mysql").Key("password").String()
	database := config.Section("mysql").Key("database").String()

	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?charset=utf8mb4&parseTime=True&loc=Local", user, password, ip, port, database)

	var db *gorm.DB
	var err error

	for i := 0; i < 10; i++ { // 尝试 10 次连接
		db, err = gorm.Open(mysql.Open(dsn), &gorm.Config{
			QueryFields: true, // 打印 SQL
		})
		if err == nil {
			break
		}
		fmt.Println("Failed to connect to database, retrying in 5 seconds...")
		time.Sleep(5 * time.Second)
	}

	if err != nil {
		fmt.Printf("Failed to connect to database after retries: %v\n", err)
		os.Exit(1)
	}

	DB = db
	migration()
}
