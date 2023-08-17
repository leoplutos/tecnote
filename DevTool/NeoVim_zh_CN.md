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

## 笔者的设定文件
笔者主要用 ``VS Code`` 的 ``Neovim`` 插件，所以配置主要用于 ``VS Code`` 的使用
* [Neovim-conf](Neovim-conf)


