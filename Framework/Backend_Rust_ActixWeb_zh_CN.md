# 后端工程之Rust-ActixWeb

## 说明
此工程的前端使用 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md) 中的前端工程

## 示例工程

### 技术选型
 - 后端：``Rust 1.72.0/actix-web 4.4.1/lazy_static 1.4.0/rusqlite 0.30.0``
 - 开发工具：``VS Code 1.85.0``

### 实现内容
 - 后端：使用``jsonwebtoken``生成token进行身份认证，使用``rusqlite``在内存中创建数据库，表``login``存储用户数据，表``todo``存储清单数据

## 前端工程
参考 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md)

## 后端工程
新建一个 ``Rust 的 Actix-Web 工程``  
```
cd D:\WorkSpace\FBS
cargo new backend-actix-web
cd backend-actix-web
```
然后下载笔者的工程 [backend-actix-web](./backend-actix-web) 覆盖即可

### 后端工程开发VSCode插件
 - [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)
 - [Even Better TOML](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)

## 启动命令

### 前端工程启动（端口9500）
```
cd D:\WorkSpace\FBS\FrontendVue
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 后端工程启动（端口9501）
```
cd D:\WorkSpace\FBS\backend-actix-web
cargo run
```
### 使用浏览器访问确认

#### 前端页面入口
http://localhost:9500/  
登录账号： ``admin / 123``  

#### 后端取得数据接口
认证接口  
http://localhost:9501/login  
取得清单列表接口  
http://localhost:9501/todo/getAll  


## 接口测试
### VSCode插件
 - [REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client)

### 测试方法
新建 ``filename.http`` 文件  
内容如下
```
POST http://localhost:9501/todo/getAll HTTP/1.1
token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcHAiLCJleHAiOjE3MDQzNzI4MzYsIm5iZiI6MTcwNDMyODYzNiwianRpIjoiYWRtaW4ifQ.NYMaCvMsrjdkb7eNbKpYIxjDtOEVWcHqRudr9MtYMQU

###

POST http://127.0.0.1:9501/login HTTP/1.1
Content-Type: application/json

{
    "userId": "admin"
	,
	"password": "123"
}
```

