# Go语言相关

## Go语言教程
The Way to Go中文译本：  
https://github.com/unknwon/the-way-to-go_ZH_CN/blob/master/eBook/preface.md  
中文社区的Go语言教程：  
https://github.com/Go-zh/tour  
微软出品的Go语言教程：  
https://learn.microsoft.com/zh-cn/training/paths/go-first-steps/  

## 下载
Go语言的官方下载地址是：  
https://golang.org/dl/  
可以打开选择版本下载，如果该页面打不开，或者打开了下载不了，可以通过Golang的国内网站  
https://golang.google.cn/dl/  
下载。  
找到 ``Stable versions`` , 下载 ``go1.21.0.windows-amd64.zip`` 即可

## 官方文档
国内可用的官方文档  
http://docs.studygolang.com/doc/  

#### 确认版本

下载后解压缩，cd进入到解压缩的文件夹运行命令
```
go version
```

#### 环境变量
配置2个环境变量
```
set GOPATH=D:\Tools\WorkTool\Go\go_global
set GO111MODULE=on
```
``GOPATH`` 目前主要用来存放依赖的 ``Module`` 库，生成的可执行文件等  
``GO111MODULE`` 设置为强制使用 Go 模块

为了能在国内网络环境下正常的安装go开发工具包，需要运行如下命令
```
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```

#### 
查看go的设定
```
go env
```

## 创建 Go 工程

```
cd D:\WorkSpace\Go\GoSampleProject
```

初始化命令
```
go mod init my.sample/GoSampleProject
go mod tidy
```

编译命令
```
go build ./src
go build ./src/main.go
go build -o ./bin/main.exe ./src/main.go
```

运行命令
```
go run ./src/main.go
```

全局包安装命令（会安装到 ``${GOPATH}`` 下）
```
go install my.sample/GoSampleProject@latest
```

## 使用 VSCode
使用插件为  [**Go**](https://marketplace.visualstudio.com/items?itemName=golang.go)  
安装插件的时候如果没有设定环境变量 ``GOROOT`` 的话会报错。  
在没有修改环境变量权限的时候可以用这个脚本解决。  
新建 ``VSCode_Go.cmd``
内容如下
```
set VSCODE_HOME=D:\Tools\WorkTool\Text\VSCode-win32-x64-1.81.1
set PATH=%PATH%;%VSCODE_HOME%
set GOROOT=D:\Tools\WorkTool\Go\go1.21.0.windows-amd64
set GOPATH=D:\Tools\WorkTool\Go\go_global
set PATH=%PATH%;%GOROOT%\bin;%GOPATH%\bin
start /b code
```
运行 ``VSCode_Go.cmd`` 启动 ``VSCode`` 即可  
等下载完成后，可以通过 ``settings.json`` 设定如下内容后
```
	"go.goroot": "D:\\Tools\\WorkTool\\Go\\go1.21.0.windows-amd64",
	"go.gopath": "D:\\Tools\\WorkTool\\Go\\go_global",
```
就可以不用这个临时的 ``VSCode_Go.cmd`` 启动 ``VSCode`` 了

#### VSCode 下的运行与调试
``Ctrl+F5`` ： 运行  
``F5`` ： 调试  
第一次运行的时候会提示需要 ``dlv``，安装即可。  
或者可以按 F1，然后 输入 ``Go: Install/Update Tools``，然后选择 ``dlv``

## 交叉编译
什么是交叉编译？所谓的交叉编译，是指在一个平台上就能生成可以在另一个平台运行的代码，例如，我们可以 32 位的 Windows 操作系统开发环境上，生成可以在 64 位 Linux 操作系统上运行的二进制程序。  
在其他编程语言中进行交叉编译可能要借助第三方工具，但在 Go 语言进行交叉编译非常简单，最简单只需要设置 GOOS 和 GOARCH 这两个环境变量就可以了。  

#### GOOS与GOARCH
 - GOOS的默认值是我们当前的操作系统， 如果windows，linux,注意mac os操作的上的值是darwin
 - GOARCH则表示CPU架构，如386，amd64，arm等

#### 获取GOOS和GOARCH的值
我们可以使用 ``go env`` 命令获取当前 GOOS 和 GOARCH 的值

### 交叉编译示例
比如在 Windows 下编译 Linux 平台的可执行文件
```
::1 目标平台的体系架构（386、amd64、arm）
set GOARCH=amd64
::2 目标平台的操作系统（darwin、freebsd、linux、windows）
set GOOS=linux
::3 编译 使用-o指定你要生成的文件名称，勿需指定可以去掉（参考：go build main.go）
go build -o app main.go
```

## 安装 lint
```
go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```
安装后确认
```
golangci-lint version
```

## ORM框架
GORM 是用于Golang的出色ORM（对象关系映射）库，它以开发人员友好而闻名
 - [官网](https://gorm.io/)
 - [Github](https://github.com/go-gorm/gorm)
 - [公众号示例](https://mp.weixin.qq.com/s/YtJSWOH-35QAPjtHBSmFng)

## 轻量级全文检索引擎
ZincSearch
 - [Github](https://github.com/zincsearch/zincsearch)
 - [公众号示例](https://mp.weixin.qq.com/s/pzQgv0ofHyQoo8ChnpBQ0g)

## 命令行视频下载工具
lux
 - [Github](https://github.com/iawia002/lux)

## 修改可执行文件的图标
 - [Github](https://github.com/akavel/rsrc)
 - [公众号示例](https://mp.weixin.qq.com/s/SM2_YGTOKqrPELjJ3xfckg)

## Go 如何优雅实现业务并发？
https://mp.weixin.qq.com/s/0JS7XWcpRauj14xWGWopFw

## 如何使用Go语言优雅地实现接口限流
https://mp.weixin.qq.com/s/bS65ip_l9SSAhdYBjxPPSg

## Golang实现异步队列
https://mp.weixin.qq.com/s/j21kENP0RUYlS2kchH8d2w

## aconfig：Go语言中简洁高效的配置加载库
https://mp.weixin.qq.com/s/5-RvGSkD_4logC0BQ7VVZQ





