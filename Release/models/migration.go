package models

//执行数据迁移

func migration() {

	////数据库自动创建表 自动迁移（把结构体和数据表进行对呀）

	DB.AutoMigrate(&GoodsType{})
	DB.AutoMigrate(&GoodsImage{})
	DB.AutoMigrate(&Goods{})
	DB.AutoMigrate(&User{})

}
