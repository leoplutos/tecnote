## 终端模拟器

编辑器和终端模拟器号称程序员的两个大玩具。现有终端模拟器种类繁多，笔者对终端模拟器的选择主要考虑以下几个方面。  
 1. 性能高效。所以开发语言只选择C/C++/Rust开发的，Electron开发的不考虑。
 2. Vim/NeoVim支持良好
 3. 支持GPU加速
 4. 支持连字
 5. 支持多TAB，支持分屏
 6. 支持自定义脚本

基于上面的考虑，选择了一些终端模拟器做一下横向对比，列表如下  

|            | WezTerm | WindowsTerminal | ConTour | Alacritty | Kitty    | Warp   | WindTerm |
|------------|---------|-----------------|---------|-----------|----------|--------|----------|
| Windows    | 支持    | 支持            | 支持    | 支持      | 不支持   | 不支持 | 支持     |
| MacOS      | 支持    | 不支持          | 支持    | 支持      | 支持     | 支持   | 支持     |
| Linux      | 支持    | 不支持          | 支持    | 支持      | 支持     | 不支持 | 支持     |
| 开发语言   | Rust    | C++             | C++     | Rust      | C/Python | Rust   | C        |
| 配置文件   | lua     | json            | yml     | yml       | conf     | -      | config   |
| 多TAB      | 支持    | 支持            | 不支持  | 不支持    | 支持     | 支持   | 支持     |
| 分割窗口   | 支持    | 支持            | 不支持  | 不支持    | 支持     | 支持   | 支持     |
| GPU加速    | 支持    | 支持            | 支持    | 支持      | 支持     | 不支持 | 不支持   |
| 连字       | 支持    | 支持            | 支持    | 不支持    | 支持     | 不支持 | 不支持   |
| 自定义脚本 | 支持    | 支持            | 不支持  | 不支持    | 支持     | 不支持 | 支持     |

#### 总结
- Windows平台：不喜欢折腾选 ``Windows Terminal``，喜欢折腾选 ``WezTerm``  
- Linux平台：``WezTerm``  
- MacOS平台：``WezTerm``  

WindTerm虽然支持的功能很多，但是如果使用Vim等TUI程序的话显示出现很大问题。只适合运维使用，不适合开发人员。  
个别一些老爷机使用 ``WezTerm`` 会有卡顿现象，这种情况可以考虑一下 ``Alacritty``  或者 ``ConTour``

## WezTerm
* [官网](https://wezfurlong.org/wezterm/index.html)
* [Github](https://github.com/wez/wezterm)

#### 配置文件地址

```
$HOME/.wezterm.lua
```
注：Windows平台下，和 ``wezterm.exe`` 同路径下建立配置文件 ``wezterm.lua`` 也可以，这种情况文件名没有点

### WezTerm作为SSH客户端的启动方式
正常使用命令
```bash
# 使用 wezterm 命令会多弹出一个控制台显示一些信息
wezterm ssh -- user@ipaddress:8122
# 或者
# 使用 wezterm-gui 不会多弹出一个控制台
wezterm-gui ssh -- user@ipaddress:8122
```
关于 ``wezterm`` 和 ``wezterm-gui`` 的区别可以看 [官方文档](https://wezfurlong.org/wezterm/cli/general.html)

### 屏蔽使用 wezterm 时的多出的控制台
直接使用 ``wezterm-gui`` 命令即可，如果非要使用 ``wezterm`` 命令可以按如下方式

新建一个cmd批处理文件
```bash
@echo off
if "%1" == "h" goto begin
mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit
:begin
start /b D:\Tools\WorkTool\Linux\WezTerm\wezterm ssh -- lchuser@172.20.115.248:8122
```
用这个批处理启动即可

### Lua配置文件调试方式
可以用如下方式启动
```bash
wezterm-gui.exe 2> D:\Tools\WorkTool\Linux\WezTerm\log_strerr.log
```
然后在配置文件里
```lua
wezterm.log_error('hello')
```
就可以将log输出在文件里

#### 配置文件例子
[wezterm.lua](./WezTerm_conf/wezterm.lua)

#### 默认快捷键
- Ctrl + Shift + t : 新建TAB
- Ctrl + Shift + Alt + % : 垂直分割窗口
- Ctrl + Shift + Alt + " : 水平分割窗口
- Ctrl + Shift + 方向键 : 切换窗口焦点

#### Windows 一键设定配置文件
需要 ``curl``，使用 cmd 运行
```bash
SET GITHUB_RAW_URL=https://raw.bgithub.xyz
::SET GITHUB_RAW_URL=https://raw.githubusercontent.com
curl --create-dirs -o %USERPROFILE%\.wezterm.lua %GITHUB_RAW_URL%/leoplutos/tecnote/refs/heads/master/DevTool/WezTerm_conf/wezterm.lua
curl --create-dirs -o %USERPROFILE%\.bashrc-personal %GITHUB_RAW_URL%/leoplutos/tecnote/refs/heads/master/Linux/linux_rc/bashrc/.bashrc-personal
```

SSH 到目标服务器之后使用快捷键 ``Alt + s`` 即可 source 个性化设定

### 使用 mRemoteNG 来制作 WezTerm 的启动菜单

``mRemoteNG`` 是 mRemote 的一个分支，是一个开源的、选项卡式的、多协议的 Windows 远程连接管理器

- [官网](https://mremoteng.org/)
- [Github](https://github.com/mRemoteNG/mRemoteNG)

#### 创建启动菜单
1. 打开 ``mRemoteNG``
2. ``工具`` → ``外部工具`` → ``新建``，按如下填写
    - 显示名称 : ``WezTerm``
    - 文件名 : ``D:\Tools\WorkTool\Linux\WezTerm\wezterm-gui.exe``
    - 参数 : ``ssh -- %USERNAME%@%HOSTNAME%:%PORT%``
3. ``连接`` → ``新建连接``，按如下填写
    - 名称 : ``服务器名``
    - 图标 : ``SSH``
    - 主机名/IP : ``服务器IP``
    - 用户名 : ``服务器用户``
    - 协议 : ``外部应用``
    - 外部工具 : ``WezTerm``
    - 端口 : ``服务器SSH端口``
4. 双击新建的连接即可启动 WezTerm

### 使用 XPipe 来制作 WezTerm 的启动菜单

``XPipe`` 是一款创新的 Shell 连接中心和远程文件管理器，旨在从本地机器轻松访问整个服务器基础设施。它构建在已安装的命令行程序之上，无需在远程系统上进行任何设置。

- [官网](https://docs.xpipe.io/)
- [Github](https://github.com/xpipe-io/xpipe)

#### 创建启动菜单
1. 打开 ``XPipe``
2. ``设置`` → ``外观`` → ``语言`` → 修改为 ``中文``
3. ``设置`` → ``终端`` → ``终端仿真器`` → ``自定义``，按如下填写
    - 自定义终端命令 : ``D:\Tools\WorkTool\Linux\WezTerm\wezterm-gui.exe -e $CMD``  
    点击 ``测试`` 确认可以打开终端
4. ``连接`` → ``新建连接``  → ``远程主机``  → ``简单的 SSH 连接``，按如下填写
    - 主机 : ``服务器IP``
    - 端口 : ``服务器SSH端口``
    - 用户 : ``服务器用户``
    - 验证密码 : ``服务器密码``
    - 基于密匙的身份验证 : ``无``
    - 连接名称 : ``服务器名``

## Windows Terminal
见 [这里](./Windows-Terminal_zh_CN.md)

## ConTour
- [官网](http://contour-terminal.org/)
- [Github](https://github.com/contour-terminal/contour/)

#### 配置文件地址
```
%LocalAppData%\contour\contour.yml
```

#### 配置文件例子
[contour.yml](./contour_conf/contour.yml)

## Alacritty
* [官网](https://alacritty.org/)
* [Github](https://github.com/alacritty/alacritty)  
速度很快，但是不支持连字

#### 配置文件地址

~~alacritty.yml~~  已被废弃

Windows
```
%APPDATA%\alacritty\alacritty.toml
```

Linux
```
$HOME/.config/alacritty/alacritty.toml
```

#### 配置文件例子
[alacritty.toml](./alacritty_conf/alacritty.toml)  
~~[alacritty.yml](./alacritty_conf/alacritty.yml)~~
