# Sanic相关

## 引言
在 github 上有一个专门测试各种语言各种 Web 框架速度的项目，可以明显的看到，flask、django、tornado 等老牌的 Python Web 框架已经快要垫底了  
在 Web 开发的过程中，我们最大的敌人不是用户，而是阻塞  
对于 Python 来说，异步是最好的提升性能的方式之一。这也是为什么要选择 ``异步Web框架`` 的原因  
``Sanic`` 就是 ``异步Web框架`` 的佼佼者

## 关于Sanic
Sanic 是 Python3.7+ Web 服务器和 Web 框架，旨在提高性能。它允许使用 Python3.5 中添加的 async/await 语法，这使得代码有效的避免阻塞从而达到提升响应速度的目的

## 官网
 - [官网](https://sanic.dev/zh)
 - [Github](https://github.com/sanic-org/sanic)

## 安装sanic
```
pip install sanic
```

## 工程示例

### 用poetry创建工程
```
cd D:\WorkSpace\Python
poetry new --src SanicTest
cd SanicTest
```

### 修改配置文件
修改 ``pyproject.toml`` 加入国内源和lsp设定
```
[[tool.poetry.source]]
name = "aliyun"
url = "https://mirrors.aliyun.com/pypi/simple/"
#name = "tsinghua"
#url = "https://pypi.tuna.tsinghua.edu.cn/simple"
priority = "default"

[tool.pyright]
venvPath = "."
venv = ".venv"
```

### 在虚拟环境安装sanic
分别安装sanic，sanic拓展，jinja  
jinja是sanic支持的模板功能
```
poetry add sanic
poetry add sanic-ext
poetry add Jinja2
```
确认安装成功
```
poetry run sanic --version
```

### 新建一个简单的Controller
``src/sanictest/server.py``
```
from sanic import Request, Sanic

# 创建Sanic实例
app = Sanic("MyHelloWorldApp")
# 静态文件目录路由
app.static("/static", "./static")


@app.get("/hello")
@app.ext.template("hello.html")
async def hello(request: Request):
    message = '你好，Sanic'
    if request.args:
        message = request.args.get("message")
    return {"title": "这是一个Sanic的示例", "message": message}
```

### 新建前端的jinja模板

#### 分别新建5个文件

``templates/header.html``  
```
<html>
<head>
  <title>{{title}}</title>
  <link rel="stylesheet" href="static/css/style.css" />
  <script src="static/js/main.js"></script>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>
<h1>这是header.html</h1>
<hr />
```

``templates/footer.html``  
```
<hr />
<h1>这是footer.html</h1>
</body>
</html>
```

``templates/hello.html``  
```
{% include "header.html" %}

<h1>这是hello.html</h1>
<p>title：{{title}}</p>
<p>message：{{message}}</p>
<button onclick="aletMessage()">测试按钮</button>

{% include "footer.html" %}
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

### 启动工程
```
cd D:\WorkSpace\Python\SanicTest
poetry run sanic src.sanictest.server:app
```

使用浏览器访问  
http://localhost:8000/hello  
http://localhost:8000/hello?message=mytest  

### 其他一些命令参数

``--fast`` 最大 CPU 性能下运行
```
sanic server:app --host=0.0.0.0 --port=1337 --fast
```
``--single-process`` 单个进程运行
```
sanic server:app --host=0.0.0.0 --port=1337 --single-process
```
