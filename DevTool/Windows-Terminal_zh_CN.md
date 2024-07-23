# Windows Terminal

## Windows Terminal简介
Windows平台上除了cmd以外，还有power shell，但使用起来的体验跟Linux的shell相比，简直天差地别。不谈相关命令语法本身的设计问题，只谈cmd和power shell的界面，比如多国语言显示、代码着色、字体美观程度等等，都不尽如人意。

微软新推出的Windows Terminal有了飞一样的提升，不光颜值担当，内功也相当深厚，甚至具备显卡GPL加速渲染的能力。

## 安装
Window11系统自带，Windows10有两种安装方式：  
* 1.直接打开 Microsoft Store ，搜索 terminal 进行安装。  

* 2.打开该项目在Github上的Release页面，下载安装（注意安装稳定版，不安装Preview版）：  
https://github.com/microsoft/terminal/releases  
下载扩展名为 ``.msixbundle`` 的文件双击安装即可  

* 3.绿色版：  
从本版``1.17``开始，会有绿色版的 zip 下载，支持可移植模式。  
启用可移植模式：  
可移植模式需要手动开启。 解压缩 zip 后，在 WindowsTerminal.exe 的同目录下创建名为 ``.portable`` 的文件后即可开启。

## 配置文件
各个版本的配置路径位置：  
#### 终端（稳定版/通用版）
```
%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
```
#### 终端（预览版）
```
%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json
```
#### 终端（未打包：Scoop、Chocolately 等）
```
%LOCALAPPDATA%\Microsoft\Windows Terminal\settings.json
```

## 快捷键
- Ctrl + Shift + p ： 打开命令中心

## 配色

打开设定文件，在 ``schemes`` 的地方加入如下内容。

### 暗色系

配色名为``lch-dark``
```
    "schemes":
    [
        {
            "background": "#1D1F21",
            "black": "#000000",
            "blue": "#2472C8",
            "brightBlack": "#666666",
            "brightBlue": "#3B8EEA",
            "brightCyan": "#29B8DB",
            "brightGreen": "#23D18B",
            "brightPurple": "#D670D6",
            "brightRed": "#F14C4C",
            "brightWhite": "#E5E5E5",
            "brightYellow": "#F5F543",
            "cursorColor": "#00FFFF",
            "cyan": "#11A8CD",
            "foreground": "#DADADA",
            "green": "#0DBC79",
            "name": "lch-dark",
            "purple": "#BC3FBC",
            "red": "#CD3131",
            "selectionBackground": "#224F76",
            "white": "#E5E5E5",
            "yellow": "#E5E510"
        },
    ],
```


### 亮色系

配色名为``qy-light``
```
    "schemes":
    [
        {
            "background": "#FCF4DC",
            "black": "#1E1E1E",
            "blue": "#4040FF",
            "brightBlack": "#666666",
            "brightBlue": "#8080FF",
            "brightCyan": "#00DCDC",
            "brightGreen": "#16C60C",
            "brightPurple": "#FF1CFF",
            "brightRed": "#EF2929",
            "brightWhite": "#FFFFFF",
            "brightYellow": "#FCE94F",
            "cursorColor": "#000000",
            "cyan": "#00C0C0",
            "foreground": "#1E1E1E",
            "green": "#4E9A06",
            "name": "qy-light",
            "purple": "#75507B",
            "red": "#FF0000",
            "selectionBackground": "#595AB7",
            "white": "#E7E7E7",
            "yellow": "#C4A000"
        }
    ],
```

## 自定义内容
打开设定文件，在 ``actions`` 的地方加入如下内容。
- Alt + k ： 清空屏幕
- Alt + z ： 进入/退出禅模式
```
    "actions":
    [
        {
          "name": "Clear Screen",
          "command": { "action": "sendInput", "input": "clear\r"},
          "icon": "⌨",
          "keys": "alt+k"
        },
        {
          "name": "Toggle Zen Mode",
          "command": "toggleFocusMode",
          "icon": "💡",
          "keys": "alt+z"
        },
        {
            "name": "Source personal bashrc",
            "command":
            {
                "action": "sendInput",
                "input": "source ~/work/lch/rc/bashrc/.bashrc-personal\r"
            },
            "icon": "⛓",
            "keys": "alt+s"
        }
    ],
```

## Windows Terminal 配置 Git bash
打开设定文件，在 ``commandline`` 处按如下设置即可
```
D:\\Tools\\WorkTool\\Team\\Git\\bin\\bash.exe -i -l
```
icon位置
```
D:\\Tools\\WorkTool\\Team\\Git\\mingw64\\share\\git\\git-for-windows.ico
```
在 bash.exe 后面加 -i -l 配置( -l 等于 --login )，这样激活 Git Bash 就会加载 ~/.bash_profile 的配置

## 资源管理器地址妙用，直接在 Windows Terminal 打开当前文件夹

alt + d 可以直接把光标移动到资源管理器地址栏

用 Windows Terminal 打开当前路径
```
wt -d .
```

用 cmd 打开当前路径
```
cmd
```

## 更多：  
https://learn.microsoft.com/zh-cn/windows/terminal/customize-settings/actions
