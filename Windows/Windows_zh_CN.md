# Windows

## 激活
https://github.com/massgravel/Microsoft-Activation-Scripts  
https://github.com/abbodi1406/KMS_VL_ALL_AIO  

## Windows10 技巧

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

### Optimizer
[Optimizer](https://github.com/hellzerg/optimizer) 是一款便携式实用工具，支持垃圾清理、注册表修复、启动项管理，关闭Windows系统中不需要的功能

### Win11Debloat
[Win11Debloat](https://github.com/Raphire/Win11Debloat) 是一个PowerShell脚本，可以删除Windows 11预装的应用和功能，禁用遥测，删除Bing搜索等，以提高系统性能和用户体验

### cmder

[Cmder](https://cmder.app/) 是一个跨平台的命令行工具，支持Windows、Linux和Git Bash等多种环境

## 精简版OS

### AtlasOS
[AtlasOS](https://github.com/Atlas-OS/Atlas) 是一款基于 Windows 10/11 定制的操作系统，通过删除Windows一些不必要的组件与功能，减少进程，降低延迟，旨在帮助老硬件发挥更好的性能

## Windows11 技巧

### 跳过微软账号登录
安装完系统时，默认会强制用微软账号登录  
在选择国家和地区时，按 ``Shift + F10`` 键，打开命令行程序（部分笔记本选按 ``Fn + Shift + F10`` ）  
在命令行输入：``oobe\bypassnro.cmd`` 后，电脑会重启  
重启后再次按 ``Shift + F10`` 键  
在命令行输入：``ipconfig/release``，然后继续即可

如果还是提示需要微软账号登录可以使用  
账号：``8@8.com``  
密码：``随意``  

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

## Office

### Vole Office

``Vole Office`` 是微软 Office 的免费平替，套件包括Vole Windows Expedition, Vole Word, Vole Excel, Vole Scheduler, Vole Diagram 和Vole Paint。单EXE文件，大小230MB，无需安装，U盘内也可以使用。支持 Windows7 和更高操作系统。

 - [官网](https://sanwhole.com/Products/VoleOffice)
 - [github](https://sanwhole.com/PubData/Installer/VoleOffice.exe)

