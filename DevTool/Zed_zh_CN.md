# Zed

## Zed 简介
Zed是一款由 Atom 和 Tree-sitter 原作者参与开发的高性能、跨平台的代码编辑器,主打极致的响应速度和多人协作功能

### 下载安装
https://zed.dev/

## 设置

### 全局用户设定文件位置（Windows）
```
%AppData%\Zed
```
- settings.json
- keymap.json

### 全局用户设定文件位置（MacOS）
```
~/.config/zed
```
- settings.json
- keymap.json

### 笔者的设定

- [Zed-conf](Zed-conf)

## 为Zed设定环境变量

在没有修改环境变量权限的时候可以用这个脚本解决。

在 Zed 的安装目录下新建 ``Zed_start.cmd`` ，内容如下
```
set ZED_HOME=D:\Tools\WorkTool\Text\Zed
set PATH=%PATH%;%ZED_HOME%
set MINGW_HOME=D:\Tools\WorkTool\C\MinGW64\bin
set PATH=%PATH%;%MINGW_HOME%
set CARGO_HOME=D:\Tools\WorkTool\Rust\Rust_gnu
set RUSTUP_HOME=D:\Tools\WorkTool\Rust\Rust_gnu
set RUST_SRC_PATH=D:\Tools\WorkTool\Rust\Rust_gnu\toolchains\stable-x86_64-pc-windows-gnu\lib\rustlib\src\rust\src
set PATH=%PATH%;%CARGO_HOME%\bin
::set RUSTUP_DIST_SERVER=https://rsproxy.cn
::set RUSTUP_UPDATE_ROOT=https://rsproxy.cn/rustup
::set BINARYEN_HOME=D:\Tools\WorkTool\Rust\binaryen
::set PATH=%PATH%;%BINARYEN_HOME%\bin
set GO111MODULE=on
set GOROOT=D:\Tools\WorkTool\Go\go1.21.0.windows-amd64
set GOPATH=D:\Tools\WorkTool\Go\go_global
set PATH=%PATH%;%GOROOT%\bin;%GOPATH%\bin
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk-21.0.3+9
set PATH=%PATH%;%JAVA_HOME%\bin
set PYTHON_HOME=D:\Tools\WorkTool\Python\Python313
set PATH=%PATH%;%PYTHON_HOME%;%PYTHON_HOME%\Scripts
start /b zed
```

然后使用这个 ``Zed_start.cmd`` 启动 Zed 即可

## 各语言设定

Zed 开箱支持 ``TypeScript/JavaScript``, ``Python``, ``Go``, ``Rust``

- 前端项目设定例子 [fullstacknext](../Framework/fullstacknext/.zed)

- Python项目设定例子 [PythonGrpc](../Go/Grpc/python)
    - [.zed 目录](../Go/Grpc/python/.zed)
    - [pyrightconfig.json](../Go/Grpc/python/pyrightconfig.json)
