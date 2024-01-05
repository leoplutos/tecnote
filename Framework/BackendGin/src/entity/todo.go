package entity

type Todo struct {
	Todoid   int    `json:"todoId"`
	Todoname string `json:"todoName"`
	Image    string `json:"image"`
	Studied  bool   `json:"studied"`
}
