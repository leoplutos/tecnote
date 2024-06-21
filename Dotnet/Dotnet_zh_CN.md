# Dotnet语言相关

## 概述

Dotnet 平台主要分为三个部分
 - .net Framework
 - .net Core
 - xamarin

### .net Framework
2002年发布，仅支持Windows平台，可以开发
- window桌面程序：winform、UWP、wpf等
- web应用程序：Asp.Net webform、Asp.Net MVC

发布方式为直接发布

### .net Core
2016年6月27号发布，是微软最新退出开源的、跨平台的平台，可以用来创建运行在Windows、Mac、Linux上的应用程序

发布方式为使用 ``nuget`` 发布

### xamarin
主要用来构建手机APP，主要使用的语言是C#语言（但是因为使用人数不多，所以可参考的案例较少）

## 新版 .net Core

### 下载

1. 先下载 ``dotnet``  
https://dotnet.microsoft.com/zh-cn/download  
安装后，确认  
```
dotnet --version
```

2. 创建工程 
```
cd D:\WorkSpace\Dotnet
mkdir DotnetSampleProject
cd DotnetSampleProject
touch .root
dotnet new console --framework net7.0
#dotnet run
```
如果没有工程模板文件可以如下创建
```
dotnet new sln
```

### 新版 .net Core 的 VSCode 配置
安装VSCode插件（需要.net 7.0或者更高）  
使用插件为  [**C# Dev Kit**](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit)


### 新版 .net Core 的 Vim 配置
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

### 在 .net Core 下使用命令行新建旧版 .NET Framework 工程
```
dotnet new console --language C# --output MyProject --target-framework-override net48
```

### 关于 .net Core 的包管理

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

## 旧版 .net Framework

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

Web开发的话最新只能用2015，Windows桌面开发最新可以用2017

#### Express 2013/2015 下载与安装（Windows10无法安装，推荐使用2017）
 - [Express 2013 for Web (vns_full.exe)](http://download.microsoft.com/download/2/6/F/26F1EABD-912B-42AB-AFAD-DC87D5F42CCF/vns_full.exe) 
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


### 旧版 .net Framework 的 VSCode 配置

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

### 旧版 .net Framework 打包单个exe

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

### C# 的异步例子
 - [AsyncExample.cs](./AsyncExample.cs)

### 其他

#### 一个可以在线运行C#的网站
https://www.programiz.com/csharp-programming/online-compiler/

