# Angular相关

**NOTE:这篇文章记录的是Angular，而不是AngularJS**

## Angular简介
Angular 是 AngularJS 的升级后重构版本  
开发语言是 TypeScript、~~JavaScript~~、Dart（较新版本的官方文档已经闭口不谈对 JavaScript 的支持）  
关于 AngularJS 请看 [另一篇文章](./AngularJS_zh_CN.md)


## Angular官方中文教程：  
https://angular.cn/docs  

## Angular工程

#### 安装官方脚手架 ``Angular CLI``
```
npm --registry https://npmreg.proxy.ustclug.org/ install -g @angular/cli
```

#### 安装后确认
```
ng v
```

#### 创建工程
1. 进入你要创建工程的 **父** 目录
```
cd D:\WorkSpace\Angular
```
2. 创建工程  
```
ng new AngularTS
```
出现提示框后依次 选择 ``CSS种类`` → ``
是否要启用服务器端渲染（SSR）和静态站点生成（SSG/Prerendering）``

3. 启动工程
```
cd AngularTS
ng serve --open
```
``--open`` 选项会自动帮你打开浏览器并且访问

如果想修改端口号
```
ng serve --port 5173 --open
```

### 发布工程
```
ng build
```
此命令会创建一个 dist 文件夹，其中包含把你的应用部署到托管服务时所需的全部文件

## Angular 组件
Angular 的组件默认按如下结构创建
 - 一个以该组件命名的文件夹
 - 一个组件文件 ``<component-name>.component.ts``
 - 一个模板文件 ``<component-name>.component.html``
 - 一个 CSS 文件 ``<component-name>.component.css``
 - 测试用例文件 ``<component-name>.component.spec.ts``

其中 ``<component-name>`` 是组件的名称

``Angular CLI`` 提供了创建组件的命令
```
cd D:\WorkSpace\Angular\AngularTS
ng generate component <component-name>
```

### 其他命令
```
ng generate class my-new-class              // 新建class
ng generate component my-new-component      // 新建组件
ng generate directive my-new-directive      // 新建指令
ng generate enum my-new-enum                // 新建枚举
ng generate module my-new-module            // 新建模块
ng generate pipe my-new-pipe                // 新建管道
ng generate service my-new-service          // 新建服务
```

## VSCode开发
使用插件:  
- [Angular Language Service](https://marketplace.visualstudio.com/items?itemName=Angular.ng-template)

## 使用Vim/NeoVim开发
使用 LSP 有一些问题，笔者没有配置成功，不知道是否是新版本的Bug  
LSP 安装
```
npm install -g @angular/language-server
```

## 使用Coc.nvim开发
使用 ``coc.nvim`` 开发使用下面的命令安装插件
```
:CocInstall coc-angular
```

## 笔者做的示例工程

### 学习清单 - 工程+TypeScript版
需要 ``Node`` 环境
 - [AngularTS](./AngularTS)

运行方式
```
cd D:\WorkSpace\Angular\AngularTS
npm --registry https://npmreg.proxy.ustclug.org/ install
ng serve --port 5173 --open
```
