# Windows Terminal

## Windows Terminal简介
Windows平台上除了cmd以外，还有power shell，但使用起来的体验跟Linux的shell相比，简直天差地别。不谈相关命令语法本身的设计问题，只谈cmd和power shell的界面，比如多国语言显示、代码着色、字体美观程度等等，都不尽如人意。

微软新推出的Windows Terminal有了飞一样的提升，不光颜值担当，内功也相当深厚，甚至具备显卡GPL加速渲染的能力，所以使用 Windows Terminal（终端） + Git Bash（Shell）是一个很不错的方案。

## 安装
Window11系统自带，Windows10有两种安装方式：  
* 1.直接打开 Microsoft Store ，搜索 terminal 进行安装。  

* 2.打开该项目在Github上的Release页面，下载安装（注意安装稳定版，不安装Preview版）：  
https://github.com/microsoft/terminal/releases  
下载扩展名为 .msixbundle 的文件双击安装即可

## 笔者使用的配色
打开设定文件，在 ``schemes`` 的地方加入如下内容。(配色名为``lch-dark``)
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


## Windows Terminal 配置 Git bash 为默认终端
设置 → 启动 → 默认配置文件  
(设定文件位置为：C:\Users\User\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json)  

#### 具体 json 文件配置
#### 加入自定义快捷键
在 actions 下加入
```
        ,{ "command": { "action": "sendInput", "input": "clearb\n" }, "keys": "ctrl+f1" }    //Ctrl + F1:发送clearb回车
        ,{ "command": { "action": "sendInput", "input": "dashboard source -output /dev/pts/x" }, "keys": "ctrl+f2" }    //Ctrl + F2:发送gdb的dashboard命令-重定向代码
        ,{ "command": { "action": "sendInput", "input": "dashboard source -style height 0" }, "keys": "ctrl+f3" }    //Ctrl + F3:发送gdb的dashboard命令-设定代码全屏显示
```
更多：  
https://learn.microsoft.com/zh-cn/windows/terminal/customize-settings/actions  

#### 加入git-bash设定
在 copyFormatting 后加入
```
    "copyFormatting": "none",
    "copyOnSelect": true,
    "defaultProfile": "{0447c200-addf-4775-a019-dbe0c1145a62}",
    "profiles": 
    {
        "defaults": 
        {
            "colorScheme": "Tango Dark",
            "font": 
            {
                "face": "JetBrains Mono",
                "size": 14.0
            }
        },
        "list": 
        [
            {
                "commandline": "D:\\Tools\\WorkTool\\Team\\Git\\bin\\bash.exe -i -l",
                "guid": "{0447c200-addf-4775-a019-dbe0c1145a62}",
                "hidden": false,
                "icon": "D:\\Tools\\WorkTool\\Team\\Git\\mingw64\\share\\git\\git-for-windows.ico",
                "name": "git-bash",
                "startingDirectory": "~",
                "tabTitle": "bash"
            }
        ]
    },
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

## Windows Terminal 启动方式
* 1.Windows键 + r，输入
```
wt
```
* 2.找到安装路径，创建桌面快捷方式  
在 git bash下输入
```bash
which wt
```
得知路径为：  
C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.16.10262.0_x64__8wekyb3d8bbwe
* 3.在资源管理器地址栏输入
```
wt -d .
```