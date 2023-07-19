# vimrc

## vimrc简介
vimrc是Vim最主要的配置文件，它有两个版本：全局版本（global）和用户版本（personal）。
假如你不知道全局vimrc的位置，可以打开Vim，在普通模式（Normal）下输入下面的命令得到它的位置（注意大小写）
```
:echo $VIM
```

查看VIM运行时路径的命令为
```
:echo $VIMRUNTIME
```

用户版本的vimrc文件在当前用户的主目录下，主目录的位置依赖于操作系统。
```
:echo $HOME
```
或者在终端输入
```bash
cd ~
pwd
```

从官方的例子vimrc文件复制一份到用户主目录下，并且改名为.vimrc
```bash
cp -afp /usr/share/vim/vim80/vimrc_example.vim ~
ll ~/vimrc_example.vim
mv ~/vimrc_example.vim ~/.vimrc
ls -al ~/.vimrc
```

然后编辑.vimrc文件加入自定义内容即可

## Vim的插件方式
从 Vim7.4 开始，引入了包（package）的概念，可以方便的用包来管理插件。
当 Vim 启动加载了 vimrc 之后，会在 ``packpath`` 里面寻找
```
/pack/*/opt
/pack/*/start
```
这2个路径，并且加载其中的内容。opt为手动加载路径，start为自动加载路径。  
只要将 ``github`` 上面下载的插件（文件夹）作为包直接放到路径内即可。  
opt内的手动加载，需要运行
```
packadd (包名，也就是文件夹名)
```

## 笔者的vimrc
* [Vim-conf](Vim-conf)

按笔者的习惯，主要有如下几个考虑点
 1. 不污染服务器。（不放到 ``$HOME`` 下面）
 2. 尽量不用插件。（服务器网络限制）

在服务器的个人bashrc下加入如下内容
```
export VIMINIT='source $MYVIMRC'
export MYVIMRC='/lch/workspace/vim/.vimrc'
```
当 vim 启动时，会加载 通过 VIMINIT 设定的 MYVIMRC 的内容，作为 vim 的设定文件  
也可以用起别名的方法
```
alias vim='vim -u /lch/workspace/vim/.vimrc'
```

#### 让自定义文件夹生效
在 vimrc 加入如下内容
```
"在packpath,runtimepath最后添加个人设定的路径，用以载入插件等
exec "set packpath+=" . g:g_s_rcfilepath . '/vimconf'
exec "set runtimepath+=" . g:g_s_rcfilepath . '/vimconf'
"在runtimepath最后添加个人设定的后路径(after directory)，用以载入高亮的定制
exec "set packpath+=" . g:g_s_rcfilepath . '/vimconf/after'
exec "set runtimepath+=" . g:g_s_rcfilepath . '/vimconf/after'
```

#### 笔者的vimrc目录树
```
vim (Root)
  .vimrc
  .gvimrc
├─vimconf
    └─after
      └─ftplugin
          c.vim
          python.vim
      └─syntax
          c.vim
          go.vim
          java.vim
          python.vim
    ├─colors
        lch-16.vim
        lch-dark.vim
        lch-light.vim
    ├─dict
        c.dict
        python.dict
        ...
    ├─init
        apc.vim
        buildtask.vim
        format.vim
        keybindings.vim
        snippets.vim
        terminal.vim
        vim_dict.vim
    └─pack
      └─vendor
        └─start         ->这里放自动载入插件
            nerdtree
            ...
        └─opt           ->这里放手动载入插件
            tagbar
            ...
```

## 文件类型关联

方法1：打开文件后用命令辅正
```
set filetype=python
set filetype=html
set filetype=c
```

方法2：修改filetype.vim文件

设定filetype on 打开文件类型检测。
如果该项被打开，vim 在初始化的时候会读取脚本 \$VIMRUNTIME/filetype.vim 和 \$VIMRUNTIME/filetype.lua 的内容。
这两个脚本用来识别文件类型。
```bash
cp -afp /usr/share/vim/vim80/filetype.vim /usr/share/vim/vim80/filetype.vim_bak20230414
vim /usr/share/vim/vim80/filetype.vim
```
找到
```
au BufNewFile,BufRead *.qc			setf c
```
这里是Quake C的定义，我们仿照它，在它下面新加一行，
定义pc扩展名的文件类型为C
```
au BufNewFile,BufRead *.pc			setf c
```

添加后就像下面的样子
```
" Quake C
au BufNewFile,BufRead *.qc			setf c
" PC
au BufNewFile,BufRead *.pc			setf c
```

:wq保存文件即可

## vimrc最小化设定
有时候我们只是临时用一下，可以如下设定（注意备份）：

#### default.vim
在set history=200上面加入
```
set number
set showtabline=2
let g:netrw_browse_split = 3
```

#### filetype.vim
在Quake C下面加入
```
" Quake C
au BufNewFile,BufRead *.qc			setf c
" ECPG
au BufNewFile,BufRead *.pc			setf c
```

## 关于配色
Vim主要使用以下九种高亮分组：
```
Comment    : 注释
Constant   : 常量，例如数字、引号内字符串、布尔值。
Identifier : 标识符。
Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。
PreProc    : 预处理，例如C语言中的“#include”。
Type       : 变量类型，例如“int”。
Special    : 特殊符号，通常是类似字符串中的“\n”。
Underlined : 文本下划线。
Error      : 显示编程语言错误的文本。
```
另外还有一个分组叫做**Normal**，表示普通文本  

Vim还支持三种输出设备：
* black-and-white terminal（黑白终端：term）  
* color terminal（彩色终端：cterm）  
* GUI（图形化的用户接口：gui）  

因为它们每一个都有自己独特的高亮能力，Vim为它们维护了三个独立的高亮方案。