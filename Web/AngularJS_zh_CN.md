# AngularJS相关

**NOTE:这篇文章记录的是AngularJS，而不是Angular**

## AngularJS简介
和 Vue 一样，``AngularJS`` 是一个 JavaScript 框架。由 Google 收购并推出。  
它关注的点并不是dom，而是页面动态的数据。  
[微信网页版](https://wx.qq.com/) 就使用了 AngularJS 框架

``AngularJS`` 并不是适合任何应用的开发，AngularJS考虑的是构建 **CRUD应用**。而对于像游戏和有图形界面的编辑器之类的应用，会进行频繁且复杂的DOM操作，可能不适合用Angular来构建。在这种场景下，使用更低抽象层次的类库可能会更好，例如：jQuery

## AngularJS 和 Angular的区别
- AngularJS 版本为 1.x ，开发语言是 JavaScript、Dart
- Angular 版本为 2.0 - 9.x ，开发语言是 TypeScript、~~JavaScript~~、Dart（较新版本的官方文档已经闭口不谈对 JavaScript 的支持）

后者是前者的全新改版，架构和设计理念完全不同了，是吸取前一代的优点后重构的项目（有点类似 Struts2 和 Struts）

**NOTE:** Google 官方于 2021/12/31 日结束对 AngularJS 的支持  
从AuglarJS迁移至Angular的曲线较高，这也是非常多的项目仍在使用AngularJS的原因所在

## 官方的示例
PhoneCat是AngularJS官方的示例教学应用。你可先看看PhoneCat的在线运行效果  
[点击查看](https://www.angularjs.net.cn/Examples/PhoneCat/#!/phones)

## AngularJS的单页应用（Single-Page application：SPA）
在普通的 html 中，载入 CDN 服务提供的 JavaScript 脚本 即为单页应用用法  
例子：
```html
<!doctype html>
<html>
    <head>
        <meta charset="utf-8" />
        <script src="https://unpkg.com/angular@1.8.3/angular.min.js"></script>
    </head>
    <body>
        <div ng-app="myApp">
            <div ng-init="devLangs=['C','Java','Python','Rust','Golang','Kotlin']">
                <p>使用 ng-repeat 来循环数组</p>
                <ul>
                    <li ng-repeat="element in devLangs">{{ element }}</li>
                </ul>
            </div>
            <div ng-controller="myCtrl">
                名字: <input ng-model="stuName" /><br />
                你输入的名字是: {{stuName}}
            </div>
        </div>
    </body>
    <script>
        var app = angular.module("myApp", []);
        app.controller("myCtrl", function ($scope) {
            $scope.stuName = "王二麻子";
        });
    </script>
</html>
```

## AngularJS工程（可选）
虽然官方没有提供脚手架工具，但是可以从示例工程基础上改  
步骤看 [这里](https://www.angularjs.net.cn/phonecat/)

## 笔者做的示例工程

### 学习清单 - 单页应用版
 - [AngularJSSinglePage](./AngularJSSinglePage)

运行方式  
直接浏览器运行 ``main.html`` 即可
