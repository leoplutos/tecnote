## 概述

``ASP.NET Core``  和 ``ASP.NET`` 是 ``.NET`` 平台下的 2 个 Web 开发平台

### 两者区别

|          | ASP.NET Core          | ASP.NET 4.x    |
|----------|-----------------------|----------------|
| 支持OS   | Windows、MacOS、Linux | Windows        |
| 运行时   | .NET Core             | .NET Framework |
| 托管部署 | Kestrel、IIS          | IIS            |

也可以看 [官方网站](https://learn.microsoft.com/zh-cn/aspnet/core/fundamentals/choose-aspnet-framework) 的比较说明


## IIS相关

``IIS`` 全称为 ``Internet Information Service``（Internet信息服务），它的功能是提供信息服务，如架设 http、ftp 服务器等，是 WindowsNT 内核的系统自带的，不需要下载

### IIS的安装

IIS 为系统内置组件，只需要把组件设置启用即可，下面以 Windows10 示例

1. ``设定`` → ``应用`` → 右上角的``程序和功能`` → 左侧的``启用或关闭Windows功能``

2. 找到 ``Internet Information Service``（注：不是后面带【可承载的Web核心】的那个）

3. 按需求勾选，一般选择 ``Web 管理工具`` 和 ``万维网服务``

    在 ``万维网服务`` 展开 ``应用程序开发功能``，选中 ``APS.NET 4.8``

4. 设定后重启电脑

5. ``我的电脑``右键 → ``管理`` → 左侧的``服务和应用程序`` → ``IIS管理器`` → 右侧表示的内容即为 ``IIS服务``

6. IIS中有 ``应用程序池`` 和 ``网站`` 2 个 菜单，选择 ``网站`` → ``Default Web Site`` → 右键 → ``管理网站`` → ``浏览``，打开了欢迎页面的话就证明 IIS 启用成功

### IIS的证书安装

在有 HTTPS 通信需求的时候，会需要SSL证书，可以按照 [官方网站](https://learn.microsoft.com/zh-cn/iis/manage/configuring-security/how-to-set-up-ssl-on-iis) 中 ``IIS 经理 - 获取证书`` 的部分设定SSL证书

### IIS中开启WCF映射

打开 ``启用或关闭Windows功能``

找到 ``.NET Framework 4.x Advanced Services``  → ``WCF 服务`` → 选中 ``HTTP 激活``

### ASP.NET部署到IIS

1. 新建部署目录

    IIS 默认的部署目录在 ``C:\inetpub\wwwroot``

    我们新建目录 ``C:\inetpub\wwwroot\myTestSite``

2. 新建网站

    在 IIS 的 ``网站`` 菜单下 → 右键 ``添加网站`` → 按下面填写

    - 网站名称：myTestSite
    - 物理路径：C:\inetpub\wwwroot\myTestSite
    - 端口：8081
    - 其他：全部默认

    确认后，在 IIS 的 ``网站`` 菜单下会看到新建的网站 ``myTestSite``

3. 发布程序

    打开 Visual Studio，选中工程 → 右键 ``发布(Publish)`` → 路径填写 ``C:\inetpub\wwwroot\myTestSite``，其他全部默认

    控制台出现信息 ``Publish: 1 succeeded, 0 failed, 0 skipped`` 即发布成功

### 设置IIS开机不自动启动
``Windows键`` + ``r`` → 输入 ``services.msc`` 回车  
找到 ``World Wide Web Publishing Service`` 禁用并停止

### IIS命令

#### 重启
```bash
iisreset /restart
```

## 前后端分离项目模板

### 下载
[模板地址](https://www.nuget.org/packages/microsoft.javascript.templates/)

```bash
# 安装模板
dotnet new install microsoft.javascript.templates::0.1.9-preview
# 确认
dotnet new list
```

### 创建前后端分离工程
```bash
# 创建工程目录
cd D:\WorkSpace\TestProject\Dotnet
mkdir dotnet-react-sample
cd dotnet-react-sample

# 创建 React + ASP.NET Core 工程
dotnet new reactwebapi --language typescript
```

### 修改配置

#### 修改前端目录下的 ``vite.config.ts`` 文件

```typescript
//const target = env.ASPNETCORE_HTTPS_PORT ? `https://localhost:${env.ASPNETCORE_HTTPS_PORT}` :
//    env.ASPNETCORE_URLS ? env.ASPNETCORE_URLS.split(';')[0] : 'https://localhost:7258';
// 后端端口9501
const target = 'http://localhost:9501/';

// ...

server: {
    proxy: {
        '^/weatherforecast': {
            target,
            secure: false
        }
    },
    // 前端端口9500
    port: 9500,
    https: {
        key: fs.readFileSync(keyFilePath),
        cert: fs.readFileSync(certFilePath),
    }
}
```

#### 修改后端目录下的 ``Properties/launchSettings.json`` 文件

参照 [这里](https://raw.githubusercontent.com/leoplutos/tecnote/refs/heads/master/Framework/BackendAspCore/AspWebapi/Properties/launchSettings.json) 修改为9501

#### 修改后端目录下的 ``Program.cs`` 文件
```cs
// 禁用HTTPS（生产环境要打开）
// app.UseHttpsRedirection();
```

#### 修改后端目录下的 ``csproj`` 文件

SpaProxyServerUrl 配置了的话，后端项目如果启用了 UseSpa 或相关中间件，它会把请求（特别是针对 / 的请求）代理到前端的开发服务器（例如：Vite 本地开发环境）。

```xml
<!--
<SpaRoot>..\dotnet_react_sample.client</SpaRoot>
<SpaProxyLaunchCommand>npm run dev</SpaProxyLaunchCommand>
-->
<SpaProxyServerUrl>https://localhost:9500</SpaProxyServerUrl>
```

### 启动工程

```bash
# 前端启动
cd dotnet-react-sample.client
npm install
npm run dev

# 后端启动
cd dotnet-react-sample.Server
dotnet restore
dotnet run
```

[官方文档](https://learn.microsoft.com/zh-cn/visualstudio/javascript/tutorial-asp-net-core-with-react?view=vs-2022)

## ASP.NET Core Blazor

``Blazor`` 是微软 .NET 团队开发的一个新的 UI 框架，在概念上，Blazor 更像是 Vue 或 React，而不是 ASP.NET Core MVC。它是一个基于组件的框架，用于构建丰富的交互式 Web 应用程序。

Blazor 与传统 JavaScript 框架的主要区别在于，Blazor 组件完全用 C# 和 Razor 编写，不需要用到 JavaScript，但可以和 JavaScript 交互。

Blazor 有两种模式
- 服务端模式（SSR） : 在服务器端运行再实时渲染到浏览器
- 客户端模式（CSR） : 在客户端使用 WebAssembly 运行，叫 WebAssembly 模式

更多可以看官方文档 [使用 Blazor 构建全堆栈 Web 应用](https://learn.microsoft.com/zh-cn/aspnet/core/blazor/?view=aspnetcore-8.0#build-a-full-stack-web-app-with-blazor)

### 笔者的 Blazor 示例工程

```bash
cd D:\WorkSpace\DotNet
dotnet new blazor -n FullStackBlazor --framework net8.0 --interactivity Server --auth Individual
```
- ``--interactivity Server`` : 服务端渲染模式
- ``--auth Individual`` : 添加个人身份验证模块

创建的项目结构说明可以看 [这里](https://learn.microsoft.com/zh-cn/aspnet/core/blazor/project-structure?view=aspnetcore-8.0)

### 添加 Ant Design Blazor
```bash
cd FullStackBlazor
dotnet add package AntDesign
```

### 复制代码
将 [FullStackBlazor](../Framework/FullStackBlazor/) 的代码覆盖粘贴到创建的工程

### 运行
```bash
dotnet run
```
访问 http://localhost:9500 即可

### 其他
下面情况不知道是 Bug 还是笔者有配置没有弄正确，需要有空再次调查一下

#### 访问 注册账号 页面不跳转
在浏览器地址栏直接访问 http://localhost:9500/Account/Register 即可  
如果画面一直自动刷新的话，点击浏览器的 ``X``

#### 账号注册后无法登录
打开 ``Data/app.db`` 运行下面的 SQL
```SQL
UPDATE AspNetUsers SET EmailConfirmed = 1
WHERE UserName = 'admin@exsample.com'
```

### Awesome-Blazor
https://github.com/AdrienTorris/awesome-blazor
