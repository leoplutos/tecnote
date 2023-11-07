# im-select

## 简介
使用 Vim/NeoVim ，一直有输入法自动切换的问题。这里记录一下3个平台的解决方案

## im-select主页
 - [Github主页](https://github.com/daipeihust/im-select)
 - [Gitee主页](https://gitee.com/ianaxe/im-select)

### 下载安装(Winodws)
 - [x86二进制包下载](https://github.com/daipeihust/im-select/raw/master/im-select-win/out/x86/im-select.exe)
 - [x64二进制包下载](https://github.com/daipeihust/im-select/raw/master/im-select-win/out/x64/im-select.exe)

### 下载安装(Linux)
因为笔者使用fcitx5框架，所以只记录fcitx5
```
# 查找程序路径
which fcitx5-remote

# 取得当前输入法
fcitx5-remote -n

# 切换英文输入法
fcitx5-remote keyboard-us
```

### 下载安装(MacOS)
```
brew tap daipeihust/tap
brew install im-select
```
或者
```
curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh
```

## 输入法设置(Windows)
1. 需要在系统设置中添加中英文语言包，最起码需要添加
    - 中文（简体，中国）
    - 英语（美国）

2. 打开Windows系统的设置，搜索输入 ``高级键盘设置``，然后选中 ``允许为每个应用窗口使用不同输入法``

3. 打开命令行，执行 ``im-select.exe`` 之后会返回当前输入语言的句柄值  
    - 中文输入法：2052
    - 英文输入法：1033
    - 日文输入法：1041

4. 测试输入法切换  
在命令下分别输入
```
im-select.exe 1033
im-select.exe 2052
im-select.exe 1041
```
查看是否可以切换输入法

## Vim下使用 ``vim-im-select`` 插件
 - [vim-im-select](https://github.com/brglng/vim-im-select)  

按如下配置即可
```
let g:im_select_command = 'D:/Tools/WorkTool/Text/im-select/x64/im-select.exe'
let g:im_select_default = '1033'
let g:im_select_enable_focus_events = 0
let g:im_select_enable_for_gvim = 1
```
## NeoVim下使用 ``im-select.nvim`` 插件
 - [im-select.nvim](https://github.com/keaising/im-select.nvim)  

按如下配置即可
```
require('im_select').setup({
  default_im_select  = '1033',
  default_command = 'D:/Tools/WorkTool/Text/im-select/x64/im-select.exe',
  set_previous_events = {},
  keep_quiet_on_no_binary = false,
  async_switch_im = false
})
```

## VSCode Neovim下的设定
因为笔者还使用 [VSCode Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim) 插件 ，在 ``init.lua`` 下加入如下定义即可
```
if vim.g.vscode then
  vim.cmd([[
  augroup VSCodeImSelectGroup
    autocmd!
    autocmd VimEnter * :silent :!D:\\Tools\\WorkTool\\Text\\im-select\\x64\\im-select.exe 1033
    autocmd InsertEnter * :silent :!D:\\Tools\\WorkTool\\Text\\im-select\\x64\\im-select.exe 2052
    autocmd InsertLeave * :silent :!D:\\Tools\\WorkTool\\Text\\im-select\\x64\\im-select.exe 1033
    autocmd VimLeave * :silent :!D:\\Tools\\WorkTool\\Text\\im-select\\x64\\im-select.exe 2052
  augroup END
  ]])
else
  ...
end
```
