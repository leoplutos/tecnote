# VS Code

## VSCode 简介
VSCode 全称 Visual Studio Code，是微软出的一款轻量级代码编辑器，免费、开源而且功能强大。它支持几乎所有主流的程序语言的语法高亮、智能代码补全、自定义热键、括号匹配、代码片段、代码对比 Diff、GIT 等特性，支持插件扩展，并针对网页开发和云端应用开发做了优化。软件跨平台支持 Win、Mac 以及 Linux。  
VSCode以目录为工程单元，再也没有 .proj, .vcproj, xcodeproj 等垃圾，不依赖工程构件文件。

## 下载安装
https://code.visualstudio.com/#alt-downloads  
选择windows平台的.zip（x64）即可。  

## 常用插件

- [**简体中文**](https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-zh-hans)
- [日文(可选)](https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-ja)
- [**项目仪表板**](https://marketplace.visualstudio.com/items?itemName=kruemelkatze.vscode-dashboard)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：可以将经常访问的文件夹、文件和SSH访问，固定到仪表板上以快速访问它们
- [**VSCode Neovim**](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：最好用的Vim绑定插件
- [**显示行尾空格**](https://marketplace.visualstudio.com/items?itemName=shardulm94.trailing-spaces)
- [**Visible Whitespace**](https://marketplace.visualstudio.com/items?itemName=yoshi389111.visible-whitespace)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：可以渲染 TAB符，全角空格，回车，文件结束符（EOF） 的显示内容和颜色
- [**Error Lens**](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：把代码检查（错误、警告、语法问题）进行突出显示
- [**Markdown Preview Mermaid Support**](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：在VSCode的Markdown中显示Mermaid
- [**Remote - SSH**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：远程开发神器
- [**VS Code Settings for Mac Windows and Linux**](https://marketplace.visualstudio.com/items?itemName=franmastromarino.vs-code-settings-os)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：管理多个平台的工程配置文件
- [豆包 MarsCode - 编程助手](https://marketplace.visualstudio.com/items?itemName=MarsCode.marscode-extension)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：豆包旗下的编程AI助手
- [Cline](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：Cline 是一个开源的插件，能够与 DeepSeek 等 AI 模型无缝集成，提供智能代码编辑功能
- [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：查看Git仓库的插件
- [**Diff Folders**](https://marketplace.visualstudio.com/items?itemName=L13RARY.l13-diff)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：文件夹比较
- [**Draw.io Integration**](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：在VSCode中画图的插件
- [Periscope](https://marketplace.visualstudio.com/items?itemName=JoshMu.periscope)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：VSCode下的``telescope``
- ~~[FindItFaster](https://marketplace.visualstudio.com/items?itemName=TomRijndorp.find-it-faster)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：VSCode下的``telescope``~~
- ~~[VSCodeVim(不推荐)](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim)~~
- [Sync-Rsync](https://marketplace.visualstudio.com/items?itemName=vscode-ext.sync-rsync)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：本地和服务器代码同步插件（支持双向）
- [Tabnine](https://marketplace.visualstudio.com/items?itemName=TabNine.tabnine-vscode)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：自动补全插件

## 配置文件插件

- [**Protobuf3**](https://marketplace.visualstudio.com/items?itemName=zxh404.vscode-proto3)
- [**Even Better TOML**](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)
- [Java Properties](https://marketplace.visualstudio.com/items?itemName=Spitfire1900.java-properties-2)&nbsp;&nbsp;properties文件支持
- [**XML Tools**](https://marketplace.visualstudio.com/items?itemName=DotJoshJohnson.xml)
- [**YAML**](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
- [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：提升CSV查看和编辑效率，支持SQL

## C/C++

有2套方案：  
  - 方案1：[微软的cpptools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)  
  - 方案2：[**clangd**](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd) + [**CodeLLDB**](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb)  

## Python

- [**Python**](https://marketplace.visualstudio.com/items?itemName=ms-python.python)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：Python插件安装好后会依赖安装Pylance和Jupyter，只要保留Python和Pylance，卸载Jupyter相关即可
- [**Black Formatter**](https://marketplace.visualstudio.com/items?itemName=ms-python.black-formatter)

## Rust

- [**rust-analyzer**](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)
- [**CodeLLDB**](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：C/C++/Rust Debug

## Go

- [**Go**](https://marketplace.visualstudio.com/items?itemName=golang.go)

### Java

Java所需插件比较多。有2套方案：  
  - 方案1：直接下载插件包（不推荐）  
  [Java6合1插件包](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)  
  包括6个插件（Language Support for Java，Debugger for Java，Test Runner for Java，Maven for Java，Project Manager for Java，Visual Studio IntelliCode）  

  - 方案2：**按需下载（推荐）**
    - [**Language Support for Java**](https://marketplace.visualstudio.com/items?itemName=redhat.java)&nbsp;&nbsp;提供基础支持，代码格式化，代码重构、代码片  段、语法高亮、代码自动补全等等核心功能，**需要JDK17或更高**
    - [**Debugger for Java**](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-debug)&nbsp;&nbsp;调试支持
    - [Project Manager for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-dependency)&nbsp;&nbsp;管理Java项目、包括引用的  库、资源文件、包、类和类成员
    - [Maven for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-maven)&nbsp;&nbsp;Maven支持，管理 Maven 依赖
    - [Gradle for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-gradle)&nbsp;&nbsp;Gradle支持，管理 Gradle 依赖
    - [Test Runner for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-test)&nbsp;&nbsp;运行和调试 JUnit/TestNG 测试用  例
    - [Checkstyle for Java](https://marketplace.visualstudio.com/items?itemName=shengchen.vscode-checkstyle)&nbsp;&nbsp;检查错误
    - [Spring3合1插件包](https://marketplace.visualstudio.com/items?itemName=vmware.vscode-boot-dev-pack)  包括3个插件（Spring Boot，Spring   Initializr Java，Spring Boot Dashboard）也可按需下载
    - [Java Decompiler](https://marketplace.visualstudio.com/items?itemName=dgileadi.java-decompiler)&nbsp;&nbsp;反编译
    - [Lombok Annotations Support](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-lombok)&nbsp;&nbsp;标注支持
    - [json to java](https://marketplace.visualstudio.com/items?itemName=felipeguedes.json2java)

### .Net/C#

- [**C#**](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)

## Zig

- [**Zig Language**](https://marketplace.visualstudio.com/items?itemName=ziglang.vscode-zig)

### 其他语言

- [Deno](https://marketplace.visualstudio.com/items?itemName=denoland.vscode-deno)
- [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)
- [COBOL语言支持](https://marketplace.visualstudio.com/items?itemName=broadcomMFD.cobol-language-support)
- [RPG语言支持](https://marketplace.visualstudio.com/items?itemName=NielsLiisberg.RPG)


### 其他插件

- [Lines of Code (LOC)](https://marketplace.visualstudio.com/items?itemName=lyzerk.linecounter)   &nbsp;&nbsp;统计代码行数
- [Highlight](https://marketplace.visualstudio.com/items?itemName=fabiospampinato.vscode-highlight)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：使用正则表达式，来高亮代码中所有用户想要的文本
- [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：运行多种语言的代码片段或代码文件，省掉保存的环节，直接可以运行
- [Blockman](https://marketplace.visualstudio.com/items?itemName=leodevbro.blockman)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：突出显示代码块来提高代码可读性
- [Hex Editor](https://marketplace.visualstudio.com/items?itemName=ms-vscode.hexeditor)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：运行方式为：按下F1，然后输入：open active file in hex editor
- [Compare Folders](https://marketplace.visualstudio.com/items?itemName=moshfeu.compare-folders)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：文件夹对比差分
- [嵌入式SQL高亮(可选)](https://marketplace.visualstudio.com/items?itemName=shanduur.c-embedded-sql)
- [Project Manager(可选)](https://marketplace.visualstudio.com/items?itemName=alefragnani.project-manager)
- [Debug Visualizer(可选)](https://marketplace.visualstudio.com/items?itemName=hediet.debug-visualizer)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：调试过程可视化
- [Regex Previewer(可选)](https://marketplace.visualstudio.com/items?itemName=chrmarti.regex)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：实时测试正则表达式的实用工具
- [Polacode(可选)](https://marketplace.visualstudio.com/items?itemName=pnp.polacode)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：代码截图
- [vscode-json(可选)](https://marketplace.visualstudio.com/items?itemName=andyyaldoo.vscode-json)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：json美化
- [Log File Highlighter(可选)](https://marketplace.visualstudio.com/items?itemName=emilast.LogFileHighlighter)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：高亮log文件
- [Peacock(可选)](https://marketplace.visualstudio.com/items?itemName=johnpapa.vscode-peacock)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：为每个工程设置不同的主题
- [indent-rainbow(可选)](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：为每个缩进显示不同的颜色（Python开发很有用）
- [SonarLint(可选)](https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarlint-vscode)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：静态代码分析工具
- [Paste JSON as Code(可选)](https://marketplace.visualstudio.com/items?itemName=quicktype.quicktype)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：json转换成代码，主流语言都支持


## Web插件

- [**httpYac**](https://marketplace.visualstudio.com/items?itemName=anweber.vscode-httpyac)&nbsp;&nbsp;&nbsp;&nbsp;推荐，使用例子可以看[官网](https://httpyac.github.io/guide/request.html)&nbsp;&nbsp;&nbsp;&nbsp;笔者的一个例子文件 [httpYac.http](./httpYac.http)
- [**LiveServer**](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：快速启动HTTP服务
- [REST Client(可选)](https://marketplace.visualstudio.com/items?itemName=humao.rest-client)
- [Thunder Client(可选)](https://marketplace.visualstudio.com/items?itemName=rangav.vscode-thunder-client)
- [Postcode(可选)](https://marketplace.visualstudio.com/items?itemName=rohinivsenthil.postcode)

## DB/分布式存储插件

- [**Redis**](https://marketplace.visualstudio.com/items?itemName=Dunn.redis)
- [Sql Tools(可选)](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools)
- [Database Client(可选)](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-mysql-client2)
- [ppz(可选)](https://marketplace.visualstudio.com/items?itemName=ppz.ppz)
- [SQL Beautify(可选)](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：SQL语句格式化


## 主题插件
- [主题流行趋势](https://vscodethemes.com/)
- [Material Icon Theme Material（文件图标主题）](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
- [Fluent Icons（工具栏的图标主题）](https://marketplace.visualstudio.com/items?itemName=miguelsolorio.fluent-icons)
- [一款不错的C/C++主题](https://marketplace.visualstudio.com/items?itemName=Xen.ccpp-theme)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[github](https://github.com/xenkuo/ccpp_theme)
- [Tomorrow and Tomorrow Night Theme Kit（暗色系）](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Theme-TomorrowKit)&nbsp;&nbsp;&nbsp;&nbsp;笔者比较喜欢这个主题
- [Winter is Coming Theme（亮色系）](https://marketplace.visualstudio.com/items?itemName=johnpapa.winteriscoming)
- [Brackets Light Pro（亮色系）](https://marketplace.visualstudio.com/items?itemName=fehey.brackets-light-pro)
- [One Dark Pro（暗色系）](https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme)
- [Min Theme（暗色系+亮色系）](https://marketplace.visualstudio.com/items?itemName=miguelsolorio.min-theme)
- [Dracula（暗色系）](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula)
- [Quiet Light for VSC（亮色系）](https://marketplace.visualstudio.com/items?itemName=onecrayon.theme-quietlight-vsc)
- [Eclipse 经典（亮色系）](https://marketplace.visualstudio.com/items?itemName=LorenzoBilli.eclipse-classic-light)

## 其他插件
- [Thief-Book](https://marketplace.visualstudio.com/items?itemName=C-TEAM.thief-book)
- [小霸王](https://marketplace.visualstudio.com/items?itemName=gamedilong.anes)
- [知乎](https://marketplace.visualstudio.com/items?itemName=niudai.vscode-zhihu)
- [epub reader](https://marketplace.visualstudio.com/items?itemName=renkun.reader)
- [韭菜盒子(看股票)](https://marketplace.visualstudio.com/items?itemName=giscafer.leek-fund)
- [RSS](https://marketplace.visualstudio.com/items?itemName=luyuhuang.rss)
- [LeetCode](https://marketplace.visualstudio.com/items?itemName=LeetCode.vscode-leetcode)
- [虎扑摸鱼助手](https://marketplace.visualstudio.com/items?itemName=chenyaoyi888168.hupumoyu-assistant)
- [NGA摸鱼助手](https://marketplace.visualstudio.com/items?itemName=nga-neko-group-richard.nga-neko-fishes)

## VSCode下载太慢的解决办法
首先在官网找到需要下载的文件，点击下载。  
在浏览器或者下载软件中就可以看到下载地址了，将其复制。
然后将站点内容更换为：
```
vscode.cdn.azure.cn
```
比如:
```
https://az764295.vo.msecnd.net/stable/6c3e3dba23e8fadc360aed75ce363ba185c49794/VSCode-win32-x64-1.81.1.zip
```
替换为
```
https://vscode.cdn.azure.cn/stable/6c3e3dba23e8fadc360aed75ce363ba185c49794/VSCode-win32-x64-1.81.1.zip
```

``vscode.cdn.azure.cn``不提供1.85.0版本，估计以后也不会提供了。可以使用这个地址
```
https://vscode.download.prss.microsoft.com/dbazure/download/stable/af28b32d7e553898b2a91af498b1fb666fdebe0c/VSCode-win32-x64-1.85.0.zip
```

## 插件的管理
随着项目的增多，使用VSCode开发多种语言的时候会安装非常多的插件。为了节省内存开销和插件冲突。可以按如下方式设定：
#### 1.禁用所有插件
除了一些所有项目共用的插件（比如简体中文和主题）外，默认把其他所有插件全部禁用。
#### 2.为每个文件夹(工作区)开启只有在这个工程下才使用的插件
设定方法：点击插件旁边的小齿轮 → 启用(工作区)

## 常用快捷键
在VS Code中，符号（Symbols）的意思是指结构体，函数，变量等。
- Ctrl + 鼠标左键 ： 跳转到定义或者函数
- F12 ： 跳转到定义或者函数
- **Ctrl + .（点）** ： 显示代码操作（就是左边的那个小灯泡）
- Ctrl + ] ： 跳转到定义或者函数（vim插件）
- **Ctrl + F2** ： 智能地选择字符串的所有出现，并且开启多光标
- **Ctrl + F12** ： 转到实现（对于接口和抽象方法）
- **Shift + F12** ： 转到引用
- Alt + ← ： 跳转后返回原处
- Ctrl + t ： 跳转后返回原处（vim插件）
- Ctrl + t ： 列出全局函数名，选择后快速跳转
- Ctrl + Shift + O ： 列出当前文件函数名，选择后快速跳转
- **Ctrl + P** 或者 Ctrl + e ： 快速文件导航（最实用的功能）
- Ctrl + P 然后输入``?`` ： 显示帮助
- Ctrl + R ： 打开最近使用过的文件
- Ctrl + Tab ： 可以列出最近打开的文件，在开发时，两个文件间切换时效率很高。
- **Alt + F12** ： 在预览窗口查看函数
- **Shift + Alt + F12** ： 打开引用视图并表示所有调用(很有用)
- **Ctrl + Space** 或者 Ctrl + i ： 触发建议
- **Ctrl + Shift + P** ： 打开命令导航  
  run build task ： 运行构建任务（对应task.json的build组）  
  run test task ： 运行测试任务（对应task.json的test组）  
  task 空格 ： 快速运行一个自定义task
- Shift + Alt + F ： 代码格式化
- Shift + Alt ： 列编辑模式
- Alt + 单击鼠标左键 ： 多光标选择，选中后 Ctrl+Alt+上 或 Ctrl+Alt+下 可以追加行
- Alt + 鼠标滚轮 ： 快速滚动
- Alt + o ： 在源文件和头文件之间切换（比如log.c和log.h）
- **Ctrl + KV** ： Markdown的编辑和预览左右分割表示（重新映射成 shift+space -> m）
- Ctrl + Shift + V ： 预览markdown文件
- Ctrl + \ ： 左右分割表示当前文件
- Ctrl + Shift + F ： grep查找（重新映射成 shift+space -> g）
- 将函数大纲（outline）拖动到右侧，在右侧“辅助侧边栏”显示
- Shift + Alt + R ： 在os打开当前文件夹
- Ctrl + ` ： 打开终端
- Ctrl + Shift + ` ： 打开新的终端
- Ctrl + Shift + C ： 打开外部终端
- Ctrl + Shift + 5 ： 垂直分割终端
- Ctrl + 1 ： 选择第1个终端
- Ctrl + 2 ： 选择第2个终端
- Ctrl + n ： 选择第n个终端
- Ctrl + Shift + e ： 移动到左侧的资源管理器
- Shift + Alt + ↓ 或者 Shift + Alt + ↑ ： 复制当前行到新的一行
- Alt + ↓ 或者 Alt + ↑ ： 移动当前行
- Ctrl + x ： 删除当前行
- Ctrl + g ： 跳转到特定行
- Ctrl + Alt ： 查看内嵌提示

## 插件无法下载的解决办法
笔者在使用 ``CodeLLDB`` 插件的时候，遇到了无法更新的问题，解决方式如下  
```
curl --create-dirs -o D:\Download\codelldb-x86_64-windows.vsix https://download.njuu.cf/vadimcn/codelldb/releases/download/v1.10.0/codelldb-x86_64-windows.vsix
```
打开VSCode → 扩展 → 右上角的 ``...`` → 从VSIX安装...

## 搜索神器插件-FindItFaster
笔者一直很喜欢 NeoVim下的 ``telescope``，逛github的时候无意间发现了这款插件``FindItFaster``，虽然中文支持有一些问题，但是已经做的很不错了
- [Github地址](https://github.com/tomrijndorp/vscode-finditfaster)

使用前准备：  
1. 将VSCode的默认内置终端设定为 ``PowerShell``  
2. 将4个工具添加到PATH（或者配置到``terminal.integrated.env.windows``）：[fzf](https://github.com/junegunn/fzf) ， [rg](https://github.com/BurntSushi/ripgrep) ， [bat](https://github.com/sharkdp/bat) ，  ``sed``  
NOTE：安装Windows下的git后就有``sed``
3. 设定 ``PowerShell安全策略``
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
4. 删除VSCode默认的 ``Ctrl+j`` 快捷键绑定
```
workbench.action.togglePanel(查看面板可见性)
```

使用方式：  
- Ctrl + Shift + j ： 查找文件
- Ctrl + Shift + u ： 模糊查找内容
- 查找时 Ctrl + j ： 下一个
- 查找时 Ctrl + k ： 上一个


## 常用命令
命令的运行方式为按下 F1 或者 Ctrl + Shift + P
- 将缩进全部转换为制表符(TAB)
```
>Convert indentation to Tabs
```
- 将缩进全部转换为空格
```
>Convert indentation to Spaces
```
- 打开/关闭辅助侧边栏
```
>workbench.action.toggleAuxiliaryBar
```

## VSCode的设定层次关系
系统默认设置（不可修改） → ``用户设置`` → 工作区设置 → ``文件夹设置``  
``后者的设置会覆盖前者``  

注：工作区可以不打开不设置，即 ``无工作区设置``，这种情况的层次为：  
``用户设置`` → ``文件夹设置``  

## 工作区的使用（不推荐使用）
#### 新建一个工作区
文件 → 将工作区另存为...   → 选择保存路径  
保存的文件为 ``.code-workspace`` 扩展名，即工作区文件  
建立工作区后有些文件夹设定会失效，笔者更喜欢无工作区设置。

## 无工作区设置下的管理项目（推荐使用）
使用 [**项目仪表板**](https://marketplace.visualstudio.com/items?itemName=kruemelkatze.vscode-dashboard) 插件，可以很方便的管理工程和任意切换工程

## 配置编辑器
刚下载好的 VSCode 还不符合我们的需求，需要进行配置才能顺手。各个设定所在路径如下
### 全局用户设定文件位置
```
C:\Users\user\AppData\Roaming\Code\User
```
* settings.json
* keybindings.json

### 工作区设定文件位置（不推荐使用）
保存工作区的时候生成的扩展名 .code-workspace 文件，即为工作区设定文件  
在settings语句块里面，加入设定即可
```
{
	"folders": [
		{
			"path": "../path/to"
		}
	],
	"settings": {
		// 加入配置在这里
		"python.languageServer": "Default"
	}
}
```

### 文件夹设定文件位置
文件夹根路径下的 ``.vscode`` 文件夹
- settings.json
- c_cpp_properties.json

## 笔者的设定文件
#### 用户设置（全局）
- [settings.json](VSCode-conf/user/settings.json)
- [keybindings.json](VSCode-conf/user/keybindings.json)
- [tasks.json](VSCode-conf/user/tasks.json) &nbsp;&nbsp;&nbsp;&nbsp;这里定义了使用vbs自动ssh登录服务器的任务，需要将[user@1.2.3.4.vbs](VSCode-conf/vbs/user@1.2.3.4.vbs)放到 ``%AppData%\Code\User\vbs`` 路径下
- [c.json](VSCode-conf/snippets/c.json)&nbsp;&nbsp;&nbsp;&nbsp;c代码片段配置文件（snippets）
- [python.json](VSCode-conf/snippets/python.json)&nbsp;&nbsp;&nbsp;&nbsp;python代码片段配置文件（snippets）
- [java.json](VSCode-conf/snippets/java.json)&nbsp;&nbsp;&nbsp;&nbsp;java代码片段配置文件（snippets）
- [rust.json](VSCode-conf/snippets/rust.json)&nbsp;&nbsp;&nbsp;&nbsp;rust代码片段配置文件（snippets）

## Vim的绑定
因为 Vim 插件是模仿 Vim 模式，很多 Bug，不太推荐使用。 Neovim 的插件是用 NeoVim 作为后端，使用起来体验很不错，所以更推荐使用后者。  
Neovim 插件使用的话只要:  
1. 安装 Neovim  
2. 安装 Neovim 插件  
3. 在 settings.json 配置好 Neovim 的 exe 文件路径  
即可开箱即用。详见笔者的设定文件。

## 文件夹设置（C工程）
所需插件（1个）：C/C++  
[示例工程](../C/CSampleProject/)


## 文件夹设置（Python工程）
所需插件（2个）：Python，Pylance  
可选插件（1个）：Black Formatter  
[示例工程](../Python/PoetryTest/)

#### 关于Python的格式化
使用 [Black Formatter](https://marketplace.visualstudio.com/items?itemName=ms-python.black-formatter) 插件  
安装插件后在工程设定的settings.json内如下设定：
```
"editor.defaultFormatter": "ms-python.black-formatter", //使用Black Formatter插件
"python.formatting.provider": "none",
```
如果使用的是嵌入版（绿色版）Python，需要修改插件脚本 ``lsp_server.py`` (修改前注意备份)
```
C:\Users\user\.vscode\extensions\ms-python.black-formatter-2023.2.0\bundled\tool\lsp_server.py
```
加入内容
```
update_sys_path(
    os.fspath(pathlib.Path(__file__).parent),
    os.getenv("LS_IMPORT_STRATEGY", "useBundled"),
)
```
按下F1，输入 ```black```，选择 ``black formatter：重启服务器`` 重启后即可使用

## 文件夹设置（Rust工程）
所需插件（2个）：rust-analyzer, CodeLLDB  
[示例工程](../Rust/rust_sample/)

## 文件夹设置（Go工程）
所需插件（1个）：Go  
[示例工程](../Go/GoSampleProject/)

## 文件夹设置（Java工程）
所需插件（2个）：Language Support for Java，Debugger for Java  
- [Batch工程](../Java/JavaMavenBatProject/)
- [Web工程](../Java/SpringBootUndertow/)

#### VSCode导入Java工程时，不识别的问题
有些项目的Java工程是Eclipse创建的，在导入的时候会有些问题。  
可以把Java工程里面的Eclipse设定内容全部删除（比如 .project .settings）。  
然后在VSCode中，按F1，输入以下命令清理Java语言服务器工作区
```
Java: Clean Java Language Server Workspace
```
之后即可识别。
#### 另外，Java工程的强制编译的命令为
```
Java: Force Java Compilation
```
也可以使用快捷键： ``Shift + Alt + b``

## 关于老旧的Java工程
有些项目，并不是开发新工程，而是维护老旧工程，这些工程大多数没有严格的执行代码规范，导致VSCode打开之后会提示很多的问题需要修复。  
可以在 ``settings.json`` 的 ``java.settings.url`` 选项中，设置 ``org.eclipse.jdt.core.prefs`` 文件来忽略问题提示。  
一个把绝大多数问题都忽略的设定文件如下：  
- [org.eclipse.jdt.core.prefs](../Java/.settings/org.eclipse.jdt.core.prefs)  

另外``org.eclipse.jdt.core.prefs``的官方文档在这里：
- [官方文档](https://help.eclipse.org/neon/topic/org.eclipse.jdt.doc.isv/reference/api/org/eclipse/jdt/core/JavaCore.html)  


## 文件夹设置（C#工程）
所需插件（1个）：C#  
- [.NET Framework 示例工程](../Go/Grpc/netframework/)
- [.NET Core 示例工程](../Framework/BackendAspCore/)

## VSCode里面跳转不可用时的解决办法
1. 先把相关语言的所有插件全部禁用
2. 关闭所有VSCode
3. 重新打开VSCode
4. 启用相关语言的插件

## 使用VSCode编译和调试（C工程）

tasks用于在launch前执行任务，launch用于读取执行文件。
这两者经常组合起来用于需要编译语言的自动编译+自动执行，下面时以C为例的设定文件
在工程根路径的 .vscode 文件夹内新建如下2个文件
 - tasks.json
 - launch.json

配置好之后，打开一个 .c 文件，点击右上角的“播放按钮”，弹出调试配置列表  
在列表中选中 launch.json 中 name 定义的 ``GCC 编译和运行`` 即可

另外，在调试窗口，char数组变量是按照数组来表示内容的。
如果想类似字符串一样表示全部内容可以在watch区域加上 &变量名 ``0`` 来实现

## 使用VSCode编译和调试（Python工程）
无需特别设定tasks.json和launch.json，直接打开一个 .py 文件，点击右上角的“播放按钮”即可

## 预定义变量
VSCode支持下面的预定义变量:  

- ${workspaceFolder} - 当前工作目录(根目录)
- ${workspaceFolderBasename} - 当前文件的父目录
- ${file} - 当前打开的文件名(完整路径)
- ${relativeFile} - 当前根目录到当前打开文件的相对路径(包括文件名)
- ${relativeFileDirname} - 当前根目录到当前打开文件的相对路径(不包括文件名)
- ${fileBasename} - 当前打开的文件名(包括扩展名)
- ${fileBasenameNoExtension} - 当前打开的文件名(不包括扩展名)
- ${fileDirname} - 当前打开文件的目录
- ${fileExtname} - 当前打开文件的扩展名
- ${cwd} - 启动时task工作的目录
- ${lineNumber} - 当前激活文件所选行
- ${selectedText} - 当前激活文件中所选择的文本
- ${execPath} - vscode执行文件所在的目录
- ${defaultBuildTask} - 默认编译任务(build task)的名字

更多：  
https://zhuanlan.zhihu.com/p/92175757?ivk_sa=1024320u&utm_id=0

## Python工程的格式化代码

Python插件是不支持格式代码的，这里笔者使用black格式代码。具体设置看设定文件即可。  
除了设定还需要pip安装black。  
使用清华源安装black
```
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple black
```
安装好后会在python的Scripts内发现black.exe，配置到设定文件即可。

## 配置代码片段
代码片段配置所在路径
```
C:\Users\user\AppData\Roaming\Code\User\snippets
```
按下 Ctrl + Shift + p，然后输入 snippets ，会有提示 Configure User Snippets。选择后再次选择对应的开发语言，即可打开配置文件。  
下面以1个c语言举例(c.json)
```
{
	// 添加main函数
	"添加main函数": {
		"prefix": ["ma", "mai", "main"],
		"body": [
			"#include <stdio.h>",
			"int main (int argc, char *argv[]) {",
			"\treturn 0;",
			"}",
		],
		"description": "添加main函数"
	},
}
```
设置好以后，输入ma即可弹出建议，选择“添加main函数”即可。

#### 在线配置snippets的网站
- [snippet-generator.app](https://snippet-generator.app/?mode=vscode)

## 其他

### 使用VSCode集成终端配置Git-bash时，编码不是utf8的问题
现象为使用VSCode的集成终端打开Git-bash不是utf8编码，发行chcp.com命令结果为
```bash
chcp.com
活动代码页: 936
```
而用Git-bash的终端（minnty）打开时为utf8编码。
将如下代码加到 ~/.bash_profile 即可解决
```bash
chcp.com 65001
```

### 关于TAB符和换行符的渲染
有如下几套套方案：

1. 使用默认 +  [显示换行符](https://marketplace.visualstudio.com/items?itemName=medo64.render-crlf)  
设定文件中如下设定即可在选中的时候表示
```
"editor.renderWhitespace": "selection",
```

2. 使用插件 [Visible Whitespace](https://marketplace.visualstudio.com/items?itemName=yoshi389111.visible-whitespace)  
Visible Whitespace这个插件可以渲染 TAB符，全角空格，回车，文件结束符（EOF） 的显示内容和颜色  


3. 使用插件 [Highlight](https://marketplace.visualstudio.com/items?itemName=fabiospampinato.vscode-highlight)  
通过正则表达式匹配来渲染
```
"highlight.regexes": {
	"(\\t)": [ // 匹配tab符号
		{
			"backgroundColor": "#FF646415", //设置背景色，一定要是透明色
			//"color": "#1f1f1f",
		}
	],
	"([\u3000])": [ // 匹配全角空格
		{
			"backgroundColor": "#5050ff15", //设置背景色，一定要是透明色
			//"color": "#1f1f1f",
		}
	],
},
```

4. 使用插件 [Whitespace++](https://marketplace.visualstudio.com/items?itemName=chihiro718.whitespacepp)  
基本同方案2的 ``Visible Whitespace`` 但是，这个插件有一些渲染时间的Bug，不太推荐使用


### 查看VSCode当前颜色设置
按下 ``F1`` ，输入 ``color`` ，选择 ``Developer: Generate Color Theme From Current Settings``  
即 ``开发人员：使用当前设置生成颜色主题``  
会新打开一个未命名文件，里面是当前颜色设置代码

### 颜色查找
* [brandcolors](https://brandcolors.net/)
* [colorhunt](https://colorhunt.co/palette/c4dfdfd2e9e9e3f4f4f8f6f4)

### 旧版本
VS Code 版本 1.70.3 是 Windows 7 用户的最后一个可用版本，版本 1.79.1 将是 Windows 8 和 8.1 用户的最后一个可用版本

### 开发嵌入式SQL的时候EXEC SQL语句块的报错
可以将 SQL 代码包装在下面语句块中
```c
#ifndef __INTELLISENSE__
#endif
```

### VSCode开发人员工具
```
Developer: Toggle Developer Tools
```

### VSCode性能诊断
当VSCode启动变慢的时候可按F1，输入下面的命令诊断
```
Developer: Show Running Extensions
Developer: Startup Performance
```

### Thief-Book的使用
下载好插件以后，在 ``settings.json`` 中设定如下
```
{
	"thiefBook.filePath": "D:\\path\\to\\book.txt",
	"thiefBook.isEnglish": false,
	//"thiefBook.currPageNumber": 200,
}
```
其中 ``thiefBook.currPageNumber`` 这个设定如果是在 ``文件夹设定下`` 只有快速跳转的时候打开注释，其他时候一定要注释掉，不然会导致跳转问题

在 ``keybindings.json`` 中设定如下
```
[
	{
		"key": "pageup",
		"command": "extension.getPreviousPage"
	},
	{
		"key": "pagedown",
		"command": "extension.getNextPage"
	},
]
```

# 更多
- [VSCode官方文档](https://code.visualstudio.com/docs)
- [VSCode官方API](https://code.visualstudio.com/api)
- [VSCode提示和技巧](https://github.com/Microsoft/vscode-tips-and-tricks)
- [awesome vscode](https://github.com/viatsko/awesome-vscode)
- [打造舒适的VSCode开发环境](https://mp.weixin.qq.com/s/MVR5rV2LkH8_GHCtP6SHug)

## 1秒实现VS Code浏览GitHub代码
https://mp.weixin.qq.com/s/7gmIInmz5021VX5lEvEUAg
