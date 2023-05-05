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

```
".vimrc
scriptencoding utf-8

"-----------------------------------------------"
"               基础设置                        "
"-----------------------------------------------"
set modelines=0                          " 禁用模式行（安全措施）
filetype on                              " 开启文件类型检测
syntax on                                " 语法高亮
colorscheme desert                       " 设置颜色主题
set encoding=utf-8                       " 编码设置
set fileencoding=utf-8                   " 编码设置
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,utf-16,big5,euc-jp,latin1
                                         " 自动识别文件编码，依照fileencodings提供的编码列表尝试
set number                               " 显示行号
set smartindent                          " 智能缩进对齐
set autoindent                           " 自动对齐
set ruler                                " 显示光标所在位置的行号和列号，在右下角显示光标位置
set nowrap                               " 不自动折行
set smarttab                             " 根据文件中其他位置的缩进空格个数来决定一个tab是多少空格
set tabstop=4                            " tab为4个空格
set shiftwidth=4                         " 每一级缩进是4个空格
"set expandtab                            " 将tab替换为相应数量空格
set softtabstop=4                        " 在编辑模式下按退格键的时候退回缩进的长度，配合expandtab时很有用
set backspace=2                          " 设置 backspace可以删除任意字符
set mouse=a                              " 使用鼠标
set mousehide                            " 输入时隐藏光标
set clipboard^=unnamed,unnamedplus       " 和系统共享剪切板
set nobackup                             " 设置取消备份
set noswapfile                           " 禁止生成临时文件
set autoread                             " 文件自动检测外部更改
set showmatch                            " 显示匹配,当输入一个左括号时会匹配相应的那个右括号
set splitright                           " 设置左右分割窗口时，新窗口出现在右侧
set splitbelow                           " 设置水平分割窗口时，新窗口出现在底部
set laststatus=2                         " 命令行为两行
set cursorline                           " 高亮显示当前行
set hlsearch                             " 搜索时高亮显示被找到的文本
set is                                   " 搜索时在未完全输入完毕要检索的文本时就开始检索
set ambiwidth=double                     " 防止特殊符号无法正常显示。解决中文标点显示的问题
set sidescroll=10                        " 移动到看不见的字符时，自动向右滚动是个字符
set sm!                                  " 高亮显示匹配括号
set novisualbell                         " 不要闪烁
set showcmd                              " 显示输入的命令
set showtabline=2                        " 显示tab栏
set ttyfast                              " 快速刷新屏幕显示
set lazyredraw                           " 只在必要时刷新显示
set ignorecase                           " 忽略大小写

"行尾继续符，换行符，左右窗口大小不够时的提示符，半角空格的表示
"tab：tab键，要指定2个字符
"trail：换行符后面的空格
"eol：换行符（end of line）
"extends：最后一列中的字符，表示下一行是换行的延续
"precedes：第一列中的字符，表示此行是前一行的延续
"nbsp：不可见空格
"space：可见空格
"特殊符号确认命令
":dig
":help digraphs-use
set list
"for linux
"set listchars=tab:^\ ,trail:.,precedes:<,extends:>,nbsp:%,space:.,eol:$
"for windows:git-bash
"set listchars=tab:￫￫,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:↲
set listchars=tab:^\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:↲

"颜色
"非可见字符"eol"、"extends"、"precedes"是由NonText高亮组来控制显示颜色的，而"nbsp"、"tab"、"trail"则是由"SpecialKey"高亮组来定义的。
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
hi NonText      term=bold cterm=bold ctermfg=0 ctermbg=0 gui=bold guifg=DarkGrey guibg=grey30
hi SpecialKey   term=bold cterm=bold ctermfg=0 ctermbg=0 gui=bold guifg=DarkGrey guibg=grey30
"hi StatusLine     term=bold,reverse cterm=bold,reverse gui=bold,reverse guifg=lightyellow guibg=darkblue ctermfg=lightyellow ctermbg=darkblue
hi TabLineSel     term=bold cterm=bold gui=bold guifg=yellow guibg=darkblue ctermfg=yellow ctermbg=darkblue

"set relativenumber                       " 显示相对行号
"set wrap                                 " 自动折行
"set termguicolors                        " 启用终端真色
"set cursorcolumn                         " 高亮显示当前列
"set fdm=marker                           " 设置折叠方式
"set nocompatible                         " 去除vi一致性，关闭所有扩展的功能，尽量模拟 vi 的行为

" 设置文件关联-----------------------------------
"augroup filetypedetect
" PC
"au BufNewFile,BufRead *.pc			setf c
"augroup END

" 设置状态行-----------------------------------
" 设置状态行显示常用信息
" %F 完整文件路径名
" %m 当前缓冲被修改标记
" %r 当前缓冲只读标记
" %h 帮助缓冲标记
" %w 预览缓冲标记
" %Y 文件类型
" %b ASCII值
" %B 十六进制值
" %l 行数
" %v 列数
" %p 当前行数占总行数的的百分比
" %L 总行数
" %{...} 评估表达式的值，并用值代替
" %{"[fenc=".(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?"+":"")."]"} 显示文件编码
" %{&ff} 显示文件类型
set statusline=%F%m%r%h%w%=\ 
set statusline+=\ FMT=%{&ff}\ \|\ 
set statusline+=TYPE=%Y\ \|\ 
set statusline+=CODE=%{\"\".(\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}\ 
set statusline+=[%l:%v]\ 
set statusline+=%p%%\ \|\ 
set statusline+=%LL\ 

" 设置netrw-------------------------------------
let g:netrw_banner = 0         " 设置是否显示横幅
let g:netrw_liststyle = 3      " 设置目录列表样式：树形
"let g:netrw_browse_split = 4   " 在之前的窗口编辑文件
let g:netrw_browse_split = 3   " 在新tab打开文件
let g:netrw_sizestyle="H"      " 文件大小用(K,M,G)表示
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
                               " 日期格式用 yyyy/mm/dd(星期) hh:mm:ss
let g:netrw_altv = 1           " 水平分割时，文件浏览器始终显示在左边
let g:netrw_preview=1          " 预览文件使用垂直分割
let g:netrw_winsize = 20       " 设置文件浏览器窗口宽度为25%
let g:netrw_list_hide= '^\..*' " 不显示隐藏文件 用 a 键就可以显示所有文件、 隐藏匹配文件或只显示匹配文件
"let g:netrw_keepdir = 0        " 用tree打开的路径作为当前路径，在这个路径下默认操作

" 自动打开文件浏览器
" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * :Vexplore
" augroup END

nnoremap <SPACE>ft :Lexplore<CR>    " 打开或关闭目录树

"-----------------------------------------------"
"               自定义功能                      "
"-----------------------------------------------"
" 快捷键绑定-------------------------
let mapleader='\'
" 窗口移动快捷键
noremap <TAB>w <C-w>w
noremap <TAB><left> <C-w><left>
noremap <TAB><right> <C-w><right>
noremap <TAB><up> <C-w><up>
noremap <TAB><down> <C-w><down>
" 使用方向键切换buffer
noremap <Leader><left> :bp<CR>
noremap <Leader><right> :bn<CR>
" 使用方括号切换tab
noremap <Leader>] :tabnext<CR>
noremap <Leader>[ :tabprevious<CR>
" 使用 \ + s 保存, \ + q 退出
noremap <Leader>s :w<CR>
noremap <Leader>q :q<CR>
" 支持在Visual模式下，通过C-y复制到系统剪切板 （vnoremap视觉和选择模式下工作）
vnoremap <C-y> "+y
" 支持在normal模式下，通过C-p粘贴系统剪切板 （nnoremap在正常模式下工作）
nnoremap <C-p> "*p

""""""""""""""""""""""""""""""""""""""""""""""""

"载入韦易笑做的代码补全系统
"https://zhuanlan.zhihu.com/p/349271041
"https://github.com/skywind3000/vim-auto-popmenu
"从github上下载apc.vim，放到~/apc.vim
source ~/apc.vim

"Plug 'skywind3000/vim-auto-popmenu'

" 设定需要生效的文件类型，如果是 "*" 的话，代表所有类型
let g:apc_enable_ft = {'*':1}

" 设定从字典文件以及当前打开的文件里收集补全单词，详情看 ':help cpt'
set cpt=.,k,w,b

" 不要自动选中第一个选项。
set completeopt=menu,menuone,noselect

" 禁止在下方显示一些啰嗦的提示
set shortmess+=c

```

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
