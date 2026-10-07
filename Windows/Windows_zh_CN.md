# Windows

## 激活
https://github.com/massgravel/Microsoft-Activation-Scripts  
https://github.com/abbodi1406/KMS_VL_ALL_AIO  

## Windows10 技巧

### 利用微软官方工具制作U盘启动盘
[媒体创建工具](https://www.microsoft.com/zh-cn/software-download/windows10)

### 右键 → 发送到
``Win键 + r`` 然后输入
```bash
shell:sendto
```
可以打开，一般地址为
```
%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo
```
将快捷方式粘贴到此即可  
这里记录几个开发工具  
1. Gvim
新建快捷方式，输入地址
```
"D:\Tools\WorkTool\Text\vim90\gvim.exe" -p --remote-tab-silent "%*"
```
2. VSCode
直接将VSCode复制到这里即可

### 开机自动运行
``Win键 + r`` 然后输入
```bash
shell:startup
```
可以打开，一般地址为
```
%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```
将快捷方式粘贴到这里即可

### 使用 CURL 命令下载

支持断点续传的下载
```bash
curl -L -O https://download.url/a.zip  -C -
```

### 测试TCP网络端口
详见 [这里](./Powershell_zh_CN.md)

### 添加双拼

添加小鹤的方法有两种

1. 微软拼音设置里面 ``添加双拼方案``，手工输入布局
2. 用写字板新建立一个 ``小鹤双拼-Win10.reg`` 文件，内容如下

```
Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputMethod\Settings\CHS]
"Enable Double Pinyin"=dword:00000001
"DoublePinyinScheme"=dword:0000000a
"UserDefinedDoublePinyinScheme0"="小鹤双拼*2*^*iuvdjhcwfg^xmlnpbksqszxkrltvyovt"
```

## 系统优化工具

### Optimizer(已不维护)
[Optimizer](https://github.com/hellzerg/optimizer) 是一款便携式实用工具，支持垃圾清理、注册表修复、启动项管理，关闭Windows系统中不需要的功能

### Win11Debloat
[Win11Debloat](https://github.com/Raphire/Win11Debloat) 是一个PowerShell脚本，可以删除Windows 11预装的应用和功能，禁用遥测，删除Bing搜索等，以提高系统性能和用户体验

### cmder

[Cmder](https://cmder.app/) 是一个跨平台的命令行工具，支持Windows、Linux和Git Bash等多种环境

## 精简版OS

### AtlasOS
[AtlasOS](https://github.com/Atlas-OS/Atlas) 是一款基于 Windows 10/11 定制的操作系统，通过删除Windows一些不必要的组件与功能，减少进程，降低延迟，旨在帮助老硬件发挥更好的性能

## Windows11 技巧

### 重启网络服务
有时候网络会变得很慢，使用下面的命令可以重启网络服务修复问题

``Windows键 + X`` ，选择 ``终端管理员``，启动终端后运行下面的命令

```
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
```

然后重启电脑

### 跳过微软账号登录（创建本地账户）
1. 断开所有网络（拔掉网线，不要连 Wi-Fi）
2. 在联网界面按下 ``Shift + F10``（部分笔记本是 ``Fn + Shift + F10``）
3. 输入：``OOBE\BYPASSNRO`` 并回车
4. 电脑重启后，再次到联网界面，点击 ``我没有 Internet 连接`` -> ``继续执行受限设置``
5. 创建本地账户：现在你就可以输入喜欢的用户名，设置密码（或留空直接下一步），从而成功创建本地账户进入系统了

另外一种方式创建本地账户  
1. 账号：``no@thankyou.com``  
2. 密码：``随意``  
3. 然后系统就会提示这个账户使用错误密码太多被暂时锁定，然后点击下一步就可以建立本地账户了

### 恢复经典右键菜单

``Win键 + x`` 选择 ``Windows终端（管理员）`` 以打开管理员权限的命令提示符

输入命令
```bash
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```

接着，强制关闭资源管理器进程
```bash
taskkill /f /im explorer.exe
```
然后，启动一个新的资源管理器进程
```bash
start explorer.exe
```

反之如果需要恢复Windows11默认右击菜单，使用命令
```bash
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /va /f
```

### 删除我的电脑中的快捷键图标

``regedit`` 打开注册表编辑器，找到
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
```
这里面即可快捷图标，右键删除即可

### 让 VSCode 启动时默认英文输入法

打开 ``Windows 设置`` → ``时间和语言（時刻と言語）`` → ``输入（入力）`` → ``高级键盘设置（キーボードの詳細設定）``

勾选：

``允许我为每个应用窗口使用不同的输入法（アプリ ウィンドウごとに異なる入力方式を設定する）``

### 日历定制

``Windows开始菜单`` → 输入``区域``(中文) 或者 ``地域``(日文)
#### 设定每周开始日每周一

- 中文系统设定
    ``一周的第一天`` → 修改为 ``星期一``

- 日文系统设定
    ``週の最初の曜日`` → 修改为 ``月曜日``

#### 设定显示周

- 中文系统设定
    ``其他设置`` → ``日期`` → ``短日期`` →  修改为 ``yyyy/M/d dddd``

- 日文系统设定
    ``追加の設定`` → ``日付`` → ``短い形式`` →  修改为 ``yyyy/M/d dddd``

### 录屏使用OBS
OBS（Open Broadcaster Software）是一款支持多平台（Windows、macOS、Linux）的免费开源软件，主要用于视频录制和实时流媒体直播

 - [官网](https://obsproject.com/)
 - [github](https://github.com/obsproject/obs-studio)

### mouse-control.autohotkey
一个基于 AutoHotkey 的键盘鼠标控制工具，用 WASD 或 Vim 的 HJKL 操作鼠标、点击和滚动，可作为 Windows 自带 `鼠标键（Mouse Keys）` 的增强替代方案

https://github.com/4strid/mouse-control.autohotkey

### 截图和录屏
- ``Win键 + Shift + s`` → 截图
- ``Win键 + Shift + r`` → 录屏
- ``Win键 + g`` → XBox录屏

### Windows11系统下按下 Win + G 无法打开 XBox 录像

1. 按下 Win + G

2. 检查后台服务是否运行  
    按 ``Ctrl + Shift + Esc`` 打开 任务管理器  
    查看是否有 ``GameBar.exe`` 或 ``Xbox Game Bar 相关进程``正在运行  
    如果没有，打开 ``Xbox`` → ``設定`` → ``ユーザー補助`` → ``Game Bar``

## Office

### Vole Office

``Vole Office`` 是微软 Office 的免费平替，套件包括Vole Windows Expedition, Vole Word, Vole Excel, Vole Scheduler, Vole Diagram 和Vole Paint。单EXE文件，大小230MB，无需安装，U盘内也可以使用。支持 Windows7 和更高操作系统。

 - [官网](https://sanwhole.com/Products/VoleOffice)
 - [github](https://sanwhole.com/PubData/Installer/VoleOffice.exe)

## Office Web Viewer 介绍（公网解决方案）

如果你的项目文件公网可以访问，那么选择它即可

Office Web Viewer 是微软提供的一项免费的在线 Office 文档预览服务，可以直接在网页浏览器中显示 Excel、Word、PowerPoint 等 Office 文档。
通过该服务，即使用户的电脑或移动设备上没有安装 Microsoft Office，也可以直接在线查看文档内容，因此非常适合在网站或 Web 系统中实现 Office 文件的在线预览功能。

Office Web Viewer 由微软提供，文档展示效果较为完整，使用方式也非常简单。首先，需要确保待预览的 Office 文件可以通过互联网公开访问，并取得该文件的 URL。
例如，一个公开的 Excel 文件地址为：  
https://webbibouroku.com/wp-content/uploads/Book1.xlsx

然后，将该文件的 URL 作为 src 参数传递给 Office Web Viewer：  
https://view.officeapps.live.com/op/view.aspx?src=文件URL

实际使用时，建议先对文件 URL 进行 URL 编码。例如：  
https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fwebbibouroku.com%2Fwp-content%2Fuploads%2FBook1.xlsx

如果文件存储在 Azure Blob Storage 等服务中，同样可以使用这种方式，只需要将 Blob 文件的可访问 URL 作为 src 参数即可：  
https://view.officeapps.live.com/op/view.aspx?src=Blob文件的URL

因此，在 Web 系统中集成 Office Web Viewer 时，整体流程可以概括为：获取 Office 文件的公开访问 URL → 对 URL 进行编码 → 拼接到 Office Web Viewer 的 src 参数中 → 在浏览器中打开生成的 Viewer URL。这样就可以在不要求用户安装 Office 软件的情况下，实现 Office 文档的在线浏览和预览。


## Collabora CODE 介绍（私网解决方案）

如果你的项目文件在私网，那么选择它即可

一个免费、开源、可通过 Docker 自托管的网页版 Office 文档查看与编辑服务，支持 Word、Excel、PowerPoint 等格式

https://github.com/CollaboraOnline/online.mirror

https://hub.docker.com/r/collabora/code

自部署方式
```bash
# 拉取镜像
docker pull collabora/code:24.04.13.2.1
# 启动容器
docker run -d \
  --name collabora \
  -p 9980:9980 \
  -e "extra_params=--o:ssl.enable=false" \
  --restart unless-stopped \
  collabora/code:24.04.13.2.1
```
启动后访问  
http://localhost:9980

## iPhone
 - [Apple 设备](https://apps.microsoft.com/detail/9np83lwlpz9k?hl=zh-CN&gl=JP)
 - [iTunes64位下载](https://www.apple.com/itunes/download/win64)

## 其他

### mklink命令
mklink 是 Windows 的一个命令，用来创建链接（Link），类似 Linux 中的 ln -s。
```
mklink C:\tools\claude.exe D:\ClaudeCode\claude.exe
```
在 `C:\tools` 目录下创建一个名为 `claude.exe` 的链接，实际指向 `D:\ClaudeCode\claude.exe`

假设你把： `C:\tools` 加入了环境变量 PATH，那么无论当前在哪个目录，都可以直接执行：
```
claude
```
Windows 会：在 `PATH` 中找到 `C:\tools` 发现 `claude.exe`，
实际跳转到 `D:\ClaudeCode\claude.exe` 运行程序

例子：
```
mklink C:\path\to\rg.exe C:\Tools\Search\ripgrep\rg.exe
mklink C:\path\to\bat.exe C:\Tools\Search\bat\bat.exe
mklink C:\path\to\fzf.exe C:\Tools\Search\fzf\fzf.exe
```

### Coreutils for Windows
Coreutils for Windows 是一组由 Microsoft 维护的 UNIX 风格命令行工具。将 Linux/Unix 常用命令（如 ls、cp、mv、cat 等）移植到 Windows，让你在 Windows 命令行中也能使用熟悉的 Unix 工具

https://learn.microsoft.com/zh-cn/windows/core-utils/overview

```bash
winget install Microsoft.Coreutils
```

### PowerToys
PowerToys 是微软为 `Windows 10 / 11` 提供的一套免费、开源的系统增强工具集，主要用于提高 Windows 的效率和可定制性。

https://learn.microsoft.com/zh-cn/windows/powertoys/


### PowerToys - ZoomIt

ZoomIt 是一个屏幕画图工具

https://learn.microsoft.com/zh-cn/sysinternals/downloads/zoomit

下载后运行 `ZoomIt64.exe` 即可开始，笔者一般的设定如下

- Draw（屏幕画图）：快捷键 `Ctrl + Alt + D`
- Record（屏幕录制）：快捷键 `Ctrl + Alt + R`
- 其他全部设定为： `None`

### voidImageViewer
一款专注速度与轻量化的 Windows 图片查看器，支持 BMP、GIF、PNG、JPG、TIF、WEBP 及动画 GIF/WEBP，并可与 Everything 联动快速浏览图片。

https://github.com/voidtools/voidImageViewer

### TizuMark
基于 Rust + Tauri 打造的轻量开源 Markdown 编辑器，主打类似 Typora 的所见即所得、实时预览、大纲、KaTeX、Mermaid 和多格式导出，目前支持 Windows，macOS/Linux 仍在规划中。

https://github.com/tizuio/TizuMark-Markdown-Editor

### WindowsDeveloperConfig
微软官方提供的 Windows 开发环境自动化配置工具，可一键安装常用开发工具、配置 Windows/WSL，并按需部署 Java、Python、.NET、Node.js、SQL 等开发环境

https://github.com/microsoft/WindowsDeveloperConfig

### 开发环境构建 mise

mise 是一个统一的开发环境与工具版本管理器，可用来安装、切换和管理 Node.js、Python、Go、Rust 等多种开发工具的版本。

https://github.com/jdx/mise  
https://mise.jdx.dev/  

```
winget install jdx.mise
```
