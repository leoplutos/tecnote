# Dotnet语言相关

## 下载

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

## VSCode配置
安装VSCode插件（需要.net 7.0或者更高）  
使用插件为  [**C# Dev Kit**](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit)


## Vim配置
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

## 关于 Dotnet 的包管理

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
