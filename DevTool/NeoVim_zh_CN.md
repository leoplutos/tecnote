# Neo-Vim

## Neo-Vim简介
Neovim 是 vim 的一个分支，允许更大的可扩展性和集成性。 旨在改进代码库，从而使得 API 更容易实现，并改善用户体验和插件实现。  

自 Neovim 诞生以来，它就专注于提高自己的扩展性与易用性，例如内置终端、异步执行这两个比较重要的功能都是Neovim率先支持，而 Vim 追赶在后的。经过多年在各自赛道上的发展，Neovim 与 Vim 已经产生了不少差异。不过现阶段来看，Neovim 的特性仍然几乎是 Vim 的超集，也就是说除了自己独有的功能外，Neovim 还支持Vim的绝大部分功能。  

另外尽管 Neovim fork 自 Vim 7.4.160，这并不意味着 Neovim 与 Vim 走向了完全不同的道路。时至今日，Neovim 仍然在与最新的 Vim 补丁保持同步，以避免做重复的工作。  

Neovim支持LSP，支持Tree-sitter，支持Lua

## 下载安装

#### 地址
* [Github地址](https://github.com/neovim/neovim)
* [Windows平台v0.9.1稳定免安装版](https://github.com/neovim/neovim/releases/download/v0.9.1/nvim-win64.zip)

#### 安装
下载 ``nvim-win64.zip`` 之后，解压缩  
在 ``bin`` 文件夹下会找到 ``nvim.exe`` 和 ``nvim-qt.exe``

- nvim-qt.exe  
  基于qt的前端GUI，直接运行即可打开

- nvim.exe  
  nvim的核心程序，需要在终端下 ``CLI``命令行 运行打开

## Neo-Vim的配置加载

Windows平台下默认设定文件为：

#### 路径（如不存在需要新建）
```
%LOCALAPPDATA%\nvim
```
#### 文件名
```
init.lua
```
或者
```
init.vim
```

#### 如果运行的是 ``nvim-qt.exe`` 还会加载
```
ginit.vim
```

## 健康检查
Neovim 新加了一个健康检查的命令
```
:checkhealth
```
可以查看当前的运行情况

## 笔者的设定文件
笔者主要用 ``VS Code`` 的 ``Neovim`` 插件，所以配置主要用于 ``VS Code`` 的使用
* [Neovim-conf](Neovim-conf)

## Python支持
Neovim 的 ``Python`` 支持方式和 Vim 不一样
需要运行下面的命令
```
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pynvim
```
运行之后运行 ``:checkhealth`` 确认

## Neovim安装插件
在路径
```
%LOCALAPPDATA%\nvim
```
下依次新建文件夹
```
pack/vendor/opt
pack/vendor/start
```
将插件放到 ``opt`` 文件夹内，``packadd`` 即可

## GUI前端Neovide
NeoVim 自带的 GUI 前端是基于 qt 的，笔者不太喜欢，用起来延迟很高。  
使用 ``Neovide`` 这个 rust 开发的 GUI 前端体验会更好  
官网：https://neovide.dev/  
Github：https://github.com/neovide/neovide  
下载：https://github.com/neovide/neovide/releases  
最新版：https://github.com/neovide/neovide/releases/download/0.11.2/neovide.exe.zip  

#### 启动
下载好执行文件之后，如果 ``nvim.exe`` 在环境变量里直接运行 ``neovide.exe`` 即可  
如果环境受限无法修改环境变量可以用如下方式启动，新建 ``neovide.cmd``  
内容如下（delete_vim_log.cmd为删除log文件的脚本，可不加）
```
call D:\Tools\WorkTool\Cmd\delete_vim_log.cmd
::pause

set NEOVIM_BIN=D:\Tools\WorkTool\Text\nvim-win64\bin\nvim.exe
start /b D:\Tools\WorkTool\Text\nvim-win64\bin\neovide.exe
::start /b D:\Tools\WorkTool\Text\nvim-win64\bin\neovide.exe --neovim-bin D:\Tools\WorkTool\Text\nvim-win64\bin\nvim.exe
```

## LSP
Neovim 内置 LSP 的 client 端。只需要4步
1. 安装 [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
2. 安装对应 language server
3. 配置对应语言 ``require('lspconfig').xx.setup{…}``
4. 运行``:LspInfo`` 查看 LSP 连接状态

## VimScript与Lua的互相调用
在 VimScript 下
```
lua require('xxx')
```
就能引入 Lua 配置文件模块  
反之在 Lua 下
```
vim.cmd [[source <vimscript文件路径>]]
```
就能引入vimscript文件

## 其他

#### 查看高亮组信息
Neovim 的内部命令 ``:Inspect`` 可以查看当前光标下的高亮组信息

#### 发生错误 E576
```
E576: Error while reading ShaDa file: last entry specified that it occupies 143 bytes Windows Neovim
```
删除如下文件夹当中的内容即可  
Linux
```
rm ~/.local/share/nvim/shada/*
```
Windows
```
%LOCALAPPDATA%\nvim-data
```

#### 在 neovim 中使用 Lua
https://gitee.com/zhengqijun/nvim-lua-guide-zh

