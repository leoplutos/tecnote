# Gin相关

## 简介
Gin 是一个用 Go (Golang) 编写的 Web 框架。 它具有类似 martini 的 API，性能非常好，因为使用了 httprouter，速度提高了 40 倍。 如果需要性能和良好的生产力，Gin是一个不错的选择

## 官网
 - [官网](https://gin-gonic.com/zh-cn/docs/introduction/)
 - [Github](https://github.com/gin-gonic/gin)

## 工程示例

### 创建工程
```
cd D:\WorkSpace\Go
mkdir GinTest
cd GinTest
go mod init GinTest
go mod tidy
```

### 下载并安装gin
```
go get -u github.com/gin-gonic/gin
```

### 新建一个简单的Controller
``src/hello.go``
```
package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func setupEngine() *gin.Engine {
	// 创建一个默认的路由引擎
	engine := gin.Default()
	// 设置HTML模板文件目录，如果有子目录的话可以 templates/**/*
	engine.LoadHTMLGlob("templates/*")
	// 映射静态文件
	engine.Static("/static", "./static")

	// GET：请求方式；/hello：请求的路径
	// 当客户端以GET方法请求/hello路径时，会执行后面的匿名函数
	engine.GET("/hello", func(c *gin.Context) {
		message := c.Query("message")
		if message == "" {
			message = "你好，Gin"
		}
		c.HTML(http.StatusOK, "hello.html", gin.H{
			"title":   "这是一个Gin的示例",
			"message": message,
		})
		// c.JSON：返回JSON格式的数据
		// c.JSON(http.StatusOK, gin.H{"message": "Hello world!",
	})
	return engine
}

func main() {
	engine := setupEngine()
	// 启动HTTP服务，在0.0.0.0:8080启动服务
	engine.Run(":8080")
}
```

### 新建前端的html模板

#### 分别新建5个文件

``templates/header.html``  
```
{{ define "header" }}

<html>
<head>
  <title>{{ .title }}</title>
  <link rel="stylesheet" href="static/css/style.css" />
  <script src="static/js/main.js"></script>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>
<h1>这是header.html</h1>
<hr />

{{ end }}
```

``templates/footer.html``  
```
{{ define "footer" }}

<hr />
<h1>这是footer.html</h1>
</body>
</html>

{{ end }}
```

``templates/hello.html``  
```
{{ template "header" . }}

<h1>这是hello.html</h1>
<p>title：{{ .title }}</p>
<p>message：{{ .message }}</p>
<button onclick="aletMessage()">测试按钮</button>

{{ template "footer" . }}
```

``static/css/style.css``  
```
h1 {
	color: #005f5f
}
p {
	color: blue
}
```

``static/js/main.js``  
```
function aletMessage() {
  alert("测试按钮已按下");
}
```

### 编译+启动工程
```
cd D:\WorkSpace\Go\GinTest
go run ./src/hello.go
```
或者
```
cd D:\WorkSpace\Go\GinTest
go build -o ./bin/hello.exe ./src/hello.go
.\bin\hello.exe
```

使用浏览器访问  
http://localhost:8080/hello  
http://localhost:8080/hello?message=mytest  

