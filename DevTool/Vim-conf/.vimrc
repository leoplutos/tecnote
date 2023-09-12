scriptencoding utf-8
".vimrc

" When started as "evim", evim.vim will already have done these settings, bail out.
if v:progname =~? "evim"
  finish
endif

set nocompatible                         " 去除vi一致性

" neovim判断
if has('nvim')
  let g:g_nvim_flg = 1
else
  let g:g_nvim_flg = 0
endif

" 8.0版本之后才导入defaults.vim
if (v:version > 799) && (g:g_nvim_flg == 0)
  source $VIMRUNTIME/defaults.vim
endif

"-----------------------------------------------"
"               环境变量设置                    "
"-----------------------------------------------"
"旧：全局变量g:g_use_lsp（0：不使用lsp，1：C/C++(clangd)，2：Python(pylsp)，3：Java(eclipse.jdt.ls)，4：Rust(rust-analyzer)，5：Go(gopls)，6：Vue(vls)）
"新：全局变量g:g_use_lsp（0：不使用lsp，1：使用lsp）
let g:g_use_lsp = 1
"全局变量g:g_lsp_type（0：vim-lsp，1：vim-lsc，2：LanguageClient-neovim）
let g:g_lsp_type = 0
"全局变量g:g_use_dap（0：不使用dap，1：使用dap）
let g:g_use_dap = 0
"全局变量g:g_i_osflg（1：Windows-Gvim，2：Windows-控制台，3：Windows-MSys2/Cygwin/Mingw，4：Linux/WSL）
if(has('win32') || has('win95') || has('win64') || has('win16'))
  if has('gui_running')
    let g:g_i_osflg=1
  else
    let g:g_i_osflg=2
  endif
elseif has('win32unix')
  let g:g_i_osflg=3
else
  let g:g_i_osflg=4
endif
if (g:g_i_osflg == 1 || g:g_i_osflg == 2)
  "Windows系统下加入GCC,Java,Python,Ctags,clang-format,black等环境变量
  let $CARGO_HOME = 'D:\Tools\WorkTool\Rust\Rust_gnu_1.70'
  let $RUSTUP_HOME = 'D:\Tools\WorkTool\Rust\Rust_gnu_1.70'
  let $GOROOT = 'D:\Tools\WorkTool\Go\go1.21.0.windows-amd64'
  let $GOPATH = 'D:\Tools\WorkTool\Go\go_global'
  let $PATH .= ';D:\Tools\WorkTool\C\codeblocks-20.03mingw-nosetup\MinGW\bin'
  let $PATH .= ';D:\Tools\WorkTool\C\ctags_6.0_x64'
  let $PATH .= ';D:\Tools\WorkTool\C\LLVM'
  let $PATH .= ';D:\Tools\WorkTool\C\LLVM\clangd_16.0.2\bin'
  let $PATH .= ';D:\Tools\WorkTool\Python\Python38-32'
  let $PATH .= ';D:\Tools\WorkTool\Python\Python38-32\Scripts'
  let $PATH .= ';D:\Tools\WorkTool\Java\jdk17.0.6\bin'
  let $PATH .= ';D:\Tools\WorkTool\Java\apache-ant-1.10.13\bin'
  let $PATH .= ';D:\Tools\WorkTool\Rust\Rust_gnu_1.70\bin'
  let $PATH .= ';D:\Tools\WorkTool\NodeJs\node-v18.17.1-win-x64'
  let $PATH .= ';D:\Tools\WorkTool\NodeJs\node-v18.17.1-win-x64\node_global'
  let $PATH .= ';D:\Tools\WorkTool\Go\go1.21.0.windows-amd64\bin'
  let $PATH .= ';D:\Tools\WorkTool\Go\go_global\bin'
  if (g:g_nvim_flg == 0)
    let &pythonthreehome = 'D:\Tools\WorkTool\Python\python-3.8.10-embed-win32'
    let &pythonthreedll = 'D:\Tools\WorkTool\Python\python-3.8.10-embed-win32\python38.dll'
  endif
  "设定内置终端专用shell
  let g:terminal_shell='cmd.exe /k D:/Tools/WorkTool/Cmd/cmdautorun.cmd'
elseif (g:g_i_osflg==3)
  let g:terminal_shell='/usr/bin/bash -l -i'
else
  let g:terminal_shell='/bin/bash --rcfile /lch/workspace/bashrc/.bashrc-personal'
endif
"全局变量g:g_i_colorflg（1：256暗色系，2：256亮色系，3：16色系）
let g:g_i_colorflg = 1
"全局变量g:g_s_rcfilepath（当前vimrc所在路径）
let g_s_rcfilepath = expand("<sfile>:p:h")
"判断工程跟路径关键字
let g:g_s_rootmarkers = ['.git', '.svn', '.project', '.root', '.hg']
"在packpath,runtimepath最后添加个人设定的路径，用以载入插件等
if (v:version > 799)
  exec "set packpath+=" . g:g_s_rcfilepath . '/vimconf'
endif
exec "set runtimepath+=" . g:g_s_rcfilepath . '/vimconf'
"在runtimepath最后添加个人设定的后路径(after directory)，用以载入高亮的定制
if (v:version > 799)
  exec "set packpath+=" . g:g_s_rcfilepath . '/vimconf/after'
endif
exec "set runtimepath+=" . g:g_s_rcfilepath . '/vimconf/after'

"-----------------------------------------------"
"               开始设置                        "
"-----------------------------------------------"
filetype off                             " 关闭文件类型检测，因为在这里开启之后，下面的[augroup filetypedetect]不会生效
filetype plugin indent off
filetype plugin off                      " 关闭加载对应文件类型的插件

"-----------------------------------------------"
"               基础设置                        "
"-----------------------------------------------"
let &t_ut=''                             " 调整终端和vim颜色
set modelines=0                          " 禁用模式行（安全措施）
syntax enable                            " 开启语法高亮
syntax on                                " 自动语法高亮
"colorscheme desert                       " 设置颜色主题
set encoding=utf-8                       " 编码设置
set fileencoding=utf-8                   " 编码设置
set fileencodings=utf-8,ucs-bom,shift-jis,cp932,euc-jp,gb18030,gbk,gb2312,cp936,utf-16,big5,latin1
                                         " 自动识别文件编码，依照fileencodings提供的编码列表尝试
set termencoding=utf-8                   " 终端编码设置
set number                               " 显示行号
set ruler                                " 显示光标所在位置的行号和列号，在右下角显示光标位置
set nowrap                               " 不自动折行
set mouse=a                              " 使用鼠标
set mousehide                            " 输入时隐藏光标
set clipboard^=unnamed,unnamedplus       " 和系统共享剪切板
set nobackup                             " 不需要备份文件
set noswapfile                           " 不创建临时交换文件
set nowritebackup                        " 编辑的时候不需要备份文件
set autoread                             " 文件自动检测外部更改
set confirm                              " 在处理未保存或只读文件的时候，弹出确认
set showmatch                            " 显示匹配,当输入一个左括号时会匹配相应的那个右括号
set matchtime=1                          " 显示括号时间，1秒
set splitbelow                           " 设置水平分割窗口时，新窗口出现在底部
set splitright                           " 设置左右分割窗口时，新窗口出现在右侧
set laststatus=2                         " 显示状态行 2: 总是
set cursorline                           " 高亮显示当前行
set whichwrap+=<,>,h,l,[,]               " 设置光标键跨行
set hlsearch                             " 搜索时高亮显示被找到的文本
set incsearch                            " 搜索时在未完全输入完毕要检索的文本时就开始检索
set ignorecase                           " 搜索时忽略大小写
set smartcase                            " 智能搜索 - 搜索“test”会找到并突出显示 test 和 Test。搜索“Test”只突出显示或只找到 Test
set ambiwidth=double                     " 防止特殊符号无法正常显示。解决中文标点显示的问题
set sidescroll=10                        " 移动到看不见的字符时，自动向右滚动是个字符
set nofoldenable                         " 禁用折叠代码
set novisualbell                         " 不要闪烁
set showcmd                              " 显示输入的命令
set showtabline=2                        " 显示tab栏 2: 永远会
set ttyfast                              " 快速刷新屏幕显示
set lazyredraw                           " 只在必要时刷新显示
set nowrapscan                           " 禁止在搜索到文件两端时重新搜索（不循环搜索）
set showmode                             " 左下角显示如“—INSERT--”之类的状态栏
set scrolloff=4                          " 垂直滚动时，光标保持在距顶部/底部 4 行的位置
set sidescrolloff=8                      " 左右滚动时，光标保持在距左/右 8 列的位置
set sidescroll=1                         " 左右滚动时，1个字符1个字符滚动
set autochdir                            " 自动切换工作目录
set wildmenu                             " vim自身命名行模式智能补全
set showfulltag                          " 补全时，使用整行补全
set wildoptions=tagfile                  " 开启tagfile的补全
if (v:version > 799)
  set completeopt=menu,menuone,noselect  " 补全时，不要自动选中第一个选项。
else
  set completeopt=menu,menuone           " 补全时，不要自动选中第一个选项。
endif
set shortmess+=c                         " 设置补全静默
set cpt=.,k,w,b                          " 设定从字典文件以及当前打开的文件里收集补全单词
set omnifunc=syntaxcomplete#Complete     " 设置全能补全
set ttimeout                             " 让按 Esc 的生效更快速。通常 Vim 要等待一秒来看看 Esc 是否是转义序列的开始。如果你使用很慢的远程连接，增加此数值
set ttimeoutlen=0                        " 设置<ESC>键响应时间
set pumheight=15                         " 设定弹出菜单的大小为15
set formatoptions+=m                     " UniCode大于255的文本，不必等到空格再这行
set formatoptions+=B                     " 合并两行中文时，不在中间加空格
set t_Co=256                             " 开启256色支持
set hidden                               " 设置允许在未保存状态切换buffer
set matchpairs+=<:>                      " 设置%匹配<>
set shellslash                           " 使用/，不使用windows的\（在用netrw . 打开文件夹的时候特别有用）
"set switchbuf+=newtab                    " QuickFix的条目将在单独的选项卡页面中打开
if (has("termguicolors"))
  "从7.4.1830开始支持启用终端真彩色，可以让终端环境的Vim使用GUI的颜色定义，需要终端环境和环境内的组件（比如 tmux）都支持真彩色
  set termguicolors
endif
"set relativenumber                       " 显示相对行号
"set wrap                                 " 自动折行
"set cursorcolumn                         " 高亮显示当前列
"set fdm=marker                           " 设置折叠方式
"set virtualedit=all                      " 允许光标放到当前行末尾之后

"-----------------------------------------------"
"               缩进和排版                      "
"-----------------------------------------------"
set tabstop=4                            " tab为4个空格
set shiftwidth=4                         " 每一级缩进是4个空格
set noexpandtab                          " 不将tab替换为相应数量空格         打开为set expandtab
set softtabstop=4                        " 在编辑模式下按退格键的时候退回缩进的长度，配合expandtab时很有用
set smarttab                             " 在行和段开始处使用制表符
"set smartindent                          " 智能缩进对齐（和autoindent开启一项即可，看个人喜好）
"set cinwords=if,elif,else,else\ if,try,except,catch,finally,with,for,while,class,def
set autoindent                           " 自动缩进
filetype indent on                       " 自适应不同语言的智能缩进
set cindent                              " 设置使用C/C++语言的自动缩进方式
set cinoptions=g0,:0,N-s,(0              " 设置C/C++语言的具体缩进方式
set backspace=2                          " 设置 backspace可以删除任意字符，数值2同set backspace=indent,eol,start
set previewheight=100                    " 设置preview窗口高度

"-----------------------------------------------"
"               光标设置                        "
"-----------------------------------------------"
"在普通模式下用块状光标，在插入模式下用条状光标（形状类似英文 "I" 的样子），然后在替换模式中使用下划线形状的光标。
"t_SI：插入模式开始，t_EI：插入或者替换模式结束，t_SR：替换模式开始
if (g:g_i_osflg == 1 || g:g_i_osflg == 2)
  " Gvim 环境：在[.gvimrc]中设定
elseif(g:g_i_osflg==3)
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

"-----------------------------------------------"
"               工程跟路径函数定义              "
"               使用s:project_root()函数取得    "
"-----------------------------------------------"
function! GetProjectRoot()
  let name = expand('%:p')
  return s:find_root(name, g:g_s_rootmarkers, 0)
endfunc
function! s:find_root(name, markers, strict)
  let name = fnamemodify((a:name != '')? a:name : bufname('%'), ':p')
  let finding = ''
  " iterate all markers
  for marker in a:markers
    if marker != ''
      " search as a file
      let x = findfile(marker, name . '/;')
      let x = (x == '')? '' : fnamemodify(x, ':p:h')
      " search as a directory
      let y = finddir(marker, name . '/;')
      let y = (y == '')? '' : fnamemodify(y, ':p:h:h')
      " which one is the nearest directory ?
      let z = (strchars(x) > strchars(y))? x : y
      " keep the nearest one in finding
      let finding = (strchars(z) > strchars(finding))? z : finding
    endif
  endfor
  if finding == ''
    let path = (a:strict == 0)? fnamemodify(name, ':h') : ''
  else
    let path = fnamemodify(finding, ':p')
  endif
  if has('win32') || has('win16') || has('win64') || has('win95')
    let path = substitute(path, '\/', '\', 'g')
  endif
  if path =~ '[\/\\]$'
    let path = fnamemodify(path, ':h')
  endif
  return path
endfunc
" 使用GetProjectRoot()函数找到跟目录
let g:g_s_projectrootpath = GetProjectRoot()

"-----------------------------------------------"
"               特殊符号设置                    "
"-----------------------------------------------"
set list
" 把tab设置为对齐线样式 | ¦ ┆ │ ⎸ ▏
set listchars=tab:¦\ ,precedes:<,extends:>
"set listchars=tab:\|\ ,precedes:<,extends:>
"set listchars=tab:^\ ,precedes:<,extends:>
"set listchars=tab:^\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:↲

"-----------------------------------------------"
"               文件关联                        "
"-----------------------------------------------"
"在 vimconf/ftdetect 文件夹设置
"augroup filetypedetect
"  autocmd! BufRead,BufNewFile *.cc     setfiletype c
"  autocmd! BufRead,BufNewFile *.pc     setfiletype esqlc
"augroup END

"-----------------------------------------------"
"               状态栏设置                      "
"-----------------------------------------------"
" 设置仿照lightline
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
  let l:lspMsg = 'LSP:'
  if exists('*GetLspStatus')
    let l:lspMsg .= GetLspStatus()
  else
    let l:lspMsg .= '❌'
  endif
  let l:resultStr = ''                              " 初始化
  let l:resultStr .= '%1* ' . showMode . ' '        " 显示当前编辑模式，高亮为用户组1
  let l:resultStr .= '%2* %F'                       " 显示当前文件，高亮为用户组2 (%f 相对文件路径, %F 绝对文件路径, %t 文件名)
  let l:resultStr .= '%3* %m%r%h%w %*%='            " 显示当前文件标记(mrhw)，高亮为用户组3，之后用=开始右对齐
  let l:resultStr .= '%4* ' . lspMsg . ' '          " 显示LSP状态，高亮为用户组4
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
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=226 gui=bold guifg=#000010 guibg=#ffff00
    elseif (currentMode == 'n')            "普通模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=45 gui=bold guifg=#000010 guibg=#00d7ff
    elseif (currentMode == 'v' || currentMode == 'V' || currentMode == "\<C-v>" || currentMode == "\<C-vs>")      "可视模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=48 gui=bold guifg=#000010 guibg=#00ff87
    elseif (currentMode == 'R')            "替换模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=231 ctermbg=160 gui=bold guifg=#ffffff guibg=#d70000
    elseif (currentMode == 'c' || currentMode == '!')       "命令模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=231 ctermbg=201 gui=bold guifg=#ffffff guibg=#ff00ff
    elseif (currentMode == 's' || currentMode == 'S' || currentMode == "\<C-s>")      "选择模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=178 gui=bold guifg=#000010 guibg=#d7af00
    elseif (currentMode == 't')            "终端模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=231 ctermbg=31 gui=bold guifg=#ffffff guibg=#2472c8
    elseif (currentMode == 'r')            "确认模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=177 gui=bold guifg=#000010 guibg=#d787ff
    else            "默认普通模式配色
      hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=45 gui=bold guifg=#000010 guibg=#00d7ff
    endif
  elseif a:pmode == 'InsertEnter'
    hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=226 gui=bold guifg=#000010 guibg=#ffff00
  elseif a:pmode == 'InsertLeave'
    hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=45 gui=bold guifg=#000010 guibg=#00d7ff
  endif
endfunction

" 添加模式变换时的自动命令
augroup lchModeChangedGroup
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

"当前编辑模式
hi User1        term=bold,reverse cterm=bold ctermfg=16 ctermbg=45 gui=bold guifg=#000010 guibg=#00d7ff
"文件名
hi User2        term=none cterm=none ctermfg=231 ctermbg=59 gui=none guifg=#ffffff guibg=#606060
"文件编辑状态
hi User3        term=none cterm=none ctermfg=226 ctermbg=59 gui=none guifg=#ffff00 guibg=#606060
"LSP服务器状态
hi User4        term=none cterm=none ctermfg=231 ctermbg=236 gui=none guifg=#ffffff guibg=#2c323c

"-----------------------------------------------"
"               TAB设置                         "
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
"               netrw设置                       "
"-----------------------------------------------"
if (g:g_nvim_flg == 0)

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
  let g:netrw_winsize = 83       " 指定 "o"、"v"、:Hexplore 或 :Vexplore 建立的新窗口的初始大小。整数百分比，来设定新窗口的大小。
  "let g:netrw_list_hide= '^\..*' " 不显示隐藏文件 用 a 键就可以显示所有文件、 隐藏匹配文件或只显示匹配文件
  let g:netrw_keepdir = 0        " 用tree打开的路径作为当前路径，在这个路径下默认操作
  let g:netrw_sort_options = "i"   "忽略排序大小写
  "let g:netrw_special_syntax = 1  "高亮特定文件名

  " 自动打开netrw
  "augroup ProjectDrawerGroup
  "  autocmd!
  "  autocmd VimEnter * :Vexplore
  "augroup END

else

  "neovim的时候禁用netrw
  let g:load_netrw = 1
  let g:loaded_netrwPlugin = 1

endif

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
exec 'source ' . g:g_s_rcfilepath . '/vimconf/colors/lch-dark.vim'

"-----------------------------------------------"
"               快捷键绑定                      "
"               F1：ctrlp-funky                 "
"               F2：lsp-重命名                  "
"               F3：不切换窗口的前提下，滚动另一个窗口"
"               F4：不切换窗口的前提下，滚动另一个窗口"
"               F5：dap-开始调试                "
"               F6：dap-添加断点                "
"               F7：dap-下一步                  "
"               F8：dap-运行到光标处初始化工程文件夹"
"               F9：编译                        "
"               F10：运行                       "
"               F11：测试                       "
"               F12：格式化                     "
"               命令 :Maketag 生成tags          "
"               命令 :Init 初始化工程文件夹     "
"-----------------------------------------------"
exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/keybindings.vim'

"-----------------------------------------------"
"               终端设置                        "
"               \+a：打开/关闭终端           "
"-----------------------------------------------"
exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/terminal.vim'

"-----------------------------------------------"
"               构筑设置                        "
"               F9：编译                        "
"               F10：运行                       "
"               F11：测试                       "
"               F12：初始化工程文件夹           "
"-----------------------------------------------"
exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/buildtask.vim'

"-----------------------------------------------"
"               格式化设置                      "
"               F9：格式化从修改前的位置到修改后的位置"
"               F10：格式化当前文件             "
"-----------------------------------------------"
exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/format.vim'

"-----------------------------------------------"
"               自定义代码段（snippets）设置    "
"               全部以^开头                     "
"-----------------------------------------------"
exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/snippets.vim'

"-----------------------------------------------"
"               文件搜索设置                    "
"               QuickFix设置                    "
"               \+z：打开/关闭QuickFix          "
"-----------------------------------------------"
" 在工程跟路径下递归查找子文件
"set path+=**
exec "set path+=" . g:g_s_projectrootpath . "/**"
set wildignore=*.o,*.obj,*.dll,*.exe,*.bin,*.so*,*.a,*.out,*.jar,*.pak,*.class,*.zip,*gz,*.xz,*.bz2,*.7z,*.lha,*.deb,*.rpm,*.pdf,*.png,*.jpg,*.gif,*.bmp,*.doc*,*.xls*,*.ppt*,tags,.tags,.project,.root,.hg,.gitignore,.gitattributes,.git/**,.svn/**,.settings/**,.vscode/**          " 搜索除外内容

augroup lchQuickFixGroup
  autocmd!
  "autocmd QuickFixCmdPost *vim* cwindow
  " 使用vim[grep]的结果在QuickFix里面打开
  autocmd QuickFixCmdPost *vim* copen 20
  " 使用make的结果在QuickFix里面打开
  autocmd QuickFixCmdPost *make* copen 20
augroup END

"-----------------------------------------------"
"               特别语言设置                    "
"-----------------------------------------------"
"C语言高亮设定
"关闭注释中的其他高亮
if exists("c_comment_strings")
  unlet c_comment_strings
endif
"高亮行尾空格和TAB之间的空格
let c_space_errors = 1
"开始GNU gcc高亮
let c_gnu = 1

"Java语言高亮设定
let java_highlight_all = 1
"let java_highlight_functions = "style"
let java_highlight_debug = 1
let java_ignore_javadoc = 1

"Python语言高亮设定
let python_highlight_all = 1
"是否启用ftplugin/python.vim中的PEP8标准（启用设定修改值为1）
let g:python_recommended_style = 1

"Rust语言高亮
"是否启用ftplugin/rust.vim中的tab设定（启用设定修改值为1）
let g:rust_recommended_style = 1

"Go语言高亮设定
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

"html高亮设定
let java_javascript = 1
let java_css = 1
let java_vb = 1

"Shell高亮设定
let g:is_bash = 1
let g:is_posix = 1

"-----------------------------------------------"
"               插件设置                        "
"-----------------------------------------------"
if (v:version > 799)

  "加载自带的matchit
  packadd matchit

  if (g:g_use_lsp == 0)
    "不使用LSP

    "vim-auto-popmenu（自动补全）
    "https://github.com/skywind3000/vim-auto-popmenu
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/apc.vim'
    " 设定需要生效的文件类型，如果是 "*" 的话，代表所有类型
    let g:apc_enable_ft = {'*':1}
    "let g:apc_enable_tab = 0

    "vim-dict（自动补全词典）
    "https://github.com/skywind3000/vim-dict
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/vim_dict.vim'
    " 设定词典路径和匹配方式
    let s:vim_dict_path = g:g_s_rcfilepath . '/vimconf/dict'
    let g:vim_dict_dict = [s:vim_dict_path, '',]
    let g:vim_dict_config = {'html':'html,javascript,css', 'markdown':'text'}

  else
    "使用LSP

    if (g:g_lsp_type == 0)
      "加载LSP设置（vim-lsp）
      exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/lsp.vim'
    elseif (g:g_lsp_type == 1)
      "加载LSP设置（vim-lsc）
      exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/lsc.vim'
    elseif (g:g_lsp_type == 2)
      "加载LSP设置（LanguageClient-neovim）
      exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/languageclient.vim'
    endif

  endif

  if (g:g_use_dap == 0)
    "不使用DAP
  else
    "使用DAP
    "加载DAP设置
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/dap.vim'
  endif

  "vim-startify（启动页导航）
  "https://github.com/mhinz/vim-startify
  packadd vim-startify
  "设置显示列表
  let g:startify_lists = [
    "\    { 'type': 'files',     'header': ['   MRU']            },
    "\    { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
    "\    { 'type': 'sessions',  'header': ['   Sessions']       },
    \    { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    "\    { 'type': 'commands',  'header': ['   Commands']       },
    \]
  "设置工程书签
  let g:startify_bookmarks = [
    \    'D:/WorkSpace/C/CSampleProject',
    \    'D:/WorkSpace/Java/JavaBatchProject',
    \    'D:/WorkSpace/Java/JavaMavenBatProject',
    \    'D:/WorkSpace/Python/PythonSampleProject',
    \    'D:/WorkSpace/Rust/minigrep',
    \    'D:/WorkSpace/Go/GoSampleProject',
    \    'D:/WorkSpace/Vue/VueTestProject',
    \    'D:/WorkSpace/Dotnet/DotnetSampleProject',
    \    'D:/WorkSpace/Test/LanguagTest',
  \]
  "起始页显示的列表长度
  let g:startify_files_number = 20
  "自动加载session
  "let g:startify_session_autoload = 1
  "过滤列表，支持正则表达式
  "let g:startify_skiplist = [
  "  \    '^/tmp',
  "\]
  "自定义Header和Footer
  let g:startify_custom_header = [
    \ ' ⠀⠀⠀⠀⠀⠀⢀⣀⡠⠤⠤⠴⠶⠶⠶⠶⠦⠤⠤⢄⣀⡀⠀⠀⠀⠀⠀⠀⠀',
    \ ' ⠀⠀⠀⣠⠖⢛⣩⣤⠂⠀⠀⠀⣶⡀⢀⣶⠀⠀⠀⠐⣤⣍⡛⠲⣄⠀⠀⠀⠀',
    \ ' ⢀⡴⢋⣴⣾⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣷⣦⡙⢦⡀⠀',
    \ ' ⡞⢠⣿⣿⣿⣿⣿⣿⣷⣤⣤⣴⣿⣿⣿⣿⣦⣤⣤⣾⣿⣿⣿⣿⣿⣿⡆⢳⠀',
    \ ' ⡁⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢈⠆',
    \ ' ⢧⡈⢿⣿⣿⣿⠿⠿⣿⡿⠿⠿⣿⣿⣿⣿⠿⠿⢿⣿⠿⠿⣿⣿⣿⡿⢁⡼⠀',
    \ ' ⠀⠳⢄⡙⠿⣇⠀⠀⠈⠁⠀⠀⠈⢿⡿⠁⠀⠀⠈⠁⠀⠀⣸⠿⢋⡠⠞⠀⠀',
    \ ' ⠀⠀⠀⠉⠲⢤⣀⡀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⢀⣀⡤⠖⠉⠀⠀⠀⠀',
    \ ' ⠀⠀⠀⠀⠀⠀⠈⠉⠉⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀',
  \]
  "let g:startify_custom_footer = [
  "  \ '+------------------------------+',
  "  \ '| Do one thing and do it well. |',
  "  \ '+------------------------------+',
  "\]
  "按下Ctrl+F1表示启动页导航
  noremap <C-F1> :Startify<CR>

  "indentLine（缩进参考线）
  "https://github.com/Yggdroot/indentLine
  "https://github.com/preservim/vim-indent-guides
  packadd indentLine
  let g:indentLine_defaultGroup = 'SpecialKey'
  "let g:indentLine_char_list = ['|', '¦', '┆', '┊']
  let g:indentLine_char_list = ['¦']
  "let g:indentLine_enabled = 1
  let g:indentLine_enabled = 0
  let g:vim_json_conceal = 0
  let g:markdown_syntax_conceal = 0

  "ctrlp（模糊查找）
  "https://github.com/ctrlpvim/ctrlp.vim
  packadd ctrlp
  let g:ctrlp_root_markers = ['.git', '.svn', '.project', '.root', '.hg']

  "ctrlp-funky（查看outline，因为依赖少所以平替掉tagbar）
  "https://github.com/tacahiroy/ctrlp-funky
  packadd ctrlp-funky
  let g:ctrlp_funky_matchtype = 'path'
  let g:ctrlp_funky_syntax_highlight = 1
  noremap <F1> :CtrlPFunky<CR>

  "tagbar（用tags表示代码大纲）
  "https://github.com/preservim/tagbar
  "packadd tagbar
  "按下F1表示
  "noremap <F1> :TagbarToggle<CR>

  "vim-mark（高亮选中单词）
  "https://github.com/Yggdroot/vim-mark

  "nerdtree（资源管理器）
  "https://github.com/preservim/nerdtree
  "packadd nerdtree

  "vim-snipmate（语法片段snippets）
  "garbas/vim-snipmate是VimL写的，SirVer/ultisnips需要Python
  "https://github.com/garbas/vim-snipmate
  "https://github.com/SirVer/ultisnips
  "片段仓库 https://github.com/honza/vim-snippets
  "packadd tlib
  "packadd vim-addon-mw-utils
  "packadd vim-snipmate
  "if has("python3")
    "packadd ultisnips
    "let g:UltiSnipsExpandTrigger="<tab>"
    "let g:UltiSnipsJumpForwardTrigger="<c-b>"
    "let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    "let g:UltiSnipsSnippetsDir=g:g_s_rcfilepath . '/vimconf/snippets'
  "endif

endif

"-----------------------------------------------"
"               结束设置                        "
"-----------------------------------------------"
filetype on                              " 开启文件类型检测
filetype plugin indent on
filetype plugin on                       " 设置加载对应文件类型的插件
