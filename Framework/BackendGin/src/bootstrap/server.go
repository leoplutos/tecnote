package bootstrap

import (
	"BackendGin/src/config"
	"BackendGin/src/controller"
	"BackendGin/src/log"
	"BackendGin/src/middleware"
	"BackendGin/src/service"
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

// 设定Gin引擎
func setupEngine() *gin.Engine {
	// 创建一个默认的路由引擎
	engine := gin.Default()

	// 注册 api 分组路由
	// apiGroup := engine.Group("/todo")
	// apiGroup.POST("/getAll", controllers.Todo)

	// 注册路由 /login"
	engine.Match([]string{http.MethodPost, http.MethodGet}, "/login", controller.Login)

	// 使用中间件的路由
	authRouter := engine.Group("").Use(middleware.JWTAuth(service.AppGuardName))
	{
		// 注册路由 /todo/getAll"
		authRouter.Match([]string{http.MethodPost, http.MethodGet}, "/todo/getAll", controller.Todo)
	}

	// 设置受信任代理,如果不设置默认信任所有代理，不安全
	trustedProxies := config.Viper.GetStringSlice("http.trusted_proxies")
	engine.SetTrustedProxies(trustedProxies)

	return engine
}

// 启动Gin服务
func StartServer() {
	engine := setupEngine()
	// 启动HTTP服务
	// 默认端口
	defaultPort := config.Viper.GetInt("http.port")
	// 读取环境变量[GIN_HTTP_PORT]的设定值
	envPort := config.Viper.GetInt("GIN_HTTP_PORT")
	// 如何环境变量设定的话优先使用环境变量
	var port int
	if envPort == 0 {
		port = defaultPort
	} else {
		port = envPort
	}
	// log.Logger.Info().Msgf("defaultPort:[%d]  envPort:[%d]", defaultPort, envPort)
	addr := fmt.Sprintf(":%d", port)
	log.Logger.Info().Msgf("后端服务Gin已开启, 监听地址 [%s]", addr)
	engine.Run(addr)
}
