# Vim-LSP

## LSP简介

LSP（Language Server Protocol）：LSP 是一套通信协议，遵从 LSP 规范的客户端（各种编辑器/IDE）可以通过众多 LSP 服务端按协议标准进行通信，由客户端完成用户界面相关的事情，由服务端提编程语言相关的：补全，定义引用查找，诊断，帮助文档，重构等服务。  

LSP 协议就是一套解偶合的标准，比如 C/C++ 补全，以前是 NotePad++ 里做一套，VS里做一套，Vim里做一套，Emacs里又做一套，C/C++ 还好，但是其他语言就惨了，各个编辑器实现的质量参差不齐。LSP 出现后能让编辑器专心提供最好的用户体验，而 LSP Server 则专心将具体语言的各种集成服务做透，做扎实。  

这样同一个 LSP Server 可以服务于不同的编辑器 / IDE，不同的编辑器/IDE 一旦支持 LSP，则可以瞬间对接高质量的各种 LSP Servers。

## LSP 服务端和客户端怎么通信的？

说起 LSP 服务端大家不要误会成 http server 那样的常驻后台服务，好像编辑器只有通过 TCP发送请求上来才行。实际上，LSP Servers 都是一个个命令行程序，由编辑器（也就是客户端）启动，通过管道发送 JSON RPC 命令同 LSP Server 交流，退出编辑器，LSP 服务端也就关闭了。


## LSP 服务端列表

在官网 [https://langserver.org/](https://langserver.org/) 可以查到所有LSP的服务/客户端

## 在 Vim 中使用 LSP

笔者主要使用
- [vim-lsp](https://github.com/prabirshrestha/vim-lsp)

## C/C++语言LSP配置

1. 安装 ``clangd``  
在 [这里](https://github.com/clangd/clangd/releases/download/16.0.2/clangd-windows-16.0.2.zip) 可以下载到zip包
2. 在 ``Vim`` 中安装 ``vim-lsp``, ``asyncomplete``, ``asyncomplete-lsp`` 这3个插件
3. 参照笔者的配置
- [Vim-conf](Vim-conf) 中的 ``init/lsp.vim``
4. 生成 ``compile_commands.json``

#### ninja生成命令
```
ninja -t compdb > compile_commands.json
```
#### cmake生成命令
```
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1
```
#### make生成命令（需要安装bear）
```
bear make all
```

## Java语言LSP配置

1. 安装 ``eclipse.jdt.ls``  (版本：1.26)  
在 [这里](https://download.eclipse.org/jdtls/milestones/) 可以下载到zip包
2. 在 ``Vim`` 中安装 ``vim-lsp``, ``asyncomplete``, ``asyncomplete-lsp`` 这3个插件
3. 参照笔者的配置
- [Vim-conf](Vim-conf) 中的 ``init/lsp.vim``
4. Vim配置  
第一次启动后会在工程跟路径下生成一个.lsp的文件夹，这个文件夹中的  ``src_xxxxxxxx`` 是设置路径，基本和 ``eclipse`` 一致，修改其中的 ``.classpath`` 即可导入第三方jar

## Python语言LSP配置

1. 安装 ``pylsp``  
```
pip install "python-lsp-server[all]"
```
下载后会在 ``Scripts`` 文件夹里看到 ``pylsp.exe``，测试运行一下  
```
pylsp --help
```
如果报错 ``No module named 'pkg_resource'`` 的话，运行
```
pip install -U setuptools
```
修复即可

2. 在 ``Vim`` 中安装 ``vim-lsp``, ``asyncomplete``, ``asyncomplete-lsp`` 这3个插件
3. 参照笔者的配置
- [Vim-conf](Vim-conf) 中的 ``init/lsp.vim``
4. ``pylsp`` 默认用 ``pycodestyle`` 进行检查，配置文件为
```
~\.pycodestyle
```
文件中输入如下内容即可
```
[pycodestyle]
ignore = E401,E402,E501
```

## Rust语言LSP配置

1. 安装 ``rust-analyzer``  
使用 ``rustup`` 安装
```
rustup component add rust-analyzer
```
或者参照官方帮助文档安装：[帮助文档](https://rust-analyzer.github.io/manual.html#installation)  
2. 在 ``Vim`` 中安装 ``vim-lsp``, ``asyncomplete``, ``asyncomplete-lsp`` 这3个插件
3. 参照笔者的配置
- [Vim-conf](Vim-conf) 中的 ``init/lsp.vim``


## 其他

#### 颜文字的使用
可以在如下网站查找  
https://www.emojiall.com/zh-hans/platform-microsoft