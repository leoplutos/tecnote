package service

import (
	"BackendGin/src/entity"
	"BackendGin/src/global"
)

// 取得Todo内容Service
func GetAllToDoList() []entity.Todo {
	//从全局变量中取得数据连接
	db := global.App.DB

	// 创建只读事务.
	txn := db.Txn(false)
	defer txn.Abort()

	// 返回可以遍历数据的迭代器.
	it, err := txn.Get("todo", "id")
	if err != nil {
		panic(err)
	}

	//生成返回数组
	var resultList []entity.Todo
	for obj := it.Next(); obj != nil; obj = it.Next() {
		p := obj.(*entity.Todo)
		element := entity.Todo{Todoid: p.Todoid, Todoname: p.Todoname, Image: p.Image, Studied: p.Studied}
		resultList = append(resultList, element)
	}

	return resultList
}
