package models

type AqlMessage struct {
	Id              int    `json:"id"`
	Type            string `json:"type"`
	Speaker         string `json:"speaker"`
	UserIDTo        string `json:"user_id_to"`
	Content         string `json:"content"`
	InformationTime string `json:"information_time"`
	UserId          string `json:"user_id"`
}

func (Message) TableName() string {
	return "aql_message"
}
