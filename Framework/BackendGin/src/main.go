package main

import (
	"BackendGin/src/bootstrap"
	"BackendGin/src/config"
	"BackendGin/src/global"
	"BackendGin/src/log"
)

// 主入口
func main() {
	// 初始化数据库并将数据库连接放到全局变量里
	global.App.DB = bootstrap.InitializeDB()
	// 数据库中插入初始数据
	bootstrap.InitializeDBDate()
	// 初始化JWT设定
	jwt_secret := config.Viper.GetString("jwt.secret")
	jwt_ttl := config.Viper.GetInt("jwt.ttl")
	jwt_blacklist_grace_period := config.Viper.GetInt("jwt.blacklist_grace_period")
	jwt_refresh_grace_period := config.Viper.GetInt("jwt.refresh_grace_period")
	// log.Logger.Info().Msgf("jwt_secret:%s  jwt_ttl:%d  jwt_blacklist_grace_period:%d  jwt_refresh_grace_period:%d", jwt_secret, jwt_ttl, jwt_blacklist_grace_period, jwt_refresh_grace_period)
	global.App.Jwt_secret = jwt_secret
	global.App.Jwt_ttl = jwt_ttl
	global.App.Jwt_blacklist_grace_period = jwt_blacklist_grace_period
	global.App.Jwt_refresh_grace_period = jwt_refresh_grace_period
	// 程序关闭前，释放数据库连接
	defer func() {
		if global.App.DB != nil {
			//因为使用的是内存数据库，所以这里注释掉
			//db := global.App.DB
			//db.Close()
			log.Logger.Info().Msg("已关闭数据库连接")
		}
	}()
	// 启动Gin服务器
	bootstrap.StartServer()
}
