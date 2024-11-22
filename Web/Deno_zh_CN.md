# Deno相关

## 简介
``Deno``，是一个简单、先进且安全的 JavaScript、TypeScript 和 WebAssembly 运行时，具有安全的默认值和出色的开发人员体验。它基于 V8、Rust 和 Tokio 构建

1. 默认安全设置。除非 显式开启，否则不能访问文件、网络，也不能访问运行环境。
2. 天生支持 TypeScript
3. 只有一个唯一的可执行文件
4. 自带实用工具，例如依赖检查器 (deno info) 和代码格式化工具 (deno fmt)。
5. 有一套经过审核（审计）的标准模块， 确保与 Deno 兼容： deno.land/std

官方网址

- [官网](https://docs.deno.com/)
- [Github](https://github.com/denoland/deno/)
- [中文指南](https://bun.net.cn/guides)

## 下载安装

- [官网安装介绍](https://docs.deno.com/runtime/getting_started/installation/)
- 在 [releases](https://github.com/denoland/deno/releases) 页面下载 ``deno-x86_64-pc-windows-msvc.zip``

### 官方Docker镜像

[官网Github](https://github.com/denoland/deno_docker)  
[DockerHub](https://hub.docker.com/r/denoland/deno)

- Alpine Linux: ``denoland/deno:alpine``
- Debian: ``denoland/deno:debian`` (default)
- Distroless: ``denoland/deno:distroless``
- Ubuntu: ``denoland/deno:ubuntu``
- Only the binary: ``denoland/deno:bin``


#### 配置PATH
```
set DENO_HOME=D:\Tools\WorkTool\Web\deno
set PATH=%PATH%;%DENO_HOME%
```

#### 确认
运行命令确认
```
deno --version
```

## 配置

### 全局配置

环境变量 ``DENO_DIR``

- Windows 默认在: ``%LOCALAPPDATA%\deno``
- Linux 默认在: : ``$HOME/.deno``

### 工程配置
deno 的配置文件在工程目录内的 ``deno.json`` 或者 ``deno.jsonc``  

deno 也支持 ``package.jso``, 看 [这里](https://docs.deno.com/runtime/fundamentals/configuration/) 了解更多


## 设置国内源
Deno 使用 npm 时设定是和 npm 一致的

在文件 ``$HOME/.npmrc`` 中，如下设定即可
```
registry=https://registry.npmmirror.com/
```

## 初始化工程
```bash
cd D:\WorkSpace\Web
deno init my_project
```
默认入口文件为 ``main.ts``  
运行
```
deno main.ts
```

### 安装 node_modules
默认情况下，当使用 deno run 命令时，Deno 不会创建 node_modules 目录，依赖项将安装到全局缓存中。这是 Deno 项目的推荐设置，如果有一个老工程的话，可以使用下面的命令手动安装
```bash
deno install
```

## 示例工程
 - [BackendExpress](./BackendExpress/)
