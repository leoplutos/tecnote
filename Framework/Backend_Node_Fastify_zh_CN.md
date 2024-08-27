# 后端工程之Node-Fastify

## 说明
此工程的前端使用 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md) 中的前端工程

## 示例工程

### 技术选型
 - 后端：``NodeJs/Fastify/fastify-autoload/LokiJS/fastify-jwt/fastify-type-provider-typebox/sinclair-typebox``
 - 开发工具：``VS Code/Bun``

### 实现内容
 - 后端：使用``fastify-jwt``生成token进行身份认证，使用``LokiJS``在内存中创建库，表``login``存储用户数据，表``todo``存储清单数据 

## 前端工程
参考 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md)

## 后端工程
下载笔者的工程 [BackendFastify](./BackendFastify) 后运行命令
```
cd D:\WorkSpace\FBS\BackendFastify
bun install
```

## 启动命令

### 前端工程启动（端口9500）
```
cd D:\WorkSpace\FBS\FrontendVue
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 后端工程启动（端口9501）
```
cd D:\WorkSpace\FBS\BackendFastify
bun run dev
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
