package models

//执行数据迁移

func migration() {

	DB.AutoMigrate(&GoodsType{})

}
