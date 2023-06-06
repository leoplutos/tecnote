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
* [**简体中文**](https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-zh-hans)
* [日文(可选)](https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-ja)
* [VSCodeVim(可选)](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim)
* [**显示行尾空格**](https://marketplace.visualstudio.com/items?itemName=shardulm94.trailing-spaces)
* [**Whitespace++**](https://marketplace.visualstudio.com/items?itemName=chihiro718.whitespacepp)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：和下面的显示换行符选择一个即可，这个可自定义的内容多些
* [显示换行符(可选)](https://marketplace.visualstudio.com/items?itemName=medo64.render-crlf)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：和上面的Whitespace++选择一个即可
* [自动补全插件TabNine(可选)](https://marketplace.visualstudio.com/items?itemName=TabNine.tabnine-vscode)
* [**C/C++**](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
* [**Python**](https://marketplace.visualstudio.com/items?itemName=ms-python.python)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：Python插件安装好后会依赖安装Pylance，只要这2个即可
* [**Java**](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)
* [**Rust**](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)
* [Hex Editor(可选)](https://marketplace.visualstudio.com/items?itemName=ms-vscode.hexeditor)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：运行方式为：按下F1，然后输入：open active file in hex editor
* [嵌入式SQL高亮(可选)](https://marketplace.visualstudio.com/items?itemName=shanduur.c-embedded-sql)
* [Project Manager(可选)](https://marketplace.visualstudio.com/items?itemName=alefragnani.project-manager)
* [Thunder Client(可选)](https://marketplace.visualstudio.com/items?itemName=rangav.vscode-thunder-client)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：REST API 测试工具
* [Draw.io(可选)](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio)
* [Polacode(可选)](https://marketplace.visualstudio.com/items?itemName=pnp.polacode)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：代码截图
* [vscode-json(可选)](https://marketplace.visualstudio.com/items?itemName=andyyaldoo.vscode-json)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：json美化

## DB插件
* [Sql Tools(可选)](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools)

## 主题插件
* [主题流行趋势](https://vscodethemes.com/)
* [**Tomorrow and Tomorrow Night Theme Kit**（暗色系）](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Theme-TomorrowKit)&nbsp;&nbsp;&nbsp;&nbsp;笔者比较喜欢这个主题
* [Winter is Coming Theme（亮色系）](https://marketplace.visualstudio.com/items?itemName=johnpapa.winteriscoming)
* [Brackets Light Pro（亮色系）](https://marketplace.visualstudio.com/items?itemName=fehey.brackets-light-pro)
* [One Dark Pro（暗色系）](https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme)
* [Min Theme（暗色系+亮色系）](https://marketplace.visualstudio.com/items?itemName=miguelsolorio.min-theme)
* [Dracula（暗色系）](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula)
* [Quiet Light for VSC（亮色系）](https://marketplace.visualstudio.com/items?itemName=onecrayon.theme-quietlight-vsc)

## 常用快捷键
在VS Code中，符号的意思是指结构体，函数，变量等。
- Ctrl+鼠标左键 ： 文件、函数等跳转。
- F12 ： 转到定义
- Ctrl + ] ： 转到定义（vim插件）
- **Ctrl + F12** ： 转到实现（对于接口和抽象方法）
- **Shift + F12** ： 转到引用
- Alt + ← ： 跳转后返回原处
- Ctrl + t ： 跳转后返回原处（vim插件）
- Ctrl + t ： 列出全局函数名，选择后快速跳转
- Ctrl + Shift + O ： 列出函数名，选择后快速跳转
- **Ctrl + P** ： 快速文件导航（最实用的功能）
- Ctrl + Tab ： 可以列出最近打开的文件，在开发时，两个文件间切换时效率很高。
- **Alt + F12** ： 在预览窗口查看函数
- **Shift + Alt + F12** ： 打开引用视图
- **Ctrl + Space** ： 触发建议小部件。
- **Ctrl + Shift + P** ： 打开命令导航  
  run build task ： 运行构建任务（对应task.json的build组）  
  run test task ： 运行测试任务（对应task.json的test组）
- Shift + Alt + F ： 代码格式化
- **Ctrl + KV** ： Markdown的编辑和预览左右分割表示（重新映射成 shift+space -> m）
- Ctrl + Shift + V ： 预览markdown文件
- Ctrl + \ ： 左右分割表示当前文件
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
* [c.json](VSCode-conf/snippets/c.json)&nbsp;&nbsp;&nbsp;&nbsp;c代码片段配置文件（snippets）
* [python.json](VSCode-conf/snippets/python.json)&nbsp;&nbsp;&nbsp;&nbsp;python代码片段配置文件（snippets）

#### 文件夹设置（C工程）
&nbsp;&nbsp;所需插件数量：1  
&nbsp;&nbsp;插件名称：C/C++  
&nbsp;&nbsp;[文件在这里](../C/CSampleProject/.vscode)
* settings.json
* c_cpp_properties.json
* launch.json
* tasks.json


#### 文件夹设置（Python工程）
&nbsp;&nbsp;所需插件数量：2  
&nbsp;&nbsp;插件名称：Python，Pylance  
* [settings.json](VSCode-conf/python-project/settings.json)
* [.env](VSCode-conf/python-project/.env)
* [main.py](VSCode-conf/python-project/main.py)

## 使用VSCode编译和调试（C工程）

tasks用于在launch前执行任务，launch用于读取执行文件。
这两者经常组合起来用于需要编译语言的自动编译+自动执行，下面时以C为例的设定文件
在工程根路径的 .vscode 文件夹内新建如下2个文件
 * tasks.json
 * launch.json

配置好之后，打开一个 .c 文件，点击右上角的“播放按钮”，弹出调试配置列表  
在列表中选中 launch.json 中 name 定义的 [GCC 编译和运行] 即可

另外，在调试窗口，char数组变量是按照数组来表示内容的。
如果想类似字符串一样表示全部内容可以在watch区域加上 &变量名[0] 来实现

## 使用VSCode编译和调试（Python工程）
无需特别设定tasks.json和launch.json，直接打开一个 .py 文件，点击右上角的“播放按钮”即可

## 预定义变量
VSCode支持下面的预定义变量:  

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

## 其他

### 颜色查找

* [colorhunt](https://colorhunt.co/palette/c4dfdfd2e9e9e3f4f4f8f6f4)

### 旧版本
VS Code 版本 1.70.3 是 Windows 7 用户的最后一个可用版本，版本 1.79.1 将是 Windows 8 和 8.1 用户的最后一个可用版本

### 开发嵌入式SQL的时候EXEC SQL语句块的报错
可以将 SQL 代码包装在下面语句块中
```c
#ifndef __INTELLISENSE__
#endif
```
