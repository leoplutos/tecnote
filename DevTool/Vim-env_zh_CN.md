# Vim环境和设置总结

## 笔者的使用版本（优先前者）
- Windows：NeoVide 或者 Gvim
- Linux：NeoVim 或者 Vim

## 使用插件总结
笔者主要使用的插件如下表
|       | Vim（最小插件依赖）             |  Vim（有插件）        |  NeoVim（有插件）          |
|-------|-----------------------------|------------------|-----------------------|
| 文件树   | netrw                       | nerdtree             | tree.lua              |
| 自动完成  | vim-auto-popmenu + vim-dict | asyncomplete.vim | nvim-cmp              |
| 模糊查询  | ctrlp.vim                   | LeaderF          | telescope.nvim        |
| 代码大纲  | ctrlp-funky                 | :LeaderfFunction |  symbols-outline.nvim                  |
| lsp   |  无                          | vim-lsp          | nvim-lspconfig        |
| dap   |  无                          | vimspector       | vimspector            |
| 缩进参考线 | indentLine                  | indentLine       | indent-blankline.nvim |
| 欢迎页面  | vim-startify                | vim-startify     | vim-startify          |
| 代码片段  | 自定义                         | vim-vsnip        | vim-vsnip             |
|  其他   |  无                          |  无               | flash.nvim            |

**注:** 使用了 ``vim-devicons`` 之后，如果 ``NeedTree`` 图标不显示，需要将 ``vim-devicons/nerdtree_plugin`` 这个文件夹复制到  
```
~/.vim/nerdtree_plugin/ (*nix)
~/vimfiles/nerdtree_plugin (windows)
```
笔者的路径为  
```
~/vimconf/nerdtree_plugin
```

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


