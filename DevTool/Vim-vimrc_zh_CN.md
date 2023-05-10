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

## vimrc配置的例子

参考同路径下的2个文件
* .vimrc ： git-bash用
* lchvimrc ： linux服务器用

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