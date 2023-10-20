# Vim环境和设置总结

## 笔者的使用版本（优先前者）
- Windows：NeoVide 或者 Gvim
- Linux：NeoVim 或者 Vim

## 使用插件总结
笔者主要使用的插件如下表
|             | Vim（最小插件依赖）                 | Vim（有插件）             | NeoVim（有插件）           |
|-------------|-----------------------------|----------------------|-----------------------|
| 文件树         | netrw                       | nerdtree             | nvim-tree.lua         |
| 自动完成        | vim-auto-popmenu + vim-dict | asyncomplete.vim     | nvim-cmp              |
| 模糊查询        | ctrlp.vim                   | LeaderF              | telescope.nvim        |
| 代码大纲        | ctrlp-funky                 | :LeaderfFunction     | symbols-outline.nvim  |
| LSP         | 无                           | vim-lsp              | nvim-lspconfig        |
| DAP         | 无                           | vimspector           | vimspector            |
| 缩进参考线       | indentLine                  | indentLine           | indent-blankline.nvim |
| 状态栏         | 自定义                         | lightline.vim        | lualine.nvim          |
| Tab/Buffer栏 | 自定义                         | lightline-bufferline | bufferline.nvim       |
| 终端          | vim-terminal-help           | vim-terminal-help    | toggleterm.nvim       |
| 欢迎页面        | vim-startify                | vim-startify         | vim-startify          |
| 代码片段        | 自定义                         | vim-vsnip            | vim-vsnip             |
| 其他          | 无                           | 无                    | flash.nvim            |

**注:** 使用了 ``vim-devicons`` 之后，如果 ``NeedTree`` 图标不显示，需要将 ``vim-devicons/nerdtree_plugin`` 这个文件夹复制到  
```
~/.vim/nerdtree_plugin/ (*nix)
~/vimfiles/nerdtree_plugin (windows)
```
笔者的路径为  
```
~/vimconf/nerdtree_plugin
```

### 一些笔者没有使用但是很优秀的插件

- DAP：因为使用了 ``vimspector`` 所以没有采用  
  mfussenegger/nvim-dap ：dap支持  
  rcarriga/nvim-dap-ui ：debug用的ui  
  theHamsta/nvim-dap-virtual-text ：在变量右侧用虚拟文本显示debug时的变量值  

- Git  
  lewis6991/gitsigns.nvim ：git支持  
  sindrets/diffview.nvim ：差分git的历史版本  

## Lazygit
Lazygit 并不是一个 Vim/NeoVim 插件，而是一个用于 Git 命令行的简单 ``终端UI``，使用 Go 语言编写，用到了 gocui 库，目的是在命令行提供 Git 的图形界面  
和 Vim/NeoVim 一样，都是 ``TUI``，那么他们搭配在一起使用，也理所当然了。

#### 下载安装
* [Github地址](https://github.com/jesseduffield/lazygit)
* [Windows平台v0.40.2稳定免安装版](https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Windows_x86_64.zip)

#### 配置中文文档
* [中文文档](https://gitcode.gitcode.host/docs-cn/lazygit-docs-cn/Config.html)

#### 安装后确认命令
```
lazygit --version
```
#### 配置文件的默认路径
- Linux:
```
~/.config/lazygit/config.yml
```
- MacOS:
```
~/Library/Application Supp或t/lazygit/config.yml
```
- Windows：
```
%APPDATA%\lazygit\config.yml
```

#### 笔者的配置文件
在WindowsTerminal下使用中文有``gocui库的中文显示bug``，所以设定是英文
```
gui:
  language: 'en' # one of 'auto' | 'en' | 'zh' | 'pl' | 'nl'
  timeFormat: '2006/01/02'
  shortTimeFormat: '15:04:05'
  theme:
    lightTheme: false # For terminals with a light background
    activeBorderColor:
      - '#f39c12' #54f95e
      - bold
    inactiveBorderColor:
      - '#6f6f6f'
    searchingActiveBorderColor:
      - '#ffff00'
      - bold
    optionsTextColor:
      - '#cdcdff'
    selectedLineBgColor:
      - '#292e42'
    selectedRangeBgColor:
      - '#2e3c64'
    cherryPickedCommitBgColor:
      - blue
    cherryPickedCommitFgColor:
      - cyan
    unstagedChangesColor:
      - '#ff4b4b'
    defaultFgColor:
      - default
  nerdFontsVersion: "3"
  authorColors:
    # use color for myself
    'chunhao.liang': '#9CDCFE'
    # use color for other authors
    '*': '#96E072'
  branchColors:
    'docs': '#11aaff' # use a light blue for branches beginning with 'docs/'
notARepository: 'quit' # one of: 'prompt' | 'create' | 'skip' | 'quit'
keybinding:
  universal:
    prevPage: '<c-b>' # go to next page in list
    nextPage: '<c-f>' # go to previous page in list
```

#### 一些常用的快捷键
1. 通用
    - 数字1-5 ：在区块间切换
    - tab：区块切换
    - h/l：在上一个/下一个区块间切换
    - ?：打开帮助菜
    - q：退出
    - ``[]``（中括号）：可以在面板里切换，比如在branche面板里面可以切换``Local branches``，``Remotes``和``Tags``
    - P（大写）：推送分支（git push）
    - p（小写）：拉取分支（git pull）
2. Files面板
    - 空格：缓存文件/取消缓存文件（git add）
    - a：缓存所有文件/取消缓存所文件（git add）
    - 回车：查看缓存文件
    - c：提交（git commit）
3. Branches面板
    - 空格：切换到选择的branch
    - n：新建branch

## 启动Vim/NeoVim的脚本
笔者的 ``vimrc`` 有2个重要的全局变量
- g:g_use_lsp ： 控制是否启用lsp的设定
- g:g_use_dap ： 控制是否启用dap的设定

利用这2个环境变量来判断启动vim加载的内容
- vim（最小插件依赖）：只加载纯vimscript的插件  
```
g:g_use_lsp == 0 && g:g_use_dap == 0
```
- viml（只开启lsp）
```
g:g_use_lsp == 1 && g:g_use_dap == 0
```
- vimd（只开启dap）
```
g:g_use_lsp == 0 && g:g_use_dap == 1
```
- vimf（开启lsp和dap）：加载所有
```
g:g_use_lsp == 1 && g:g_use_dap == 1
```

分别建立各自的启动 ``cmd`` 文件，主要就是利用 vim 的 ``--cmd`` 参数  
```
--cmd {command}
                在处理任何 vimrc 文件之前执行命令 {command}。除此以外，和 -c
                {command} 类似。你可以使用不超过 10 个本命令，不占用 "-c" 命令
                的数目限制。
```

### Gvim用
``gvim.cmd``  
```
call D:\Tools\WorkTool\Cmd\delete_vim_log.cmd
start /b D:\Tools\WorkTool\Text\vim90\gvim.exe --cmd "let g:g_use_lsp = 0 | let g:g_use_dap = 0"
```

``gviml.cmd``  
```
call D:\Tools\WorkTool\Cmd\delete_vim_log.cmd
start /b D:\Tools\WorkTool\Text\vim90\gvim.exe --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 0"
```

``gvimd.cmd``  
```
call D:\Tools\WorkTool\Cmd\delete_vim_log.cmd
start /b D:\Tools\WorkTool\Text\vim90\gvim.exe --cmd "let g:g_use_lsp = 0 | let g:g_use_dap = 1"
```

``gvimf.cmd``  
```
call D:\Tools\WorkTool\Cmd\delete_vim_log.cmd
start /b D:\Tools\WorkTool\Text\vim90\gvim.exe --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
```

### NeoVim用
``nvim.cmd``  
```
call D:\Tools\WorkTool\Cmd\delete_vim_log.cmd
set NEOVIM_BIN=D:\Tools\WorkTool\Text\nvim-win64\bin\nvim.exe
start /b D:\Tools\WorkTool\Text\nvim-win64\bin\neovide.exe -- --cmd "let g:g_use_lsp = 0 | let g:g_use_dap = 0"
```

``nviml.cmd``  
```
call D:\Tools\WorkTool\Cmd\delete_vim_log.cmd
set NEOVIM_BIN=D:\Tools\WorkTool\Text\nvim-win64\bin\nvim.exe
start /b D:\Tools\WorkTool\Text\nvim-win64\bin\neovide.exe -- --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 0"
```

``nvimd.cmd``  
```
call D:\Tools\WorkTool\Cmd\delete_vim_log.cmd
set NEOVIM_BIN=D:\Tools\WorkTool\Text\nvim-win64\bin\nvim.exe
start /b D:\Tools\WorkTool\Text\nvim-win64\bin\neovide.exe -- --cmd "let g:g_use_lsp = 0 | let g:g_use_dap = 1"
```

``nvimf.cmd``  
```
call D:\Tools\WorkTool\Cmd\delete_vim_log.cmd
set NEOVIM_BIN=D:\Tools\WorkTool\Text\nvim-win64\bin\nvim.exe
start /b D:\Tools\WorkTool\Text\nvim-win64\bin\neovide.exe -- --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
```


## 删除Vim的Log文件的脚本
因为 vim 会产生很多 log 文件，下面这个批处理也会删除 log  
新建 ``delete_vim_log.cmd`` 内容如下  
```
@echo off

::删除_viminfo(~/_viminfo)
SET TmpDeleteFile=%USERPROFILE%\_viminfo
if exist %TmpDeleteFile% (
    del %TmpDeleteFile%
) else (
    echo %TmpDeleteFile% is not exist!
)
::删除vim-lsp的log(~/vim-lsp.log)
SET TmpDeleteFile=%USERPROFILE%\vim-lsp.log
if exist %TmpDeleteFile% (
    del %TmpDeleteFile%
) else (
    echo %TmpDeleteFile% is not exist!
)
::删除vim-dap vimspector的log(~/.vimspector.log)
SET TmpDeleteFile=%USERPROFILE%\.vimspector.log
if exist %TmpDeleteFile% (
    del %TmpDeleteFile%
) else (
    echo %TmpDeleteFile% is not exist!
)
::删除neovim-lsp的log(%LOCALAPPDATA%\nvim-data\lsp.log)
SET TmpDeleteFile=%LOCALAPPDATA%\nvim-data\lsp.log
if exist %TmpDeleteFile% (
    del %TmpDeleteFile%
) else (
    echo %TmpDeleteFile% is not exist!
)
::删除cobol-lsp的log文件夹(~/LSPCobol/logs)
SET TmpDeleteFolder=%USERPROFILE%\LSPCobol\logs
if exist %TmpDeleteFolder% (
    rmdir /S /Q %TmpDeleteFolder%
) else (
    echo %TmpDeleteFolder% is not exist!
)
::删除LeaderF的缓存文件夹(%APPDATA%/LeaderF)
SET TmpDeleteFolder=%APPDATA%\LeaderF
if exist %TmpDeleteFolder% (
    rmdir /S /Q %TmpDeleteFolder%
) else (
    echo %TmpDeleteFolder% is not exist!
)

@echo on
```


