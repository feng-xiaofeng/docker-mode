package models

type GoodsType struct {
	Id            int
	ModuleName    string //导航名称
	TypeName      string //分类名称
	Type          int    //节点类型 :  1、表示导航    2、表示goods分类
	ModuleId      int    //此module_id和当前模型的id关联       module_id= 0 表示导航
	Description   string
	Sort          int
	Status        int
	AddTime       int
	GoodsTypeItem []GoodsType `gorm:"foreignKey:ModuleId;references:Id"`
	// Checked       bool        `gorm:"-"` // 忽略本字段
}

func (GoodsType) TableName() string {
	return "goods_type"
}
