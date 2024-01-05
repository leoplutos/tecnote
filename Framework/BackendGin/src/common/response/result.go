package response

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

// 统一返回内容封装
type Response struct {
	Code    int         `json:"code"`
	Message string      `json:"message"`
	Data    interface{} `json:"data"`
}

func ServerError(c *gin.Context) {
	msg := "Internal Server Error"
	c.JSON(http.StatusInternalServerError, Response{
		http.StatusInternalServerError,
		msg,
		nil,
	})
	c.Abort()
}

func Success(c *gin.Context, data interface{}) {
	c.JSON(http.StatusOK, Response{
		http.StatusOK,
		"success",
		data,
	})
}

func Fail(c *gin.Context, errorCode int, msg string) {
	c.JSON(http.StatusOK, Response{
		errorCode,
		msg,
		nil,
	})
}
