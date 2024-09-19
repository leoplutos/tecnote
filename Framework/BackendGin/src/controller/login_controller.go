package controller

import (
	"BackendGin/src/common/response"
	"BackendGin/src/entity"
	"BackendGin/src/log"
	"BackendGin/src/service"
	"github.com/gin-gonic/gin"
	"net/http"
)

// 用户登录Controller
func Login(c *gin.Context) {

	//取得json请求数据并绑定json和结构体
	var login entity.Login
	if err := c.ShouldBindJSON(&login); err != nil {
		response.Fail(c, 900, "请求内容不正确")
		return
	}
	//获取json中的key,注意使用 . 访问
	userId := login.Userid
	password := login.Password
	log.Logger.Info().Msgf("请求Login处理成功 userId:[%s]  password:[%s]\n", userId, password)
	if userId == "" {
		response.Fail(c, http.StatusBadRequest, "账号不能为空")
		return
	}
	if password == "" {
		response.Fail(c, http.StatusBadRequest, "密码不能为空")
		return
	}
	//调用service层取得数据
	checkResult := service.Login(login)
	if !checkResult {
		response.Fail(c, http.StatusUnauthorized, "用户名或密码错误！")
		return
	}
	//生成token
	token, _, err := service.JwtService.CreateToken(service.AppGuardName, login.Userid)
	if err != nil {
		response.Fail(c, 900, err.Error())
		return
	}
	//返回json
	response.Success(c, token)
}
