package service

import (
	"BackendGin/src/entity"
	"BackendGin/src/global"
)

// 用户登录Service
func Login(login entity.Login) bool {
	//从全局变量中取得数据连接
	db := global.App.DB

	// 创建只读事务.
	txn := db.Txn(false)
	defer txn.Abort()

	// 根据主键 id 来获取数据.
	raw, err := txn.First("login", "id", login.Userid)
	if err != nil {
		panic(err)
	}
	p := raw.(*entity.Login)
	if p != nil {
		if login.Password == p.Password {
			return true
		}
	}

	return false
}
