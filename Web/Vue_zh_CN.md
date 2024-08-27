# Vue相关

## Vue简介

Vue 是一款用于构建用户界面的渐进式 JavaScript 框架。最大的作用是可以将前端的元素 **组件化**。  
学习了 Vue 之后，**拆组件** 将会是最常遇到的需求。

## Vue官方中文教程：  
https://cn.vuejs.org/guide/introduction.html  

## 关于 Vue 的 单页应用 和 单文件组件

#### 单页应用（Single-Page application：SPA）
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
```
cd D:\WorkSpace\Vue
npm create vue@latest
```
输入项目名字为： ``VueTestProject``  
其他选项根据需要自行选择  

## 运行 vue工程
```
cd VueTestProject
npm install
npm run dev
```

## 生产环境部署
```
npm run build
或者
npm run preview
```
``preview`` 命令会在本地启动一个静态 Web 服务器，将 dist 文件夹运行在 http://localhost:4173。这样在本地环境下查看该构建产物是否正常可用就方便多了

## 基于Vue的可视化拖拽库
https://github.com/Alfred-Skyblue/vue-draggable-plus

## VSCode开发
使用2个插件:  
- [Vue Language Features (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.volar)  
- [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin)  

## 使用Vim/NeoVim开发
直接使用 LSP 即可，具体请看笔者的 Vim配置文件  
LSP 安装
```
npm install -g @vue/language-server
```

## 使用Coc.nvim开发
使用 ``coc.nvim`` 开发使用下面的命令安装插件
```
:CocInstall @yaegassy/coc-volar
#第2个为可选安装项
:CocInstall @yaegassy/coc-typescript-vue-plugin
```
然后在工程根路径下新建 ``/.vim/coc-settings.json`` 文件内容如下
```
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
```
"C:\Program Files\Google\Chrome\Application\chrome.exe" --allow-file-access-from-files
```
EDGE
```
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-web-security --user-data-dir=D:\Download\EdgeTmp
```

### 学习清单 - 单文件组织版
需要 ``Node`` 环境
 - [VueFileComponent](./VueFileComponent)

运行方式
```
cd D:\WorkSpace\Vue\VueFileComponent
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

### 学习清单 - 单文件组织+TypeScript版
需要 ``Node`` 环境
 - [VueTS](./VueTS)

运行方式
```
cd D:\WorkSpace\Vue\VueTS
npm --registry https://npmreg.proxy.ustclug.org/ install
npm run dev
```

## 其他

- [Vue例子网站](https://vuejsexamples.com/)
- [如何优雅的调试 Vue 项目](https://mp.weixin.qq.com/s/zmjdy8wM76xRf9SfMiRx8A)


