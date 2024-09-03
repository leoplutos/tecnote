# 后端工程之Dotnet-ASP.NET Core Web API

## 说明
此工程的前端使用 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md) 中的前端工程

## 示例工程

### 技术选型
 - 后端：``ASP.NET Core/Web API``
 - 开发工具：``VS Code``

### 实现内容
 - 后端：使用``Microsoft.AspNetCore.Authentication.JwtBearer``生成token进行身份认证，使用``Microsoft.EntityFrameworkCore.InMemory``在内存中创建库，表``login``存储用户数据，表``todo``存储清单数据 

## 前端工程
参考 [前后端分离工程](./Frontend_Backend_Separation_zh_CN.md)

## 后端工程
创建命令
```bash
cd D:\WorkSpace\Dotnet
mkdir BackendAspCore
cd BackendAspCore

# 创建sln文件
dotnet new sln -n BackendAspCore

# 创建webapi项目
dotnet new webapi -n AspWebapi --framework net8.0 --use-controllers

# 将项目添加到解决方案
dotnet sln add AspWebapi/AspWebapi.csproj

# 添加依赖
cd AspWebapi
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.InMemory
dotnet add package Microsoft.EntityFrameworkCore.Sqlite
dotnet add package Serilog.AspNetCore
dotnet add package Serilog.Enrichers.Thread
dotnet add package Serilog.Sinks.Async
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer
dotnet add package Microsoft.AspNetCore.Mvc.NewtonsoftJson
cd ..

# 运行
dotnet run --project AspWebapi
```

或者下载笔者的工程 [BackendAspCore](./BackendAspCore) 后运行命令
```bash
cd D:\WorkSpace\FBS\BackendAspCore
cd AspWebapi
dotnet restore
cd ..
# 运行
dotnet run --project AspWebapi
```

## 启动命令

### 前端工程启动（端口9500）
```bash
cd D:\WorkSpace\FBS\FrontendVue
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 后端工程启动（端口9501）
```bash
cd D:\WorkSpace\FBS\BackendAspCore
dotnet run --project AspWebapi
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
Swagger UI  
http://localhost:9501/swagger/index.html
