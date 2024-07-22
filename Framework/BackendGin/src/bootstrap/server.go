package bootstrap

import (
	"BackendGin/src/controller"
	"BackendGin/src/middleware"
	"BackendGin/src/service"
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
	engine.SetTrustedProxies([]string{"127.0.0.1", "172.30.8.172"})

	return engine
}

// 启动Gin服务
func StartServer() {
	engine := setupEngine()
	// 启动HTTP服务，在0.0.0.0:9501启动服务
	engine.Run(":9501")
}
