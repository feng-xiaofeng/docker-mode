package models

type GoodsImage struct {
	Id      int
	GoodsId int
	ImgUrl  string
	AddTime int
	Status  int
}

func (GoodsImage) TableName() string {
	return "goods_image"
}
