# React相关

## React简介
React起源于Facebook的内部项目，因为该公司对当时市场上的所有 javascript MVC 框架都不满意，所以就决定自己搞一套框架，当时的初心是用来架构自己公司的Instagram。搞出来之后，感觉这套东西还不错，在2013年5月开源  
React不是一个完整的框架，可以认为是一个 view 库，React构建页面UI的库。可以简单地理解为，React将界面分成了各个独立的小块，每一个块就是组件，这些组件之间可以组合、嵌套、做成一个页面  

以下引自官网
> A JavaScript library for building user interfaces

## React官方中文教程：  
https://zh-hans.react.dev/learn  

## 关于 React 的 单页应用 和 工程

#### 单页应用（Single-Page application：SPA）
在普通的 html 中，载入 CDN 服务提供的 JavaScript 脚本 即为单页应用用法  
例子：
```html
<!doctype html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Hello React!</title>
        <script crossorigin src="https://unpkg.com/react@17/umd/react.development.js"></script>
        <script crossorigin src="https://unpkg.com/react-dom@17/umd/react-dom.development.js"></script>
        <!-- 生产环境中不建议使用，在浏览器中使用 Babel 来编译 JSX 效率是非常低的-->
        <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>
    </head>
    <body>
        <div id="myApp"></div>
        <script type="text/babel">
            const devLang = "React";
            const h1Style = {
                color: "#0000AF",
            };
            const h1Element = <h1 style={h1Style}>这是一个使用 {devLang} 渲染的示例页面！</h1>;
            ReactDOM.render(h1Element, document.getElementById("myApp"));
        </script>
    </body>
</html>
```
**NOTE**：在商用环境不建议使用babel来进行浏览器编译

### 扩展：什么是JSX
JSX的全称是 ``Javascript and XML``，React发明了JSX，它是一种可以在JS中编写XML的语言。JSX更像一种模板，类似于Vue中的 ``template``  
在JSX中变量和表达式放在大括号 ``{}`` 中

## VSCode开发
VSCode内置支持，不需要用专有插件，只要按需选择一些辅助插件即可

## 使用Vim/NeoVim开发
直接使用 LSP 即可，具体请看笔者的 Vim配置文件  
LSP 安装
```
npm install -g typescript typescript-language-server
```

## React工程
官方的脚手架 [create-react-app](https://github.com/facebook/create-react-app) 已经停止维护，5个没有更新了  
以下是可选项  
 - Next.js (官方推荐)
 - Remix
 - Gatsby
 - Expo
 - Vite (笔者推荐)

### 使用 Vite 构建的示例
打开命令行，依次输入如下命令
1. 进入你要创建工程的 **父** 目录
```
cd D:\WorkSpace\React
```
2. 创建工程  
```
npm --registry https://npmreg.proxy.ustclug.org/ create vite@latest ReactFileComponent
```
出现提示框后依次 选择 ``React`` → ``JavaScript``或者``TypeScript``

3. 启动工程
```
cd ReactFileComponent
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 使用VSCode开发注意事项
使用 ``TypeScript`` 开发时如果 ``tsx`` 文件内的 html标签报错的话，可以如下修改  
文件：``tsconfig.json``  
修改内容：
```
"compilerOptions": {
    "jsx": "react-jsx",
},
```
更多可以看 [这里](https://devblogs.microsoft.com/typescript/announcing-typescript-4-1/#jsx-factories)

## 笔者做的几个示例工程

### 学习清单 - 单页应用版
 - [ReactSinglePage](./ReactSinglePage)

运行方式  
直接浏览器运行 ``main.html`` 即可  

### 学习清单 - 工程版
需要 ``Node`` 环境
 - [ReactFileComponent](./ReactFileComponent)

运行方式
```
cd D:\WorkSpace\React\ReactFileComponent
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 学习清单 - 工程+TypeScript版
需要 ``Node`` 环境
 - [ReactTS](./ReactTS)

运行方式
```
cd D:\WorkSpace\React\ReactTS
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```
