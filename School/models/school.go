package models

type School struct {
	Id int `json:"id"`
	// Sort       int    `json:"sort"`
	Status     int    `json:"status"`
	SchoolName string `json:"school_name"`
}

func (Access) School() string {
	return "schools"
}
