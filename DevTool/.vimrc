scriptencoding utf-8
".vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

"-----------------------------------------------"
"               基础设置                        "
"-----------------------------------------------"
let &t_ut=''                             " 调整终端和vim颜色
set modelines=0                          " 禁用模式行（安全措施）
filetype on                              " 开启文件类型检测
syntax enable
syntax on                                " 语法高亮
"colorscheme desert                       " 设置颜色主题
set encoding=utf-8                       " 编码设置
set fileencoding=utf-8                   " 编码设置
set fileencodings=utf-8,ucs-bom,shift-jis,cp932,euc-jp,gb18030,gbk,gb2312,cp936,utf-16,big5,latin1
                                         " 自动识别文件编码，依照fileencodings提供的编码列表尝试
set number                               " 显示行号
set smartindent                          " 智能缩进对齐
set autoindent                           " 自动对齐
set ruler                                " 显示光标所在位置的行号和列号，在右下角显示光标位置
set nowrap                               " 不自动折行
set smarttab                             " 根据文件中其他位置的缩进空格个数来决定一个tab是多少空格
set tabstop=4                            " tab为4个空格
set shiftwidth=4                         " 每一级缩进是4个空格
set noexpandtab                          " 不将tab替换为相应数量空格         打开为set expandtab
set softtabstop=4                        " 在编辑模式下按退格键的时候退回缩进的长度，配合expandtab时很有用
set backspace=2                          " 设置 backspace可以删除任意字符，数值2同set backspace=indent,eol,start
set mouse=a                              " 使用鼠标
set mousehide                            " 输入时隐藏光标
set clipboard^=unnamed,unnamedplus       " 和系统共享剪切板
set nobackup                             " 不需要备份文件
set noswapfile                           " 不创建临时交换文件
set nowritebackup                        " 编辑的时候不需要备份文件
set autoread                             " 文件自动检测外部更改
set showmatch                            " 显示匹配,当输入一个左括号时会匹配相应的那个右括号
set splitright                           " 设置左右分割窗口时，新窗口出现在右侧
set splitbelow                           " 设置水平分割窗口时，新窗口出现在底部
set laststatus=2                         " 显示状态行 2: 总是
set cursorline                           " 高亮显示当前行
set hlsearch                             " 搜索时高亮显示被找到的文本
set incsearch                            " 搜索时在未完全输入完毕要检索的文本时就开始检索
set ambiwidth=double                     " 防止特殊符号无法正常显示。解决中文标点显示的问题
set sidescroll=10                        " 移动到看不见的字符时，自动向右滚动是个字符
set sm!                                  " 高亮显示匹配括号
set novisualbell                         " 不要闪烁
set showcmd                              " 显示输入的命令
set showtabline=2                        " 显示tab栏 2: 永远会
set ttyfast                              " 快速刷新屏幕显示
set lazyredraw                           " 只在必要时刷新显示
set ignorecase                           " 搜索时忽略大小写
set smartcase                            " 智能搜索 - 搜索“test”会找到并突出显示 test 和 Test。搜索“Test”只突出显示或只找到 Test
set nowrapscan                           " 禁止在搜索到文件两端时重新搜索（不循环搜索）
set t_Co=256                             " 设置Vim支持256色
set showmode                             " 左下角显示如“—INSERT--”之类的状态栏
set scrolloff=4                          " 垂直滚动时，光标保持在距顶部/底部 4 行的位置
set autochdir                            " 自动切换工作目录
set wildmenu                             " 在命令模式下，底部操作指令按下 Tab 键自动补全。
set ttimeout                             " 让按 Esc 的生效更快速。通常 Vim 要等待一秒来看看 Esc 是否是转义序列的开始。如果你使用很慢的远程连接，增加此数值
set ttimeoutlen=50
set formatoptions+=m                     " UniCode大于255的文本，不必等到空格再这行
set formatoptions+=B                     " 合并两行中文时，不在中间加空格

"-----------------------------------------------"
"               特殊符号设置                    "
"-----------------------------------------------"
"特殊符号确认命令
":dig
":help digraphs-use
"tab：tab键，要指定2个字符
"trail：换行符后面的空格
"eol：换行符（end of line）
"extends：最后一列中的字符，表示下一行是换行的延续
"precedes：第一列中的字符，表示此行是前一行的延续
"nbsp：不可见空格
"space：可见空格
set list
if has('gui_running')
  " Gvim 环境
  set listchars=tab:^\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:⏎
elseif has('win32')
  " Windows 环境
  set listchars=tab:^\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:↲
elseif has('win32unix')
  " Windows 环境的msys2, Cygwin（包含git-bash，不包含WSL）
  set listchars=tab:^\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:↲
else
  " 其他环境（包含linux服务器，WSL）
  set listchars=tab:^\ ,trail:.,precedes:<,extends:>,nbsp:%,space:.,eol:$
endif

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
let scriptPath = expand("<sfile>:p:h")
if has('gui_running')
else
  "exec 'source' scriptPath . '/vim-color-16-rc.vim'
  "exec 'source' scriptPath . '/vim-color-256-rc.vim'
  exec 'source' scriptPath . '/vim-color-256-rc-light.vim'
endif

"-----------------------------------------------"
"               暂时不用                        "
"-----------------------------------------------"
"set relativenumber                       " 显示相对行号
"set wrap                                 " 自动折行
"set termguicolors                        " 启用终端真色
"set cursorcolumn                         " 高亮显示当前列
"set fdm=marker                           " 设置折叠方式
"set nocompatible                         " 去除vi一致性，关闭所有扩展的功能，尽量模拟 vi 的行为

"-----------------------------------------------"
"               文件关联                        "
"-----------------------------------------------"
augroup filetypedetect
  "PC
  au BufNewFile,BufRead *.pc              setf c
augroup END

"-----------------------------------------------"
"               设置状态栏                      "
"-----------------------------------------------"
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

"-----------------------------------------------"
"               设置netrw                       "
"-----------------------------------------------"
let g:netrw_banner = 0         " 设置是否显示横幅 0: 关闭横幅,1: 显示横幅1 (缺省)
let g:netrw_liststyle = 3      " 设置目录列表样式：树形
"let g:netrw_browse_split = 4   " 在之前的窗口编辑文件
let g:netrw_browse_split = 3   " 在新tab打开文件 0: 重用同一个窗口 (缺省),1: 水平分割窗口,2: 垂直分割窗口,3: 在新tab打开文件,4: 同 "P" (即打开前次窗口)
let g:netrw_sizestyle="H"      " 文件大小用(K,M,G)表示
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
                               " 日期格式用 yyyy/mm/dd(星期) hh:mm:ss
let g:netrw_alto = 1           " 使用o水平分割时，置位此变量后，分割后的新窗口出现在下方而不是上方
let g:netrw_altv = 1           " 使用v水平分割时，置位此变量后，分割后的新窗口出现在右方而不是左方
let g:netrw_preview=1          " 使用p预览文件使用垂直分割 0 (缺省)水平分割,垂直分割
let g:netrw_winsize = 70       " 指定 "o"、"v"、:Hexplore 或 :Vexplore 建立的新窗口的初始大小。整数百分比，来设定新窗口的大小。
let g:netrw_list_hide= '^\..*' " 不显示隐藏文件 用 a 键就可以显示所有文件、 隐藏匹配文件或只显示匹配文件
let g:netrw_keepdir = 0        " 用tree打开的路径作为当前路径，在这个路径下默认操作

" 自动打开netrw
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

nnoremap <SPACE>ft :Lexplore<CR>    " 打开或关闭目录树：空格+ft

"-----------------------------------------------"
"               快捷键绑定                      "
"-----------------------------------------------"
let mapleader='\'                    " 设定前缀为 \
noremap J 10j                        " 大写J，向下10行
noremap K 10k                        " 大写K，向上10行
" 窗口移动快捷键
noremap <TAB>w <C-w>w                " tab+w：移动tab
noremap <TAB><left> <C-w><left>      " tab+左：移动到左边tab
noremap <TAB><right> <C-w><right>    " tab+右：移动到右边tab
noremap <TAB><up> <C-w><up>          " tab+上：移动到上边tab
noremap <TAB><down> <C-w><down>      " tab+下：移动到下边tab
" 使用方向键切换buffer
noremap <Leader><left> :bp<CR>       " \+左：上一个buffer
noremap <Leader><right> :bn<CR>      " \+右：下一个buffer
" 使用方括号切换tab
noremap <Leader>] :tabnext<CR>       " \+]：上一个tab
noremap <Leader>[ :tabprevious<CR>   " \+[：下一个tab
" 使用 \ + s 保存, \ + q 退出
noremap <Leader>s :w<CR>             " \+s：保存文件
noremap <Leader>q :q<CR>             " \+q：退出
" 支持在Visual模式下，通过C-y复制到系统剪切板 （vnoremap视觉和选择模式下工作）
vnoremap <C-y> "+y
" 支持在normal模式下，通过C-p粘贴系统剪切板 （nnoremap在正常模式下工作）
nnoremap <C-p> "*p
"在编程中经常要复制粘贴一些内容。为了解决寄存器混乱的问题，这里如下定义
"<Leader>y  复制到字母寄存器c
vnoremap <Leader>y "cy
"<Leader>p  从字母寄存器c中粘贴内容
nnoremap <Leader>p "cp
nnoremap <Leader>P "cP

""""""""""""""""""""""""""""""""""""""""""""""""

"载入韦易笑做的代码补全系统
"https://zhuanlan.zhihu.com/p/349271041
"https://github.com/skywind3000/vim-auto-popmenu
"从github上下载apc.vim，放到~/apc.vim
exec 'source' scriptPath . '/apc.vim'
"source ~/apc.vim
"Plug 'skywind3000/vim-auto-popmenu'
" 设定需要生效的文件类型，如果是 "*" 的话，代表所有类型
let g:apc_enable_ft = {'*':1}
" 设定从字典文件以及当前打开的文件里收集补全单词，详情看 ':help cpt'
set cpt=.,k,w,b
" 不要自动选中第一个选项。
set completeopt=menu,menuone,noselect
" 禁止在下方显示一些啰嗦的提示
set shortmess+=c
