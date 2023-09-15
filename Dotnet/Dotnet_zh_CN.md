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
cd D:\WorkSpace\Dotnet\DotnetSampleProject
dotnet new console
dotnet run
```

## VSCode配置
安装VSCode插件（需要.net 7.0或者更高）  
使用插件为  [**C# Dev Kit**](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit)


## Vim配置
使用LSP（需要.net 7.0或者更高）  
使用LSP服务端为  [**OmniSharp Roslyn**](https://github.com/OmniSharp/omnisharp-roslyn)

在 [releases](https://github.com/OmniSharp/omnisharp-roslyn/releases) 下找到对应平台的可执行文件下载（比如：omnisharp-win-x64.zip）  
解压缩后，确认  
```
OmniSharp.exe --help
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
