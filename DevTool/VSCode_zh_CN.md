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
* [自动补全插件TabNine(可选)](https://marketplace.visualstudio.com/items?itemName=TabNine.tabnine-vscode)
* [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
* [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
* [Rust](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)
* [嵌入式SQL高亮(可选)](https://marketplace.visualstudio.com/items?itemName=shanduur.c-embedded-sql)

## 主题插件
* [主题流行趋势](https://vscodethemes.com/)
* [Tomorrow and Tomorrow Night Theme Kit（暗色系）](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Theme-TomorrowKit)
* [One Dark Pro（暗色系）](https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme)
* [Min Theme（暗色系+亮色系）](https://marketplace.visualstudio.com/items?itemName=miguelsolorio.min-theme)
* [Dracula（暗色系）](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula)
* [Quiet Light for VSC（亮色系）](https://marketplace.visualstudio.com/items?itemName=onecrayon.theme-quietlight-vsc)

## 常用快捷键
- Ctrl+鼠标左键 ： 文件、函数等跳转。
- F12 ： 转到定义
- Ctrl + ] ： 转到定义（vim插件）
- **Ctrl + F12** ： 转到实现（对于接口和抽象方法）
- **Shift + F12** ： 转到引用
- Alt + ← ： 跳转后返回原处
- Ctrl + t ： 跳转后返回原处（vim插件）
- Ctrl + Shift + O ： 列出函数名，选择后快速跳转
- **Ctrl + P** ： 快速文件导航（最实用的功能）
- Ctrl + Tab ： 可以列出最近打开的文件，在开发时，两个文件间切换时效率很高。
- Ctrl + Shift + F ： grep查找（重新映射成 shift+space -> g）
- 将函数大纲（outline）拖动到右侧，在右侧[辅助侧边栏]显示
- Shift + Alt + R ： 在os打开当前文件夹
- Ctrl + Shift + ~ ： 打开新的终端
- 文件 → 新建窗口 → Ctrl + Shift + ~ ： 打开一个新的VS Code当作终端使用
- Ctrl + Shift + 5 ： 垂直分割终端
- Ctrl + 1 ： 选择第1个终端
- Ctrl + 2 ： 选择第2个终端
- Ctrl + n ： 选择第n个终端

## VSCode的设定层次关系
系统默认设置（不可修改） → 用户设置 → 工作区设置 → 文件夹设置  
后者的设置会覆盖前者  

注：工作区可以不打开不设置，即“无工作区设置”，这种情况的层次为：  
用户设置 → 文件夹设置  

## 工作区的使用
新建一个工作区：  
文件 → 将工作区另存为...   → 选择保存路径  
保存的文件为[.code-workspace]扩展名，即工作区文件  
笔者的习惯为为每一个项目保存一个工作区文件，将所有的工作区文件放到一个统一的地方方便快速打开。

## 配置编辑器
刚下载好的 VSCode 还不符合我们的需求，需要进行配置才能顺手。他们所在路径如下
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

## 笔者的设定文件
#### 用户设置（全局）
* [settings.json](VSCode-conf/user/settings.json)
* [keybindings.json](VSCode-conf/user/keybindings.json)

#### 文件夹设置（C工程）
* [settings.json](VSCode-conf/c-project/settings.json)
* [c_cpp_properties.json](VSCode-conf/c-project/c_cpp_properties.json)
* [launch.json](VSCode-conf/c-project/launch.json)
* [tasks.json](VSCode-conf/c-project/tasks.json)
* [tasks.json-多个任务例子](VSCode-conf/c-project/tasks.json-multiple)

## 使用VSCode编译和调试

tasks用于在launch前执行任务，launch用于读取执行文件。
这两者经常组合起来用于需要编译语言的自动编译+自动执行，下面时以C为例的设定文件
在工程根路径的 .vscode 文件夹内新建如下2个文件
 * tasks.json
 * launch.json

配置好之后，打开一个 .c 文件，点击右上角的“播放按钮”，弹出调试配置列表  
在列表中选中 launch.json 中 name 定义的 [GCC 编译和运行] 即可

另外，在调试窗口，char数组变量是按照数组来表示内容的。
如果想类似字符串一样表示全部内容可以在watch区域加上 &变量名[0] 来实现

#### 预定义变量
支持下面的预定义变量:  

* ${workspaceFolder} - 当前工作目录(根目录)
* ${workspaceFolderBasename} - 当前文件的父目录
* ${file} - 当前打开的文件名(完整路径)
* ${relativeFile} - 当前根目录到当前打开文件的相对路径(包括文件名)
* ${relativeFileDirname} - 当前根目录到当前打开文件的相对路径(不包括文件名)
* ${fileBasename} - 当前打开的文件名(包括扩展名)
* ${fileBasenameNoExtension} - 当前打开的文件名(不包括扩展名)
* ${fileDirname} - 当前打开文件的目录
* ${fileExtname} - 当前打开文件的扩展名
* ${cwd} - 启动时task工作的目录
* ${lineNumber} - 当前激活文件所选行
* ${selectedText} - 当前激活文件中所选择的文本
* ${execPath} - vscode执行文件所在的目录
* ${defaultBuildTask} - 默认编译任务(build task)的名字

更多：  
https://zhuanlan.zhihu.com/p/92175757?ivk_sa=1024320u&utm_id=0

## 其他

#### 开发嵌入式SQL的时候EXEC SQL语句块的报错
可以将 SQL 代码包装在下面语句块中
```c
#ifndef __INTELLISENSE__
#endif
```