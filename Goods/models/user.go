package models

type User struct {
	Id           int    `json:"id"`
	UserName     string `json:"user_name"`
	SchoolId     int    `json:"school_id"`
	SchoolName   string `json:"school_name"`
	Signature    string `json:"signature"`
	UserPhone    string `json:"user_phone"`
	GoodsRelease int    `json:"goods_release"`
	GoodsCollect int    `json:"goods_collect"`
	AvatarUrl    string `json:"avatar_url"`
	AddTime      int    `json:"add_time"`
	Status       int    `json:"status"` //1.正常 2.禁止发布
}

func (User) TableName() string {
	return "users"
}
