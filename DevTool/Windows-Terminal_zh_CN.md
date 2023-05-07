# Windows Terminal

## Windows Terminal简介
Windows平台上除了cmd以外，还有power shell，但使用起来的体验跟Linux的shell相比，简直天差地别。不谈相关命令语法本身的设计问题，只谈cmd和power shell的界面，比如多国语言显示、代码着色、字体美观程度等等，都不尽如人意。

新推出的Windows Terminal有了飞一样的提升，不光颜值担当，内功也相当深厚，甚至具备显卡GPL加速渲染的能力，所以使用 Windows Terminal（终端） + Git Bash（Shell）是一个很不错的方案。

## 安装
有两种安装方式：  
* 1.直接打开Microsoft Store，搜索terminal进行安装。  

* 2.打开该项目在Github上的Release页面，下载安装：  
https://github.com/microsoft/terminal/releases

## Windows Terminal 配置 Git bash 为默认终端
设置 → 启动 → 默认配置文件  

具体 json 文件配置：
```
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
                "commandline": "D:\\Tools\\WorkTool\\Team\\Git\\bin\\bash.exe --login -i -l",
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

在 bash.exe 后面加 --login -i -l 配置，这样激活 Git Bash 就会加载 ~/.bash_profile 的配置

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
c:/Program Files/WindowsApps/Microsoft.WindowsTerminal_1.16.10262.0_x64__8wekyb3d8bbwe  
* 3.在资源管理器地址栏输入
```
wt -d .
```