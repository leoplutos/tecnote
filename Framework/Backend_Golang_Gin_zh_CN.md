# 后端工程之Golang-Gin

## 说明
此工程的前端使用 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md) 中的前端工程

另外还有个github上有一个不错的示例工程推荐一下  
https://github.com/jassue/jassue-gin

## 示例工程

### 技术选型
 - 后端：``Go1.21.0/Gin1.9.1/go-memdb 1.3.4/golang-jwt 4.5.0``
 - 开发工具：``VS Code 1.85.0``

### 实现内容
 - 后端：使用``golang-jwt``生成token进行身份认证，使用``go-memdb``在内存中创建数据库，表``login``存储用户数据，表``todo``存储清单数据

## 前端工程
参考 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md)

## 后端工程
新建一个 ``Golang 的 Gin 工程``  
```bash
cd D:\WorkSpace\FBS
mkdir BackendGin
cd BackendGin
go mod init BackendGin
```
然后下载笔者的工程 [BackendGin](./BackendGin) 覆盖后运行
```bash
go mod tidy
```

### 后端工程开发VSCode插件
 - [Go](https://marketplace.visualstudio.com/items?itemName=golang.Go)

## 启动命令

### 前端工程启动（端口9500）
```bash
cd D:\WorkSpace\FBS\FrontendVue
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 后端工程启动（端口9501）
```bash
cd D:\WorkSpace\FBS\BackendGin
go build -o ./bin/BackendGin.exe ./src/main.go
.\bin\BackendGin.exe
```

默认端口 ``9501``，可以用环境变量 ``GIN_HTTP_PORT`` 指定端口

### 使用浏览器访问确认

#### 前端页面入口
http://localhost:9500/  
登录账号： ``admin / 123``  

#### 后端取得数据接口
认证接口  
http://localhost:9501/login  
取得清单列表接口  
http://localhost:9501/todo/getAll  

## 其他

### Go 整洁模板
[Go 整洁模板](https://github.com/evrone/go-clean-template/blob/master/README_CN.md) 是一个 Golang 服务的整洁架构模板

### Gin-vue-admin
[Gin-vue-admin](https://github.com/flipped-aurora/gin-vue-admin) 是一套为快速研发准备的一整套前后端分离架构式的开源框架，旨在快速搭建中小型项目  
