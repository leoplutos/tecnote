package main

import (
	"BackendGin/src/bootstrap"
	"BackendGin/src/global"
	"fmt"
)

// 主入口
func main() {
	// 初始化数据库并将数据库连接放到全局变量里
	global.App.DB = bootstrap.InitializeDB()
	// 数据库中插入初始数据
	bootstrap.InitializeDBDate()
	// 初始化JWT设定
	global.App.Jwt_secret = "3Bde3BGEbYqtqyEUzW3ry8jKFcaPH17fRmTmqE7MDr05Lwj95uruRKrrkb44TJ4s"
	global.App.Jwt_ttl = 43200
	global.App.Jwt_blacklist_grace_period = 10
	global.App.Jwt_refresh_grace_period = 1800
	// 程序关闭前，释放数据库连接
	defer func() {
		if global.App.DB != nil {
			//因为使用的是内存数据库，所以这里注释掉
			//db := global.App.DB
			//db.Close()
			fmt.Println("已关闭数据库连接")
		}
	}()
	// 启动Gin服务器
	bootstrap.StartServer()
}
