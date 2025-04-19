# Vue相关

## Vue简介

Vue 是一款用于构建用户界面的渐进式 JavaScript 框架。最大的作用是可以将前端的元素 ``组件化``。  
学习了 Vue 之后，``拆组件`` 将会是最常遇到的需求。

## Vue官方中文教程：  
https://cn.vuejs.org/guide/introduction.html  

## 关于 Vue 的 单页应用 和 单文件组件

### 单页应用（Single-Page application：SPA）
在普通的 html 中，载入 CDN 服务提供的 JavaScript 脚本 即为单页应用用法  
例子：
```html
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>CDN方式</title>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    </head>
    <body>
        <div id="app">{{ message }}</div>
        <script>
          const { createApp } = Vue
          createApp({
            data() {
              return {
                message: 'Hello Vue! 这是一个通过CDN方式使用Vue的例子！'
              }
            }
          }).mount('#app')
        </script>
    </body>
</html>
```

#### 单文件组件（Single-File Component：SFC）
将HTML、CSS 和 JavaScript，封装在 ``.vue`` 这种扩展名的文件中的用法。  
例子：
```html
<script>
export default {
  data() {
    return {
      greeting: 'Hello World!'
    }
  }
}
</script>

<template>
  <p class="greeting">{{ greeting }}</p>
</template>

<style>
.greeting {
  color: red;
  font-weight: bold;
}
</style>
```

## 使用脚手架创建 Vue 工程(单文件组织)
需要 ``Node.js``，安装好 ``Node.js``后运行如下命令创建 ``Vue`` 工程
```bash
cd D:\WorkSpace\Vue
npm create vue@latest
```
输入项目名字为： ``VueTestProject``  
其他选项根据需要自行选择  

## 运行 vue工程
```bash
cd VueTestProject
npm install
npm run dev
```

## 生产环境部署
```bash
npm run build
# 或者
npm run preview
```
``preview`` 命令会在本地启动一个静态 Web 服务器，将 dist 文件夹运行在 http://localhost:4173。这样在本地环境下查看该构建产物是否正常可用就方便多了

## 自动路由插件
https://github.com/posva/unplugin-vue-router

## 基于Vue的可视化拖拽库
https://github.com/Alfred-Skyblue/vue-draggable-plus

## VSCode开发
使用插件:  
- [Vue - Official](https://marketplace.visualstudio.com/items?itemName=Vue.volar)  
- ~~[TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin)~~  

## 使用Vim/NeoVim开发
直接使用 LSP 即可，具体请看笔者的 Vim配置文件  
LSP 安装
```bash
npm install -g @vue/language-server
```

## 使用Coc.nvim开发
使用 ``coc.nvim`` 开发使用下面的命令安装插件
```bash
:CocInstall @yaegassy/coc-volar
#第2个为可选安装项
:CocInstall @yaegassy/coc-typescript-vue-plugin
```
然后在工程根路径下新建 ``/.vim/coc-settings.json`` 文件内容如下
```json
{
	"volar.takeOverMode.enabled": true,
	"tsserver.enable": false,
	"vue.inlayHints.missingProps": true,
	"vue.inlayHints.inlineHandlerLeading": true,
	"vue.inlayHints.optionsWrapper": true,
}
```

## 笔者做的几个示例工程

### 学习清单 - 单页应用版
 - [VueSinglePage](./VueSinglePage)

运行方式  
直接浏览器运行 ``main.html`` 即可  
NOTE：
如果浏览器报错无法跨域运行javascript错误，按照如下命令启动浏览器  
Chrome
```bash
"C:\Program Files\Google\Chrome\Application\chrome.exe" --allow-file-access-from-files
```
EDGE
```bash
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-web-security --user-data-dir=D:\Download\EdgeTmp
```

### 学习清单 - 单文件组织版
需要 ``Node`` 环境
 - [VueFileComponent](./VueFileComponent)

运行方式
```bash
cd D:\WorkSpace\Vue\VueFileComponent
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 学习清单 - 单文件组织+TypeScript版
需要 ``Node`` 环境
 - [VueTS](./VueTS)

运行方式
```bash
cd D:\WorkSpace\Vue\VueTS
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 前后端分离的前端工程
 - [FrontendVue](../Framework/FrontendVue/)

## Vuetify.js
``Vuetify`` 是一个无需设计技能的 Vue 开源 UI 组件框架。 它为您提供了创建精美、内容丰富的网络应用所需的所有工具

- [Vuetify官网](https://vuetifyjs.com/zh-Hans/)

### 使用 Vuetify.js 构建的示例

#### 创建 Vuetify.js 工程
参考 [官方文档](https://vuetifyjs.com/zh-Hans/getting-started/installation/) 创建 Vuetify.js 工程

```bash
cd D:\WorkSpace\Web
# npm create vuetify@latest
bun create vuetify
```

下面是笔者选择的内容
- 创建工程名字 ... FrontendVuetify
- 安装预设 ...  Recommended (Everything from Default. Adds auto importing, layouts & pinia)
- 使用 TypeScript ... Yes
- 是否要使用 yarn、npm、pnpm 或 bun 安装依赖 ... bun
- 安装依赖 ... Yes

然后
```bash
cd FrontendVuetify
bun install
```

创建的项目结构为
- ``public`` : 存放静态资源。例如 favicon
- ``src`` : 存放源码
    - ``assets`` : 需要预处理的静态资源。例如构建用于生产时可能需要压缩的图像
    - ``components`` : 组件
    - ``layouts`` : 布局插件 详见 [vite-plugin-vue-layouts](https://github.com/JohnCampionJr/vite-plugin-vue-layouts)
    - ``pages`` : 自动生成路由插件 详见 [unplugin-vue-router](https://github.com/posva/unplugin-vue-router)
    - ``plugins`` : 注册全局插件
    - ``router`` : 路由
    - ``stores`` : Pinia 状态管理库 详见 [Pinia](https://pinia.vuejs.org/)
    - ``styles`` : 配置样式

为了使 ``Pinia`` 管理的状态可以持久化, 安装 [pinia-plugin-persistedstate](https://github.com/prazdevs/pinia-plugin-persistedstate)
```bash
bun add pinia-plugin-persistedstate
```

#### 复制示例工程
将笔者的工程 [FrontendVuetify](../Framework/FrontendVuetify/) 复制到文件夹 ``FrontendVuetify`` 即可

#### 运行
```bash
bun run dev
```

## 其他

- [Vue例子网站](https://vuejsexamples.com/)
- [如何优雅的调试 Vue 项目](https://mp.weixin.qq.com/s/zmjdy8wM76xRf9SfMiRx8A)


