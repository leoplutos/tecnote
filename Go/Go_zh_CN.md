# Go语言相关

## 下载
Go语言的官方下载地址是：  
https://golang.org/dl/  
可以打开选择版本下载，如果该页面打不开，或者打开了下载不了，可以通过Golang的国内网站  
https://golang.google.cn/dl/  
下载。  
找到 ``Stable versions`` , 下载 ``go1.21.0.windows-amd64.zip`` 即可

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

## 安装 lint
```
go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```
安装后确认
```
golangci-lint version
```