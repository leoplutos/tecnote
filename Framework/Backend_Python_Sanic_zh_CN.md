# 后端工程之Python-Sanic

## 说明
此工程的前端使用 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md) 中的前端工程

## 示例工程

### 技术选型
 - 后端：``Python3.8/Poetry1.7.1/Sanic23.6.0/pyjwt2.8.0/``
 - 开发工具：``VS Code 1.85.0``

### 实现内容
 - 后端：使用``pyjwt``生成token进行身份认证，使用sqlite3模块在内存中创建库，表``login``存储用户数据，表``todo``存储清单数据

## 前端工程
参考 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md)

## 后端工程
新建一个 ``Python 的 Sanic 工程``  
```
cd D:\WorkSpace\FBS
poetry new --src BackendSanic
```
然后下载笔者的工程 [BackendSanic](./BackendSanic) 覆盖即可

### 后端工程开发VSCode插件
 - [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
 - [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance)
 - [Black Formatter](https://marketplace.visualstudio.com/items?itemName=ms-python.black-formatter)

## 启动命令

### 前端工程启动（端口9500）
```
cd D:\WorkSpace\FBS\FrontendVue
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 后端工程启动（端口9501）
```
cd D:\WorkSpace\FBS\BackendSanic
poetry install
poetry run python src/backendsanic/server.py
#poetry run sanic src.backendsanic.server:app -p 9501
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
