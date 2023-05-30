scriptencoding utf-8
".vimrc

" When started as "evim", evim.vim will already have done these settings, bail out.
if v:progname =~? "evim"
  finish
endif

set nocompatible                         " 去除vi一致性

" 8.0版本之后才导入defaults.vim
if (v:version > 799)
  source $VIMRUNTIME/defaults.vim
endif

"-----------------------------------------------"
"               开始设置                        "
"-----------------------------------------------"
filetype off                             " 关闭文件类型检测，因为在这里开启之后，下面的[augroup filetypedetect]不会生效
filetype plugin indent off
"-----------------------------------------------"
"               基础设置                        "
"-----------------------------------------------"
let &t_ut=''                             " 调整终端和vim颜色
set modelines=0                          " 禁用模式行（安全措施）
syntax enable
syntax on                                " 语法高亮
"colorscheme desert                       " 设置颜色主题
set encoding=utf-8                       " 编码设置
set fileencoding=utf-8                   " 编码设置
set fileencodings=utf-8,ucs-bom,shift-jis,cp932,euc-jp,gb18030,gbk,gb2312,cp936,utf-16,big5,latin1
                                         " 自动识别文件编码，依照fileencodings提供的编码列表尝试
set number                               " 显示行号
set ruler                                " 显示光标所在位置的行号和列号，在右下角显示光标位置
set nowrap                               " 不自动折行
set tabstop=4                            " tab为4个空格
set shiftwidth=4                         " 每一级缩进是4个空格
set noexpandtab                          " 不将tab替换为相应数量空格         打开为set expandtab
set softtabstop=4                        " 在编辑模式下按退格键的时候退回缩进的长度，配合expandtab时很有用
set smarttab                             " 根据文件中其他位置的缩进空格个数来决定一个tab是多少空格
"set smartindent                          " 智能缩进对齐（和autoindent开启一项即可，看个人喜好）
set autoindent                           " 自动对齐
set backspace=2                          " 设置 backspace可以删除任意字符，数值2同set backspace=indent,eol,start
set mouse=a                              " 使用鼠标
set mousehide                            " 输入时隐藏光标
set clipboard^=unnamed,unnamedplus       " 和系统共享剪切板
set nobackup                             " 不需要备份文件
set noswapfile                           " 不创建临时交换文件
set nowritebackup                        " 编辑的时候不需要备份文件
set autoread                             " 文件自动检测外部更改
set showmatch                            " 显示匹配,当输入一个左括号时会匹配相应的那个右括号
set matchtime=1                          " 显示括号时间，1秒
set splitright                           " 设置左右分割窗口时，新窗口出现在右侧
set splitbelow                           " 设置水平分割窗口时，新窗口出现在底部
set laststatus=2                         " 显示状态行 2: 总是
set cursorline                           " 高亮显示当前行
set hlsearch                             " 搜索时高亮显示被找到的文本
set incsearch                            " 搜索时在未完全输入完毕要检索的文本时就开始检索
set ambiwidth=double                     " 防止特殊符号无法正常显示。解决中文标点显示的问题
set sidescroll=10                        " 移动到看不见的字符时，自动向右滚动是个字符
set novisualbell                         " 不要闪烁
set showcmd                              " 显示输入的命令
set showtabline=2                        " 显示tab栏 2: 永远会
set ttyfast                              " 快速刷新屏幕显示
set lazyredraw                           " 只在必要时刷新显示
set ignorecase                           " 搜索时忽略大小写
set smartcase                            " 智能搜索 - 搜索“test”会找到并突出显示 test 和 Test。搜索“Test”只突出显示或只找到 Test
set nowrapscan                           " 禁止在搜索到文件两端时重新搜索（不循环搜索）
set showmode                             " 左下角显示如“—INSERT--”之类的状态栏
set scrolloff=4                          " 垂直滚动时，光标保持在距顶部/底部 4 行的位置
set sidescrolloff=8                      " 左右滚动时，光标保持在距左/右 8 列的位置
set sidescroll=1                         " 左右滚动时，1个字符1个字符滚动
set autochdir                            " 自动切换工作目录
set wildmenu                             " 在命令模式下，底部操作指令按下 Tab 键自动补全。
set showfulltag                          " 补全时，使用整行补全
set wildoptions=tagfile                  " 开启tagfile的补全
set ttimeout                             " 让按 Esc 的生效更快速。通常 Vim 要等待一秒来看看 Esc 是否是转义序列的开始。如果你使用很慢的远程连接，增加此数值
set ttimeoutlen=50
set formatoptions+=m                     " UniCode大于255的文本，不必等到空格再这行
set formatoptions+=B                     " 合并两行中文时，不在中间加空格
set t_Co=256                             " 设置Vim支持256色
if (has("termguicolors"))
  "从7.4.1830开始支持启用终端真彩色，可以让终端环境的Vim使用GUI的颜色定义，需要终端环境和环境内的组件（比如 tmux）都支持真彩色
  set termguicolors
endif
"在普通模式下用块状光标，在插入模式下用条状光标（形状类似英文 "I" 的样子），然后在替换模式中使用下划线形状的光标。
"t_SI：插入模式开始，t_EI：插入或者替换模式结束，t_SR：替换模式开始
if has('gui_running')
  " Gvim 环境：在[.gvimrc]中设定
elseif has('win32unix')
  " (mintty)Windows 环境的msys2, Cygwin（包含git-bash，不包含WSL）
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[1 q"
  let &t_SR = "\e[3 q"
else
  if empty($TMUX)
    " 其他环境（包含linux服务器，WSL）
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[1 q"
    if (v:version > 799)
      let &t_SR = "\e[3 q"
    endif
  else
    " Tmux下
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    if (v:version > 799)
      let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    endif
  endif
endif

let g:python_recommended_style = 0       " 不启用ftplugin/python.vim中的PEP8标准（启用设定修改值为1）
let g:rust_recommended_style = 0         " 不启用ftplugin/rust.vim中的tab设定（启用设定修改值为1）

"-----------------------------------------------"
"               特殊符号设置                      "
"-----------------------------------------------"
"特殊符号确认命令 :dig :help digraphs-use
"tab：tab键，要指定2个字符
"trail：换行符后面的空格
"eol：换行符（end of line）
"extends：最后一列中的字符，表示下一行是换行的延续
"precedes：第一列中的字符，表示此行是前一行的延续
"nbsp：不可见空格
"space：可见空格
set list
if has('gui_running')
  " Gvim 环境：在[.gvimrc]中设定
elseif has('win32')
  " Windows 环境
  set listchars=tab:^\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:↲
elseif has('win32unix')
  " (mintty)Windows 环境的msys2, Cygwin（包含git-bash，不包含WSL）
  set listchars=tab:^\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:↲
else
  " 其他环境（包含linux服务器，WSL）
  if (v:version > 799)
    set listchars=tab:^\ ,trail:.,precedes:<,extends:>,nbsp:%,space:.,eol:$
  else
    set listchars=tab:^\ ,trail:.,precedes:<,extends:>,nbsp:%,eol:$
  endif
endif

"-----------------------------------------------"
"               暂时不用                        "
"-----------------------------------------------"
"set relativenumber                       " 显示相对行号
"set wrap                                 " 自动折行
"set cursorcolumn                         " 高亮显示当前列
"set fdm=marker                           " 设置折叠方式
"set virtualedit=all                      " 允许光标放到当前行末尾之后

"-----------------------------------------------"
"               文件关联                        "
"-----------------------------------------------"
augroup filetypedetect
  autocmd! BufRead,BufNewFile *.pc     setfiletype c
augroup END

"-----------------------------------------------"
"               设置状态栏                      "
"-----------------------------------------------"
" %{...} 评估表达式的值，并用值代替
" %{"[fenc=".(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?"+":"")."]"} 显示文件编码
" %{&ff} 显示文件类型
"更多请看[:h statusline]
"set statusline=%F%m%r%h%w%=\ 
"set statusline+=\ FMT=%{&ff}\ \|\ 
"set statusline+=TYPE=%Y\ \|\ 
"set statusline+=CODE=%{\"\".(\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}\ 
"set statusline+=[%l:%v]\ 
"set statusline+=%p%%\ \|\ 
"set statusline+=%LL\ 
"-----------------------------------------------
" 设置仿照lightlint
function! Statusline()
  let l:show_mode_map={
      \ 'n'  : 'NORMAL',
      \ 'i'  : 'INSERT',
      \ 'r'  : 'CONFIRM',
      \ 'R'  : 'REPLACE',
      \ 'v'  : 'VISUAL',
      \ 'V'  : 'V-LINE',
      \ "\<C-v>"  : 'V-BLOCK',
      \ 'c'  : 'COMMAND',
      \ '!'  : 'COMMAND',
      \ 's'  : 'SELECT',
      \ 'S'  : 'S-LINE',
      \ "\<C-s>"  : 'S-BLOCK',
      \ 't'  : 'TERMINAL'
      \}
  let l:currentMode = mode()
  let l:showMode = ''
  if (has_key(show_mode_map, currentMode))
    let l:showMode .= show_mode_map[currentMode]
  else
    let l:showMode .= 'NORMAL'
  endif
  let l:resultStr = ''                              " 初始化
  let l:resultStr .= '%1* ' . showMode . ' '        " 显示当前编辑模式，高亮为用户组1
  let l:resultStr .= '%2* %t'                       " 显示当前文件(t)，高亮为用户组2
  let l:resultStr .= '%3* %m%r%h%w %*%='            " 显示当前文件标记(mrhw)，高亮为用户组3，之后用=开始右对齐
  let l:resultStr .= '%* %{&ff} | %{"".(""?&enc:&fenc).((exists("+bomb") && &bomb)?"+":"").""} | %Y '        " 显示换行符，编码，文件类型，高亮为默认（ LF | utf-8 | fomart ）
  let l:resultStr .= '%2* [%l:%v] '                 " 显示当前行，列，高亮为用户组2
  let l:resultStr .= '%1* %p%% %LL '                " 显示百分比，总行数，高亮为用户组4
  return resultStr
endfunction
set statusline=%!Statusline()

" 模式变换时的函数
function! RestUserColor(pmode)
  if a:pmode == 'ModeChanged'
    let l:currentMode = mode()
    if (currentMode == 'i')                "插入模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=226 gui=bold guifg=#000000 guibg=#ffff00
    elseif (currentMode == 'n')            "普通模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=45 gui=bold guifg=#000000 guibg=#00d7ff
    elseif (currentMode == 'v' || currentMode == 'V' || currentMode == "\<C-v>" || currentMode == "\<C-vs>")      "可视模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=48 gui=bold guifg=#000000 guibg=#00ff87
    elseif (currentMode == 'R')            "替换模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=231 ctermbg=160 gui=bold guifg=#ffffff guibg=#d70000
    elseif (currentMode == 'c' || currentMode == '!')       "命令模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=231 ctermbg=201 gui=bold guifg=#ffffff guibg=#ff00ff
    elseif (currentMode == 's' || currentMode == 'S' || currentMode == "\<C-s>")      "选择模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=178 gui=bold guifg=#000000 guibg=#d7af00
    elseif (currentMode == 't')            "终端模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=231 ctermbg=16 gui=bold guifg=#ffffff guibg=#000000
    elseif (currentMode == 'r')            "确认模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=177 gui=bold guifg=#000000 guibg=#d787ff
    else            "默认普通模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=45 gui=bold guifg=#000000 guibg=#00d7ff
    endif
  elseif a:pmode == 'InsertEnter'
    hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=226 gui=bold guifg=#000000 guibg=#ffff00
  elseif a:pmode == 'InsertLeave'
    hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=45 gui=bold guifg=#000000 guibg=#00d7ff
  endif
endfunction

" 添加模式变换时的自动命令
augroup lchgroup
  autocmd!
  if exists("##ModeChanged")
    "存在ModeChanged自动命令
    autocmd ModeChanged *:* call RestUserColor('ModeChanged')
  else
    "不存在ModeChanged自动命令
    autocmd InsertEnter * call RestUserColor('InsertEnter')
    autocmd InsertLeave * call RestUserColor('InsertLeave')
  endif
  "插入模式中关闭当前行高亮
  "autocmd InsertEnter,WinLeave * set nocursorline
  "autocmd InsertLeave,WinEnter * set cursorline
augroup END

hi StatuslineNC cterm=reverse gui=reverse 
hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=45 gui=bold guifg=#000000 guibg=#00d7ff
hi User2        term=none cterm=none ctermfg=231 ctermbg=241 gui=none guifg=#ffffff guibg=#606060
hi User3        term=none cterm=none ctermfg=226 ctermbg=241 gui=none guifg=#ffff00 guibg=#606060

"-----------------------------------------------"
"               设置tab                         "
"-----------------------------------------------"
" 设置结果为[3]file.txt [+]
function! Tabline()
  let resultStr = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let resultStr .= '%' . tab . 'T'
    let resultStr .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    "let resultStr .= ' ' . tab .':'
    let resultStr .= ' [' . tab .']'
    "let resultStr .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')
    let resultStr .= (bufname != '' ? ''. fnamemodify(bufname, ':t') . ' ' : '[NoName] ')

    if bufmodified
      let resultStr .= '[+] '
    endif
  endfor

  let resultStr .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let resultStr .= '%=%999XX'
  endif
  return resultStr
endfunction
set tabline=%!Tabline()

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
"               颜色设置                        "
"-----------------------------------------------"
let scriptPath = expand("<sfile>:p:h")
if has('gui_running')
  " Gvim 环境：在[.gvimrc]中设定
else
  "exec 'source' scriptPath . '/vim-color-16-rc.vim'
  exec 'source' scriptPath . '/vim-color-256-rc.vim'
  "exec 'source' scriptPath . '/vim-color-256-rc-light.vim'
endif

"-----------------------------------------------"
"               快捷键绑定                      "
"-----------------------------------------------"
let mapleader='\'                    " 设定前缀为 \
noremap J 10j                        " 大写J，向下10行
noremap K 10k                        " 大写K，向上10行
nnoremap + <C-a>                     " +号，数字+1
nnoremap - <C-x>                     " -号，数字-1
noremap n nzz                        " 在画面中央表示搜索结果
noremap N Nzz
noremap * *zz
noremap # #zz
" 窗口移动快捷键
noremap <TAB>w <C-w>w                " tab+w：移动窗口
noremap <TAB><left> <C-w><left>      " tab+左：移动到左边窗口
noremap <TAB><right> <C-w><right>    " tab+右：移动到右边窗口
noremap <TAB><up> <C-w><up>          " tab+上：移动到上边窗口
noremap <TAB><down> <C-w><down>      " tab+下：移动到下边窗口
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
" 重新绘制当前的屏幕，并且取消字符的高亮，快捷键 \l
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" 设定文件只读模式切换：静默运行，快捷键 空格+s+空格
nnoremap <silent> <SPACE>s<SPACE> :if &modifiable \| setl nomodifiable \| echo 'Current buffer is set readonly complete ' \| else \| setl modifiable \| echo 'Current buffer is cancel readonly complete ' \| endif<CR>

"-----------------------------------------------"
"               设置ctags                       "
"-----------------------------------------------"
function! Make_tags_gitdir()
  " 执行[git rev-parse --show-toplevel]命令找到git的根目录
  let l:toplevel = system('git rev-parse --show-toplevel')
  if v:shell_error
    echo 'failed: git root dir is not found'
  endif
  let l:toplevel = substitute(l:toplevel, '[\r\n]', '', 'g')

  " 取得当前目录
  let l:cache_pwd = ''
  redir => l:cache_pwd
    silent pwd
  redir END
  let l:cache_pwd = substitute(l:cache_pwd, '[\r\n]', '', 'g')

  " 设定ctags参数
  let l:opt = '--append=yes --recurse=yes --langmap=C:+.pc --c-kinds=defghlmstuvxzLD --output-format=e-ctags'
  if &filetype ==# 'c'
    let l:opt = l:opt.' --languages=C'
  elseif &filetype !=# ''
    let l:opt = l:opt.' --languages='.&filetype
  endif

  " 设定ctags文件名
  "let l:tagfile = l:toplevel.'/.tags'
  let l:tagfile = '.tags'

  " 生成ctags文件
  try
    exe 'lcd '.l:toplevel
    "call system('ctags --tag-relative --recurse --sort=yes --append=no '.l:opt.' -f '.l:tagfile.' '.l:toplevel) " 用绝对路径生成
    call system('ctags '.l:opt.' -f '.l:tagfile)
    echo 'done'
  catch
    echo 'error:' . v:exception
  finally
    exe 'lcd '.l:cache_pwd
  endtry
endfunction
" 绑定运行函数快捷键 空格+tg
nnoremap <SPACE>tg :call Make_tags_gitdir()

set tags=./.tags;,.tags

"-----------------------------------------------"
"               其他设置                        "
"-----------------------------------------------"

if (v:version > 799)
  "载入韦易笑做的代码补全系统
  exec 'source' scriptPath . '/apc.vim'
  "Plug 'skywind3000/vim-auto-popmenu'
  " 设定需要生效的文件类型，如果是 "*" 的话，代表所有类型
  let g:apc_enable_ft = {'*':1}
  " 设定从字典文件以及当前打开的文件里收集补全单词，详情看 ':help cpt'
  set cpt=.,k,w,b
  " 不要自动选中第一个选项。
  set completeopt=menu,menuone,noselect
  " 禁止在下方显示一些啰嗦的提示
  set shortmess+=c
endif

"-----------------------------------------------"
"               结束设置                        "
"-----------------------------------------------"
filetype on                              " 开启文件类型检测
filetype plugin indent on
