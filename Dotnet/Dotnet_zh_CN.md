# Dotnet语言相关

## 概述

Dotnet 平台主要分为三个部分
 - .NET Framework
 - .NET Core
 - xamarin

### .NET Framework
2002年发布，仅支持Windows平台，可以开发
- Window桌面程序：WinForm、UWP、WPF等
- Web应用程序：Asp.Net Webform、Asp.Net MVC

**包管理**  
使用 ``nuget.exe`` 或 ``包管理器控制台（需要安装 VS）`` 管理 NuGet 包  
工程目录示例  
```text
📂 solution_root
├── 📁 project_a
│    ├──  project_a.csproj
│    └──  packages.config
├── 📁 project_b
├── 📁 packages
└─── project_root.sln
```
包定义在 ``packages.config`` 文件中  
下载的包在 ``packages`` 文件夹中  

``packages.config`` 文件示例  
[packages.config](../Go/Grpc/netframework/netframeworkServer/packages.config)

[使用 NuGet CLI 管理 NuGet 包](https://learn.microsoft.com/zh-cn/nuget/consume-packages/install-use-packages-nuget-cli)

### .NET Core
2016年6月27号发布，是微软最新退出开源的、跨平台的平台，可以用来创建运行在Windows、Mac、Linux上的应用程序


**包管理**  
使用 ``dotnet.exe`` 管理 NuGet 包
工程目录示例  
```text
📂 solution_root
├── 📁 project_a
│    └──  project_a.csproj
├── 📁 project_b
└─── project_root.sln
```
包定义在 ``project_a.csproj`` 文件中  
下载的包在 ``$HOME/.nuget/packages`` 文件夹中  

``project_a.csproj`` 文件示例  
[project_a.csproj](../Go/Grpc/netcore/netcoreServer/netcoreServer.csproj)

### xamarin
主要用来构建手机APP，主要使用的语言是C#语言（但是因为使用人数不多，所以可参考的案例较少）

### .NET Framework 和 .NET Core 的区别
可以看 [官方网站](https://learn.microsoft.com/zh-cn/dotnet/standard/choosing-core-framework-server) 的比较说明

## 新版 .NET Core

### 下载

1. 先下载 ``dotnet``  
https://dotnet.microsoft.com/zh-cn/download  

可以选择安装文件安装，也可以选择下载二进制文件后设定到 ``PATH`` 中使用  
安装后，确认  
```
dotnet --version
```

2. 创建工程
```bash
cd D:\WorkSpace\Dotnet
mkdir dotnet-core-sample
cd dotnet-core-sample

# 创建sln文件
dotnet new sln -n dotnet-core-sample

# 创建console项目
dotnet new console -n dotnet-console-sample --framework net8.0 --use-program-main

# 将项目添加到解决方案
dotnet sln add dotnet-console-sample/dotnet-console-sample.csproj

# 运行
dotnet run --project dotnet-console-sample
# 不加载 launchSettings.json 文件
# dotnet run --project dotnet-console-sample --no-launch-profile
```

笔者的例子工程 [dotnet-core-sample](./dotnet-core-sample/)

### 常用工程命令

 - 创建项目：``dotnet new [template]``  &nbsp;&nbsp;  查看可用template ``dotnet new list``
 - 编译项目：``dotnet build``
 - 运行项目：``dotnet run`` &nbsp;&nbsp; 使用 ``--no-launch-profile`` 参数可以不加载 launchSettings.json 文件
 - 运行项目（DLL）：``dotnet filename.dll``
 - 清理项目的生成输出：``dotnet clean``
 - 运行单元测试：``dotnet test``
 - 部署项目：``dotnet publish``
 - 添加依赖：``dotnet add``
 - 删除依赖：``dotnet remove``
 - 还原项目依赖：``dotnet restore``
 - 创建 NuGet 包：``dotnet pack``
 - 安装工具：``dotnet tool``

### 解决方案命令
 - 将一个或者多个项目添加到解决方案：``dotnet sln add [project path]``
 - 列出解决方案文件中的所有项目：``dotnet sln list``
 - 从解决方案中移除一个或者多个项目，多个项目路径用空格隔开：``dotnet sln remove [project path]``

### 常用环境命令
 - SDK版本信息：``dotnet --list-sdks``
 - 运行时版本信息：``dotnet --list-runtimes``
 - 查看NuGet包源：``dotnet nuget list source``
 - 添加一个Nuget的包源：``dotnet nuget add source https://nuget.cdn.azure.cn/v3/index.json -n NuGet国内镜像``
 - 将包添加到项目中：``dotnet add package xxxx``
 - 将引用添加到项目中：``dotnet add reference src/xxxx.csproj``
 - 将项目ProjectA添加对ProjectB的引用：``dotnet add src/ProjectA.csproj reference src/ProjectB.csproj``

### 新版 .NET Core 的 VSCode 配置
安装VSCode插件（需要.net 7.0或者更高）  
使用插件为  [**C#**](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)

如果使用的是二进制文件安装，在启动VSCode时需要 ``PATH`` 内设定  
新建 ``VSCode_Dotnet.cmd``
内容如下
```
set VSCODE_HOME=D:\Tools\WorkTool\Text\VSCode-win32-x64
set PATH=%PATH%;%VSCODE_HOME%
set DOTNET_HOME=D:\Tools\WorkTool\DotNet\dotnet-sdk-8.0.407-win-x64
set PATH=%PATH%;%DOTNET_HOME%;
start /b code
```
运行 ``VSCode_Dotnet.cmd`` 启动 ``VSCode`` 即可

### 新版 .NET Core 的 Vim 配置
使用LSP（需要.net 7.0或者更高）  
CSharp有2个语言服务器 ``OmniSharp`` 和 ``CSharp-ls``，推荐使用后者  
Github地址为：  
 - [OmniSharp](https://github.com/OmniSharp/omnisharp-roslyn)
 - [CSharp-ls](https://github.com/razzmatazz/csharp-language-server)

``OmniSharp`` 直接下载二进制使用即可  
```
OmniSharp.exe --help
```

``CSharp-ls`` 使用如下命令安装  
```
dotnet tool install --global csharp-ls
csharp-ls --version
```

### 在 .NET Core 开启 AOT
https://learn.microsoft.com/zh-cn/aspnet/core/fundamentals/native-aot

### 在 .NET Core 下使用命令行新建旧版 .NET Framework 工程
```
dotnet new console --language C# --output MyProject --target-framework-override net48
```

### 全局安装csharp-ls

比如安装包 ``csharp-ls`` 的命令为  
```
dotnet tool install --global csharp-ls
```

指定 ``-g`` 或 ``--global`` 选项时，全局工具默认安装在以下目录中：  
```
%USERPROFILE%\.dotnet\tools
```

安装后，确认  
```
csharp-ls --version
```

## 旧版 .NET Framework

### 环境构建

### 方式1：使用 Windows10 预装的 MSBuild
Windows 10 预装的 ``MSBuild.exe`` 位置在
```
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe
```
可以尝试使用它编译一些老工程，编译命令
```
set MSBUILD_HOME=C:\Windows\Microsoft.NET\Framework64\v4.0.30319
set PATH=%PATH%;%MSBUILD_HOME%
MSBuild -version
cd /d [ProjectHome]
MSBuild [ProjectName].sln /t:Rebuild /p:Configuration=Release /p:Platform="Any CPU"
```
如果发生警告或者出错了的话，换其他方式

### 方式2：只安装 MSBuild，而不安装 Visual Studio

1. 下载 .NET Framework 4.8 开发人员工具包  
下载地址为：[.NET Framework 4.8 开发人员工具包](https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net48-developer-pack-offline-installer)，下载后安装  
  ※.NET Framework 4.8.1 为 Windows11 专用

2. 下载 Visual Studio Build Tools 2019  
下载地址1：[Visual Studio Build Tools 2019](https://aka.ms/vs/16/release/vs_buildtools.exe)  
~~下载地址2：[Visual Studio Build Tools 2017](https://download.visualstudio.microsoft.com/download/pr/653e10c9-d650-464b-a0b0-f211bb0c7c32/ce78a99572710c75aa8a209d771c54f98513c8f5cfe4bad9a661fb1a3298bf50/vs_BuildTools.exe)~~  

下载后安装，不要选择任何内容，只需按右下角的 ``安装`` 按钮，应该是几十到几百MB的大小

安装后的 ``MSBuild.exe`` 位置在
```
C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\MSBuild.exe
```

3. 运行编译命令
```
set MSBUILD_HOME=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin
set PATH=%PATH%;%MSBUILD_HOME%
MSBuild -version
cd /d [ProjectHome]
MSBuild [ProjectName].sln /t:Rebuild /p:Configuration=Release /p:Platform="Any CPU"
```

4. 检查 ``bin\Release`` 目录下是否有编译成功的exe

**参考**：确认已安装的 .NET Framework 版本  
查看 [这里](https://learn.microsoft.com/zh-cn/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed) 可以确认已安装的 .NET Framework 版本

### 方式3：使用 Visual Studio Express
``Visual Studio Express`` 是 社区版(Community) 的前身，它的许可证更加友好，可以商用，不过2017是它的最后一个版本，从2019开始只有社区版了  
官网在 [这里](https://visualstudio.microsoft.com/vs/express/)  
它的几个比较新的产品线：
- Express 2017 for Windows Desktop
- Express 2015 for Windows Desktop
- Express 2015 for Web
- Express 2015 for Windows 10
- Team Foundation Server 2018 Express

Web开发的话最新只能用2013（2015找不到下载了），Windows桌面开发最新可以用2017

#### Express 2013/2015 下载与安装
 - [Express 2013 For Web - ISO 镜像 (离线安装)](http://download.microsoft.com/download/2/6/F/26F1EABD-912B-42AB-AFAD-DC87D5F42CCF/vs2013.3_webexp_ENU.iso) &nbsp;&nbsp;推荐(4.4G)
 - [Express 2013 For Web - 在线安装（已经无法使用）](http://download.microsoft.com/download/2/6/F/26F1EABD-912B-42AB-AFAD-DC87D5F42CCF/vns_full.exe)
 - [Express 2015 for Windows Desktop (wdexpress_full_ENU.exe)](https://download.microsoft.com/download/E/8/9/E89E0AA3-EBC8-46DD-823B-9CECD1F95051/wdexpress_full_ENU.exe)


#### Express 2017 下载与安装
下载一个社区版的安装文件，然后运行命令即可安装 ``Express 2017 for Windows Desktop``
```
.\VisualStudioSetup.exe --channelUri https://aka.ms/vs/15/release/channel --productId Microsoft.VisualStudio.Product.WDExpress
```

这里的2个参数说明如下

| 通道名称                    | --channelUri                         | channelId               |
|-----------------------------|--------------------------------------|-------------------------|
| Visual Studio 2022 当前频道 | https://aka.ms/vs/17/release/channel | VisualStudio.17.Release |
| Visual Studio 2019 发布频道 | https://aka.ms/vs/16/release/channel | VisualStudio.16.Release |
| Visual Studio 2017 发布频道 | https://aka.ms/vs/15/release/channel | VisualStudio.15.Release |

| Edition                            | ID                                       | Description                                                                                                                                                                                               |
|------------------------------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Visual Studio Desktop Express 2017 | Microsoft.VisualStudio.Product.WDExpress | Build Native and Managed applications like WPF, WinForms, and Win32 with syntax-aware code editing, source code control, and work item management. Includes support for C#, Visual Basic, and Visual C++. |

**参考**： 

[Visual Studio 安装的命令行参数示例](https://learn.microsoft.com/zh-cn/visualstudio/install/command-line-parameter-examples?view=vs-2022#using---channeluri)

[Visual Studio 2017 workload and component IDs](https://learn.microsoft.com/zh-cn/previous-versions/visualstudio/visual-studio-2017/install/workload-and-component-ids?view=vs-2017)


### 旧版 .NET Framework 的 VSCode 配置

#### 插件以及事前准备

1. 安装 [**C#**](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) 插件

[扩展注意事项](https://github.com/dotnet/vscode-csharp/wiki/Desktop-.NET-Framework)
> 注意：此 C# 扩展支持有限的 .NET Framework 调试。它只能调试具有便携式 PDB 的 64 位应用程序。

2. settings.json 配置
```
{
    "omnisharp.useModernNet": false,
    "dotnet.server.useOmnisharp": true,
    "dotnet.unitTestDebuggingOptions": {
        "type": "clr"
    },
    "dotnet.unitTests.runSettingsPath": "[ProjectHome]\\UseX64Worker.runsettings"
}
```
工程根目录新建 ``UseX64Worker.runsettings``，内容如下
```
<?xml version="1.0" encoding="utf-8"?>
<RunSettings>
  <RunConfiguration>
    <TargetPlatform>x64</TargetPlatform>
  </RunConfiguration>
</RunSettings>
```

3. 卸载或者禁用 [**C# Dev Kit**](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit)

4. 安装所需运行时
- Windows：``.NET Framework`` 和 ``MSBuild Tools``  (参考上面的方式2)
- MacOS/Linux：[Mono with MSBuild](https://www.mono-project.com/download/preview/)

5. （可选）LSP会提示需要安装 .NET SDK，调试的话必须安装

**参考**：  
[stackoverflow](https://stackoverflow.com/questions/47707095/)

#### 项目配置
示例设定 [文件夹在这里](../Go/Grpc/netframework/.vscode/)

### 旧版 .NET Framework 打包单个exe

``Costura.Fody`` 是一个 ``Fody`` 框架下的插件，可通过Nuget安装到VS工程中。安装之后，就可以将项目所依赖的DLL（甚至PDB）文件全部打包到EXE文件里。

1. 选择项目，菜单栏的 ``工具`` -> ``NuGet 包管理器`` -> ``包管理器控制台``

2. 输入如下命令安装 ``Costura.Fody``

```
Install-Package Fody -Version 4.2.1
Install-Package Costura.Fody -Version 3.3.3
```

如果使用的是新版 VS ，直接安装最新版即可，不用后面跟版本号

因为笔者用的是 ``Visual Studio Express 2017``，MSBuild 版本为 15，只能用这个版本

3. 安装完成后重新生成解决方案  
会报错，错误提示如下
```
Fody: No configuration entry found for the installed weaver Costura. This weaver will be skipped. You may want to add this weaver to your FodyWeavers.xml
```

4. 项目根目录内会自动生成一个 ``FodyWeavers.xml``

修改内容为如下即可

```
<?xml version="1.0" encoding="utf-8"?>
<Weavers xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FodyWeavers.xsd">
  <Costura />
</Weavers>
```

## C# 的异步例子
 - [AsyncExample.cs](./dotnet-core-sample/dotnet-console-sample/Async/AsyncExample.cs)
 - [App.cs](./dotnet-workspace/dw-app/App.cs)

## Dotnet 的多模块工作区（solution 解决方案）

工程示例
 - [dotnet-workspace](./dotnet-workspace)

创建命令
```bash
cd D:\WorkSpace\DotNet\dotnet-workspace

# 创建工作区（解决方案）
dotnet new sln

# 创建4个子模块 core app etcd redis
dotnet new classlib -o dw-core
dotnet new console -o dw-app
dotnet new console -o dw-etcd
dotnet new console -o dw-redis
dotnet new console -o dw-test

# 将各个子模块导入解决方案
dotnet sln add dw-core/dw-core.csproj
dotnet sln add dw-app/dw-app.csproj
dotnet sln add dw-etcd/dw-etcd.csproj
dotnet sln add dw-redis/dw-redis.csproj
dotnet sln add dw-test/dw-test.csproj

# 添加子模块之间依赖
dotnet add dw-app/dw-app.csproj reference dw-core/dw-core.csproj
dotnet add dw-etcd/dw-etcd.csproj reference dw-core/dw-core.csproj
dotnet add dw-redis/dw-redis.csproj reference dw-core/dw-core.csproj
dotnet add dw-test/dw-test.csproj reference dw-app/dw-app.csproj
dotnet add dw-test/dw-test.csproj reference dw-etcd/dw-etcd.csproj
dotnet add dw-test/dw-test.csproj reference dw-redis/dw-redis.csproj

# 单独为 dw-app 添加依赖
cd dw-app
dotnet add package Bogus
```

## WCF 相关

WCF 即 ``Windows Communication Foundation`` (Windows通信基础)的简称，是微软分布式应用程序开发的集大成者，是对现有 Windows 平台下所有分布式通信技术的整合，例如 .NET Remoting 、MSSQ 。以通信范围而论，它可以跨进程、跨机器、跨子网、企业网乃至于 Internet。WCF可以运行在 ASP.NET ， EXE ， WPF ， Windows Forms ， NT Service ， COM+ 上面。WCF支持的协议包括TCP，HTTP。

#### 一些教程

创建一个简单的WCF服务程序  
https://www.cnblogs.com/dotnet261010/p/6184032.html

WCF 同一个代理共享全局变量  
https://www.cnblogs.com/Gyoung/archive/2012/10/19/2731519.html

WCF服务对象实例化的三种方式  
https://blog.csdn.net/weixin_36536176/article/details/105050876

## XSD解析

XML 架构定义工具 (XML Schema Definition Tool (``Xsd.exe``)) 是作为 Windows 软件开发工具包 (SDK) 的一部分随 .NET Framework 工具一起安装的

XML 架构定义工具 (``Xsd.exe``) 通常可在以下路径中找到：
```
C:\Program Files (x86)\Microsoft SDKs\Windows\{version}\bin\NETFX {version} Tools\
```

### 一个使用例子
1. 使用 XSD 生成 C# 类
```bash
set XSD_HOME="C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools"
set PATH=%PATH%;%XSD_HOME%
xsd --version
cd D:\project_xsd_path
# 运行后会生成 UniversalShipment.cs
xsd UniversalShipment.xsd /classes
```
2. 使用 C# 类生成 XML
```csharp
using System.Xml.Serialization;

// Shipment和UniversalShipmentData都是自动生成的类
Shipment shipment = new Shipment()
{
    ShipmentType = new CodeDescriptionPair() { Code = "SHI" }
};
UniversalShipmentData data = new UniversalShipmentData()
{
    Shipment = shipment,
};
// 使用 XmlSerializer 来生成 XML
XmlSerializer serializer = new XmlSerializer(typeof(UniversalShipmentData));
using (StreamWriter writer = new StreamWriter("output.xml"))
{
    serializer.Serialize(writer, data);
}
```

[官方文档 - XML 架构定义工具和 XML 序列化](https://learn.microsoft.com/zh-cn/dotnet/standard/serialization/the-xml-schema-definition-tool-and-xml-serialization)  
[官方文档 - 如何：使用 XML 架构定义工具生成类和 XML 架构文档](https://learn.microsoft.com/zh-cn/dotnet/standard/serialization/xml-schema-def-tool-gen)

## 第三方库

### Log日志
https://github.com/serilog/serilog  

### ORM
- [Entity Framework Core](https://learn.microsoft.com/zh-cn/ef/core/)
- [EF Core 基架（反向工程）- 从现有DB生成Entity](https://learn.microsoft.com/zh-cn/ef/core/managing-schemas/scaffolding/?tabs=dotnet-core-cli)


## 其他

### NuGet源
 - nuget.org： https://www.nuget.org/api/v2/
 - NuGet国内镜像： https://nuget.cdn.azure.cn/v3/index.json
 - 腾讯镜像： https://mirrors.cloud.tencent.com/nuget/

NuGet源设定文件位置
 - Windows ： ``%APPDATA%\NuGet\NuGet.Config``
 - Linux ： ``~/.nuget/NuGet/NuGet.Config``

### Visual Studio Express 2013 无法访问 NuGet

**解决办法**

1. 访问  https://www.nuget.org/packages/  ，手动下载需要的包（扩展名为nupkg）

2. 本地新建目录，将下载的包放进去，比如： ``D:\Tools\vs2013_pkg``

3. 打开 Express 2013，``Tools`` → ``Nuget Package Manager`` → ``Package Manager Setting`` → ``Package Sources``

4. 新建一个源，名字任意（比如：``local``），地址为：``D:\Tools\vs2013_pkg``，并且让这个本地源有效

5. 打开 ``NuGet程序包管理`` 即可看到熟悉的内容

### 一个可以在线运行C#的网站
https://www.programiz.com/csharp-programming/online-compiler/

### C#/.NET/.NET Core学习、工作、面试指南
[C#/.NET/.NET Core学习、工作、面试指南](https://github.com/YSGStudyHards/DotNetGuide)
