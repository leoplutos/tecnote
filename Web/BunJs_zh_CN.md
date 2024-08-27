# Bun.js相关

## 简介
``Bun.js``，有着极高的性能，原生支持 JS、TS、JSX 和 TSX，并完全兼容 Node.js

开发环境用 Bun.js， 生产环境用 Node.js 执行 Bun.js 编译后的 JavaScript 是一个不错的选择

- [官网](https://bun.sh/)
- [Github](https://github.com/oven-sh/bun)
- [中文指南](https://bun.net.cn/guides)

## 下载安装

- [官网安装介绍](https://bun.sh/docs/installation)
- [Windows 二进制文件](https://github.com/oven-sh/bun/releases/latest/download/bun-windows-x64.zip)


#### 配置PATH
```
set BUNJS_HOME=D:\Tools\WorkTool\Web\bun-windows-x64
set PATH=%PATH%;%BUNJS_HOME%
```

#### 确认
运行命令确认
```
bun --version
```

## 配置

### 局部配置（工程配置）
一般来说，建议将 ``bunfig.toml`` 文件与 ``package.json`` 文件一起添加到项目根目录中

### 全局配置

要全局配置Bun，您还可以在以下路径之一创建 ``.bunfig.toml`` 文件

### Windows平台
```
%USERPROFILE%\.bunfig.toml
```

### Linux和MacOS平台

```
$HOME/.bunfig.toml
$XDG_CONFIG_HOME/.bunfig.toml
```

## 设置国内源
在 ``.bunfig.toml`` 中如下设定
```toml
[install]
# 使用 ali 源
registry = "https://registry.npmmirror.com/"
# `bun install --global` 的安装路径
# globalDir = "~/.bun/install/global"
globalDir = "D:\Tools\WorkTool\Web\bun_global"
# 全局安装的二进制文件
# globalBinDir = "~/.bun/bin"
globalBinDir = "D:\Tools\WorkTool\Web\bun_bin"

[install.cache]
# 缓存路径
# dir = "~/.bun/install/cache"
dir = "D:\Tools\WorkTool\Web\bun_cache"
```

## 初始化工程
```
cd D:\WorkSpace\Web
mkdir BunTest
cd BunTest
bun init
```
默认入口文件为 ``index.ts``  
运行
```
bun run index.ts
```

#### 使用script的方式运行项目
打开 ``package.json`` 添加如下内容
```
  "scripts": {
    "start": "bun run index.ts",
  },
```
然后运行
```
bun start
```

## 安装第三方包

安装第三方包到本地（模块下载到当前命令行所在目录）
```
bun add <packagename>
bun add pino
```

安装第三方包到全局（-g参数，模块将被下载安装到全局目录）
```
bun add -g <packagename>
```

卸载包
```
bun remove <packagename>
```

## 创建模板项目
```
cd D:\WorkSpace\Web
bun create vite
```
进入目录并安装全部依赖
```
cd ViteTest
bun install
```
运行
```
bun run dev
```
编译到dist目录
```
bun run build
```

## Docker安装
```bash
docker pull oven/bun:slim

docker run --rm --init --ulimit memlock=-1:-1 oven/bun:slim
docker run -it --init --ulimit memlock=-1:-1 --entrypoint /bin/bash --name bun oven/bun:slim
```

https://hub.docker.com/r/oven/bun/tags

一些镜像tag  
```
docker pull oven/bun:debian
docker pull oven/bun:slim
docker pull oven/bun:alpine
docker pull oven/bun:distroless
```
