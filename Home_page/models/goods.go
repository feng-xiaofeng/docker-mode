package models

type Goods struct {
	Id           int
	Title        string
	Price        float64
	GoodsNumber  int
	GoodsDetails string
	Sort         int
	ClickCount   int
	IsDelete     int
	AddTime      int
	Status       int
	ModuleId     int
	Checked      int
	FirstImage   string
	GoodsSate    int
	UserId       int
	SchoolId     int
	GoodsTypeId  int
	User         User `gorm:"foreignKey:UserId;references:Id"`
}

func (Goods) TableName() string {
	return "goods"
}
