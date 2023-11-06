# Vim-LSP

## LSP简介

LSP（Language Server Protocol）：LSP 是一套通信协议，遵从 LSP 规范的客户端（各种编辑器/IDE）可以通过众多 LSP 服务端按协议标准进行通信，由客户端完成用户界面相关的事情，由服务端提编程语言相关的：补全，定义引用查找，诊断，帮助文档，重构等服务。  

LSP 协议就是一套解偶合的标准，比如 C/C++ 补全，以前是 NotePad++ 里做一套，VS里做一套，Vim里做一套，Emacs里又做一套，C/C++ 还好，但是其他语言就惨了，各个编辑器实现的质量参差不齐。LSP 出现后能让编辑器专心提供最好的用户体验，而 LSP Server 则专心将具体语言的各种集成服务做透，做扎实。  

这样同一个 LSP Server 可以服务于不同的编辑器 / IDE，不同的编辑器/IDE 一旦支持 LSP，则可以瞬间对接高质量的各种 LSP Servers。

## LSP 服务端和客户端怎么通信的？

说起 LSP 服务端大家不要误会成 http server 那样的常驻后台服务，好像编辑器只有通过 TCP发送请求上来才行。实际上，LSP Servers 都是一个个命令行程序，由编辑器（也就是客户端）启动，通过管道发送 JSON RPC 命令同 LSP Server 交流，退出编辑器，LSP 服务端也就关闭了。


## LSP 服务端列表

在官网 [https://langserver.org/](https://langserver.org/) 可以查到所有LSP的服务/客户端

## Vim/NeoVim中使用LSP的客户端对比
| 语言服务器    | vim-lsp | nvim-内置-lsp                | coc.nvim        |
|---------------|---------|------------------------------|-----------------|
| clangd        | ○       | ○                            | ○               |
| pyright       | ○       | ○                            | ○(功能更多)     |
| jdtls         | ○       | ○(也支持Debug，笔者没有配置) | ○(支持Debug)    |
| rust-analyzer | ○       | ○                            | ○               |
| gopls         | ○       | ○                            | ○               |
| volar         | ○       | ○                            | ○(功能更多)     |
| csharp-ls     | ×       | ○                            | △(补全有些问题) |
| Cobol         | ○       | ○                            | ○               |
| Kotlin        | ○       | ○                            | ○               |
| Lua           | -       | ○                            | ×               |

## 在 Vim 中使用 LSP

笔者主要使用 **vim-lsp**，下面是以下 lsp客户端的对比

- [vim-lsp](https://github.com/prabirshrestha/vim-lsp)  
异步，完全vimscript实现，自动补全需要其他插件，客户端功能比较多，但是速度有些慢。支持asyncomplete, deoplete和ncm2三个补全框架。

- [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim/)  
异步，python插件，使用rust作为后端，速度快，但是已经不维护了，虽然支持的服务端多，但是客户端功能比较少。在安装上，需要从git上下载rust编译好的可执行文件复制到bin路径下，并且修改文件名为【languageclient.exe】

- [vim-lsc](https://github.com/natebosch/vim-lsc)  
异步，完全vimscript实现，没有其他依赖，这个插件内部实现了自动补全，速度比vim-lsp快，但是客户端功能比较少

## C/C++语言LSP配置

1. 安装 ``clangd``  
在 [这里](https://github.com/clangd/clangd/releases/download/16.0.2/clangd-windows-16.0.2.zip) 可以下载到zip包  
2. 配置 ``clangd``  
``clangd`` 有全局设定和项目设定，2选1即可  

#### 全局设定文件  
```
%LocalAppData%\clangd\config.yaml
```
#### 项目设定文件  
在项目跟路径下
```
project_root/.clangd
```

内容如下
```
CompileFlags:
    Add:
      [
        -xc++,
        -Wno-documentation,
        -Wno-missing-prototypes,
      ]
    #Remove: -W*
    Compiler: gcc

Diagnostics:
  ClangTidy:
    Add:
    [
        performance-*,
        bugprone-*,
        modernize-*,
        clang-analyzer-*,
        readability-identifier*,
        readability-magic-number*,
    ]
    CheckOptions:
      readability-identifier-naming.VariableCase: camelCase

InlayHints:
  Designators: Yes
  Enabled: Yes
  ParameterNames: Yes
  DeducedTypes: Yes
```
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

## Python语言LSP配置

### 使用pyright
```
npm install -g pyright
```

### 使用pylsp
1. 安装 ``pylsp``
```
pip install "python-lsp-server[all]"
```
使用国内源为
```
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple "python-lsp-server[all]"
```
下载后会在 ``Scripts`` 文件夹里看到 ``pylsp.exe``，测试运行一下  
```
pylsp --help
```
如果报错 ``No module named 'pkg_resource'`` 的话，运行
```
pip install -U setuptools
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U setuptools
```
修复即可

2. 在 ``Vim`` 中安装 ``vim-lsp``, ``asyncomplete``, ``asyncomplete-lsp`` 这3个插件
3. 参照笔者的配置
- [Vim-conf](Vim-conf) 中的 ``init/lsp.vim``
4. ``pylsp`` 默认用 ``pycodestyle`` 进行检查，配置文件为  

全局配置
```
~\.pycodestyle
```
工程配置
```
{项目根目录}\setup.cfg
```
下面是一个设定文件例子
```
[pycodestyle]
ignore = E401,E402,E501

[flake8]
ignore = E401,E402,E501

[pep8]
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

## Go语言的LSP配置
安装 ``gopls``，配置好VSCode的环境，会自动要求安装 ``gopls``  
或者使用如下命令安装
```
go install golang.org/x/tools/gopls@latest
```
其他配置同上

## Vue的LSP配置
安装 ``vls``
```
npm install -g @vue/language-server
npm install -g typescript
```
其他配置同上

## CSharp语言LSP配置
CSharp有2个语言服务器 ``OmniSharp`` 和 ``CSharp-ls``，推荐使用后者  
Github地址为：  
 - [OmniSharp](https://github.com/OmniSharp/omnisharp-roslyn)
 - [CSharp-ls](https://github.com/razzmatazz/csharp-language-server)

``OmniSharp`` 直接下载二进制使用即可  
``CSharp-ls`` 使用如下命令安装  
```
dotnet tool install --global csharp-ls
```

## Coc.nvim
和其他LSP插件相比Coc是另一套解决方案  
需要有Node环境，插件体积更小，安装更方便一些。  

#### Coc的下载与安装
在 [官方Github](https://github.com/neoclide/coc.nvim) 下载好代码以后，像其他插件一样放到 ``/pack/vendor/opt`` 下  
然后运行命令
```
cd %USERPROFILE%\vimconf\pack\vendor\opt\coc.nvim
npm ci
```
进入Vim/NeoVim之后可以用命令
```
:CocInfo
:checkhealth
```
来查看信息，笔者的信息如下
```
## versions

vim version: VIM - Vi IMproved 9.0 9002081
node version: v18.17.1
coc.nvim version: 0.0.82-master
coc.nvim directory: C:\Users\admin\vimconf\pack\vendor\opt\coc.nvim
term: undefined
platform: win32

## Log of coc.nvim

2023-11-02T11:18:37.654 INFO (pid:7268) [configurations] - Add folder configuration from cwd: C:\Users\admin\vimconf\pack\vendor\opt\coc.nvim\.vim\coc-settings.json
2023-11-02T11:18:37.786 INFO (pid:7268) [plugin] - coc.nvim initialized with node: v18.17.1 after 215
```

#### Coc路径自定义
这些全局变量可以自定义 coc 的路径
 - g:coc_node_path ： node可执行文件的定义
 - g:coc_config_home ： 设定文件(coc-settings.json)路径的定义
 - g:coc_data_home ： coc下载插件的路径定义  

一个例子
```
let g:coc_node_path = 'D:/Tools/WorkTool/NodeJs/node-v18.17.1-win-x64/node.exe'
let g:coc_config_home = expand('~/vimconf/coc_config')
let g:coc_data_home = 'D:/Tools/WorkTool/NodeJs/node-v18.17.1-win-x64/coc_extension_data'
```

#### Coc使用npm的源自定义
修改 ``~/.npmrc`` 文件，在最下面加上如下内容
```
coc.nvim:registry=https://npmreg.proxy.ustclug.org/
```

#### Coc安装语言服务
使用命令为
```
:CocInstall {Coc插件名字}
```
比如
```
:CocInstall coc-pyright
```
可自定义路径，默认安装路径在 ``%LOCALAPPDATA%\coc\extensions\node_modules`` 下

笔者主要使用的有
 - coc-explorer
 - coc-snippets
 - coc-clangd
 - coc-pyright
 - coc-java (使用命令 ``:CocInstall coc-java-debug`` 后可以 Debug)
 - coc-rust-analyzer
 - coc-go
 - coc-volar (安装命令为 ``:CocInstall @yaegassy/coc-volar``  &nbsp;&nbsp;&nbsp;&nbsp;  可选``:CocInstall @yaegassy/coc-typescript-vue-plugin`` )
 - coc-omnisharp (作者已经推荐使用 ``csharp-ls`` 了)
 - coc-lua

暂时没有发现 ``Cobol`` 和 ``Kotlin`` 的LSP，所以需要在配置文件中自定义  
更多看这里 [Coc插件列表](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)

#### Coc的设定文件coc-settings.json
Coc的设定文件分 ``全局`` 和 ``工程``

**1. 全局设定文件**  
使用如下命令，即可查看
```
:CocConfig
```
可自定义路径，默认的路径为 ``%USERPROFILE%\vimfiles``  

**2. 工程设定文件**  
使用如下命令，即可查看
```
:CocLocalConfig
```
工程的设定文件和VSCode类似，在工程根路径下的 ``.vim`` 路径内。工程设定会**覆盖**全局设定

其他的地方可看笔者的配置文件 ``coc.vim`` 和 ``coc-settings.json``  

#### 一些常用命令
查看已安装插件
```
:CocList extensions
```
查看当前工作目录
```
:CocCommand workspace.workspaceFolders
```
查看当前Buffer的LSP支持特性
```
:CocCommand document.checkBuffer
```
查看插件信息coc-pyright信息
```
:CocCommand workspace.showOutput Pyright
:CocCommand workspace.showOutput snippets
```

## 其他

#### 颜文字的使用
可以在如下网站查找  
https://www.emojiall.com/zh-hans/platform-microsoft
