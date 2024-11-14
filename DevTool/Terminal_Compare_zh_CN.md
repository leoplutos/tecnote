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
注：Windows平台下，和``wezterm.exe``同路径下建立配置文件``wezterm.lua``也可以，这种情况文件名没有点

### WezTerm作为SSH客户端的启动方式
正常使用命令
```
wezterm ssh -- user@ipaddress:8122
```
即可连接到SSH服务器使用，但是有一个问题是控制台会有2个，而且主控制台关闭之后，SSH客户端也跟着被一起杀死了  

解决方式为新建一个cmd批处理文件
```
@echo off
if "%1" == "h" goto begin
mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit
:begin
start /b D:\Tools\WorkTool\Linux\WezTerm\wezterm ssh -- lchuser@172.20.115.248:8122
```
用这个批处理启动即可

### Lua配置文件调试方式
可以用如下方式启动
```
wezterm-gui.exe 2> D:\Tools\WorkTool\Linux\WezTerm\log_strerr.log
```
然后在配置文件里
```
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
```
SET GITHUB_RAW_URL=https://raw.bgithub.xyz
::SET GITHUB_RAW_URL=https://raw.githubusercontent.com
curl --create-dirs -o %USERPROFILE%\.wezterm.lua %GITHUB_RAW_URL%/leoplutos/tecnote/refs/heads/master/DevTool/WezTerm_conf/wezterm.lua
curl --create-dirs -o %USERPROFILE%\.bashrc-personal %GITHUB_RAW_URL%/leoplutos/tecnote/refs/heads/master/Linux/linux_rc/bashrc/.bashrc-personal
```

SSH 到目标服务器之后使用快捷键 ``Alt + s`` 即可 source 个性化设定

## Windows Terminal
见 [这里](./Windows-Terminal_zh_CN.md)

## ConTour
* [官网](http://contour-terminal.org/)
* [Github](https://github.com/contour-terminal/contour/)

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
