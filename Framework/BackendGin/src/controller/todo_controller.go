package controller

import (
	"BackendGin/src/common/response"
	"BackendGin/src/entity"
	"BackendGin/src/service"
	"fmt"
	"github.com/gin-gonic/gin"
)

// 取得Todo内容Controller
func Todo(c *gin.Context) {
	//调用service层取得数据
	var resultList []entity.Todo = service.GetAllToDoList()
	fmt.Println("请求TodoList处理成功")
	//返回json
	response.Success(c, resultList)
}
