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
```
iisreset /restart
```
