package models

type Order struct {
	Id              int     `json:"id"`
	OrderNumber     string  `json:"order_number"`
	UserId          int     `json:"user_id"`
	SellerId        int     `json:"seller_id"`
	Price           float64 `json:"price"`
	GoodsName       string  `json:"goods_name"`
	SchoolName      string  `json:"school_name"`
	GoodsImage      string  `json:"goods_image"`
	PaymentMethod   string  `json:"payment_method"`
	ShippingAddress string  `json:"shipping_address"`
	Checked         int     `json:"checked"`
	Remark          string  `json:"remark"`
	AddTime         int     `json:"add_time"`
	User            User    `gorm:"foreignKey:SellerId;references:Id"`
	GoodsId         int     `json:"goods_id"`
}

func (Order) TableName() string {
	return "order"
}
