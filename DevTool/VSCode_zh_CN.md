# VS Code

## VSCode 简介
VSCode 全称 Visual Studio Code，是微软出的一款轻量级代码编辑器，免费、开源而且功能强大。它支持几乎所有主流的程序语言的语法高亮、智能代码补全、自定义热键、括号匹配、代码片段、代码对比 Diff、GIT 等特性，支持插件扩展，并针对网页开发和云端应用开发做了优化。软件跨平台支持 Win、Mac 以及 Linux。

## 下载安装
https://code.visualstudio.com/#alt-downloads  
选择windows平台的.zip（x64）即可。  
将vscode的path设定到环境变量以后，可以用下面的命令打开当前文件夹
```bash
code .
```

## 常用插件
* [简体中文](https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-zh-hans)
* [日文](https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-ja)
* [VSCodeVim](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim)
* [显示行尾空格](https://marketplace.visualstudio.com/items?itemName=shardulm94.trailing-spaces)
* [显示换行符](https://marketplace.visualstudio.com/items?itemName=medo64.render-crlf)
* [嵌入式SQL高亮(可选)](https://marketplace.visualstudio.com/items?itemName=shanduur.c-embedded-sql)

## 主题插件
* [主题流行趋势](https://vscodethemes.com/)
* [Tomorrow and Tomorrow Night Theme Kit（暗色系）](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Theme-TomorrowKit)
* [One Dark Pro（暗色系）](https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme)
* [Min Theme（暗色系+亮色系）](https://marketplace.visualstudio.com/items?itemName=miguelsolorio.min-theme)
* [Dracula（暗色系）](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula)
* [Quiet Light for VSC（亮色系）](https://marketplace.visualstudio.com/items?itemName=onecrayon.theme-quietlight-vsc)

## 常用快捷键
- 将函数大纲（outline）拖动到右侧，在右侧[辅助侧边栏]显示
- Shift + Alt + R ： 在os打开当前文件夹
- Ctrl + Shift + ~ ： 打开新的终端
- 文件 → 新建窗口 → Ctrl + Shift + ~ ： 打开一个新的VS Code当作终端使用
- Ctrl + Shift + 5 ： 垂直分割终端
- Ctrl + 1 ： 选择第1个终端
- Ctrl + 2 ： 选择第2个终端
- Ctrl + n ： 选择第n个终端


## 配置编辑器
刚下载好的 VSCode 还不符合我们的需求，需要进行配置才能顺手。 VSCode 的设置分全局用户和工程。他们所在路径如下
#### 全局用户设定文件位置
```
C:\Users\user\AppData\Roaming\Code\User
```
* settings.json
* keybindings.json

#### 工程设定文件位置
工程根路径的 .vscode 文件夹
* settings.json
* c_cpp_properties.json

#### 笔者的设定文件
* [settings.json-全局用户](settings.json-user)
* [keybindings.json-全局用户](keybindings.json-user)
* [settings.json-工程](settings.json-project)
* [c_cpp_properties.json-工程](c_cpp_properties.json-project)


## 其他

#### 开发嵌入式SQL的时候EXEC SQL语句块的报错
可以将 SQL 代码包装在下面语句块中
```c
#ifndef __INTELLISENSE__
#endif
```