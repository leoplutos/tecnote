# TypeScript

## 简介
TypeScript 是 JavaScript 的一个超集，支持 ECMAScript 6 标准。  
TypeScript 由微软开发的自由和开源的编程语言。  
TypeScript 设计目标是开发大型应用，它可以编译成纯 JavaScript，编译出来的 JavaScript 可以运行在任何浏览器上。  

## 中文教程
https://www.tslang.cn/docs/handbook/basic-types.html

## 下载安装

### 使用 Node.js

#### 内置支持
Node.js v22.6.0 以上的版本 [实验性](https://nodejs.org/zh-cn/learn/typescript/run-natively) 的提供内置 TypeScript 支持  
```bash
node test.ts
```

#### 手动安装

如果版本低于 v22.6.0 的话使用 npm 安装即可

安装
```bash
npm install -g typescript
```
安装后确认
```bash
tsc -v
```
编译 TypeScript 到 JavaScript
```bash
cd /path/to/yourworkspace
tsc test.ts
```
使用 node 命令来执行 JavaScript 文件
```bash
node test.js
```

### 使用 Bun.js 或者 Deno.js
Bun.js 和 Deno.js 原生内置支持 TypeScript

## 在VSCode下进行TypeScript开发

#### 新建工程
```bash
cd D:\WorkSpace\TypeScript
mkdir TSSampleProject
cd TSSampleProject
mkdir src
mkdir dist
# 生成package.json
npm init -y
# 生成 tsconfig.json
tsc --init
```

#### 修改 tsconfig.json 配置
```json
"outDir": "dist",
"rootDir": "src",
```
src路径放ts代码，dist放编译好的js代码

#### 编译工程
```bash
cd D:\WorkSpace\TypeScript\TSSampleProject
tsc -p tsconfig.json
```

## 笔者做的示例工程

需要 ``Bun.js`` 环境
 - [TSSampleProject](./TSSampleProject)

运行方式  
使用 ``VSCode`` 导入工程，按下 ``F5`` 即可开始调试  
运行的话不打断点直接按 ``F5`` 即可
