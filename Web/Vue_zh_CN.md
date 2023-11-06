# Vue相关

## Vue官方中文教程：  
https://cn.vuejs.org/guide/introduction.html  

## 创建 vue工程
``Vue`` 需要 ``Node.js``，安装好 ``Node.js``后运行如下命令创建 ``Vue`` 工程
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

## VSCode开发
使用2个插件:  
- [Vue Language Features (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.volar)  
- [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin)  

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
