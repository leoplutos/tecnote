# TypeScript

## 简介
TypeScript 是 JavaScript 的一个超集，支持 ECMAScript 6 标准（ES6 教程）。  
TypeScript 由微软开发的自由和开源的编程语言。  
TypeScript 设计目标是开发大型应用，它可以编译成纯 JavaScript，编译出来的 JavaScript 可以运行在任何浏览器上。  

## 中文教程
https://www.tslang.cn/docs/handbook/basic-types.html

## 下载安装

### 安装
安装
```
npm install -g typescript
```
安装后确认
```
tsc -v
```

### 编译单个文件
编译 TypeScript 到 JavaScript
```
cd /path/to/yourworkspace
tsc test.ts
```

### 运行
使用 node 命令来执行 JavaScript 文件
```
node test.js
```

## 在VSCode下进行TypeScript开发

#### 新建工程
```
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
```
"outDir": "dist",
"rootDir": "src",
```
src路径放ts代码，dist放编译好的js代码

#### 编译工程
```
cd D:\WorkSpace\TypeScript\TSSampleProject
tsc -p tsconfig.json
```

## 笔者做的示例工程

需要 ``Node`` 环境
 - [TSSampleProject](./TSSampleProject)

运行方式  
使用 ``VSCode`` 导入工程，按下 ``F5`` 即可开始调试  
运行的话不打断点直接按 ``F5`` 即可
