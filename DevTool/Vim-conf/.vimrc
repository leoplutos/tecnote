scriptencoding utf-8
".vimrc

" When started as "evim", evim.vim will already have done these settings, bail out.
if v:progname =~? "evim"
  finish
endif

set nocompatible                         " 去除vi一致性

" NeoVim判断
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
"全局变量g:g_use_lsp（0：不使用lsp，1：使用lsp）
if !exists('g:g_use_lsp')
  let g:g_use_lsp = 0
endif
"全局变量g:g_lsp_type（0：vim-lsp，1：vim-lsc，2：LanguageClient-neovim）
if !exists('g:g_lsp_type')
  let g:g_lsp_type = 0
endif
"全局变量g:g_python_lsp_type（0：pylsp，1：jedi-language-server，2：anakin-language-server, 3:pyright-langserver）
if !exists('g:g_python_lsp_type')
  let g:g_python_lsp_type = 3
endif
"全局变量g:g_use_dap（0：不使用dap，1：使用dap）
if !exists('g:g_use_dap')
  let g:g_use_dap = 0
endif
"全局变量g:g_use_nerdfont（0：不使用nerdfont，1：使用nerdfont）
if !exists('g:g_use_nerdfont')
  let g:g_use_nerdfont = 0
endif
if (g:g_use_lsp == 1)
  let g:g_use_nerdfont = 1
endif
"全局变量g:g_space_tab_flg（0：使用空格，1：使用TAB）
if !exists('g:g_space_tab_flg')
  let g:g_space_tab_flg = 0
endif
"全局变量g:g_i_osflg（1：Windows-Gvim，2：Windows-控制台，3：Windows-MSys2/Cygwin/Mingw，4：MacOS，5：Linux/WSL）
if(has('win32') || has('win95') || has('win64') || has('win16'))
  if has('gui_running')
    let g:g_i_osflg=1
  else
    let g:g_i_osflg=2
  endif
elseif has('win32unix')
  let g:g_i_osflg=3
elseif has('macunix')
  let g:g_i_osflg=4
else
  let g:g_i_osflg=5
endif
if (g:g_i_osflg == 1 || g:g_i_osflg == 2)
  "Windows系统下加入GCC,Java,Python,Ctags,clang-format,black等环境变量
  let $CARGO_HOME = 'D:\Tools\WorkTool\Rust\Rust_gnu_1.70'
  let $RUSTUP_HOME = 'D:\Tools\WorkTool\Rust\Rust_gnu_1.70'
  let $GOROOT = 'D:\Tools\WorkTool\Go\go1.21.1.windows-amd64'
  let $GOPATH = 'D:\Tools\WorkTool\Go\go_global'
  let $JAVA_HOME = 'D:\Tools\WorkTool\Java\jdk17.0.6'
  let $KOTLIN_HOME = 'D:\Tools\WorkTool\Kotlin\kotlin-compiler-1.9.10'
  let $PATH .= ';D:\Tools\WorkTool\Search\ripgrep\bin'
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
  let $PATH .= ';D:\Tools\WorkTool\Go\go1.21.1.windows-amd64\bin'
  let $PATH .= ';D:\Tools\WorkTool\Go\go_global\bin'
  let $PATH .= ';D:\Tools\WorkTool\DotNet\omnisharp-win-x64'
  let $PATH .= ';D:\Tools\WorkTool\Kotlin\kotlin-compiler-1.9.10\bin'
  let $PATH .= ';D:\Tools\WorkTool\Kotlin\lsp\server\bin'
  let $PATH .= ';D:\Tools\WorkTool\Lua\lsp\lua-language-server-3.7.0-win32-x64\bin'
  let $PATH .= ';D:\Tools\WorkTool\Team\Git\cmd'
  let $PATH .= ';D:\Tools\WorkTool\Team\gitui-win'
  let $PATH .= ';D:\Tools\WorkTool\Team\Lazygit'
  let $PATH .= ';D:\Tools\WorkTool\Java\apache-maven-3.9.4\bin'
  if (g:g_nvim_flg == 0)
    let &pythonthreehome = 'D:\Tools\WorkTool\Python\python-3.8.10-embed-win32'
    let &pythonthreedll = 'D:\Tools\WorkTool\Python\python-3.8.10-embed-win32\python38.dll'
  endif
  "设定内置终端专用shell
  let g:terminal_shell='cmd.exe /k D:/Tools/WorkTool/Cmd/cmdautorun.cmd'
elseif (g:g_i_osflg==3)
  let g:terminal_shell='/usr/bin/bash -l -i'
  "set viminfo='100,n$HOME/.vim/files/info/viminfo
elseif (g:g_i_osflg==4)
else
  let $PATH .= ':~/.local/bin'
  let $PATH .= ':/home/lchuser/work/lch/tool/lsp/kotlin-language-server/bin'
  "设定下划波浪线
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
  "设定支持下划波浪线颜色
  let &t_AU = "\<esc>[58;5;%dm"
  let &t_8u = "\<esc>[58;2;%lu;%lu;%lum"
  let g:terminal_shell='/bin/bash --rcfile ~/work/lch/rc/bashrc/.bashrc-personal'
endif
"全局变量g:g_s_rcfilepath（当前vimrc所在路径）
let g:g_s_rcfilepath = expand("<sfile>:p:h")
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
"加载NerdFonts图标设定
exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/nerdfont.vim'
"工程根路径
let g:g_s_projectrootpath = ''

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
"set notimeout
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
if (g:g_space_tab_flg == 0)
  "使用空格，将tab替换为相应数量空格
  set expandtab
else
  "使用TAB，不将tab替换为相应数量空格
  set noexpandtab
endif
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
"  autocmd!
"  autocmd! BufRead,BufNewFile *.cc     setfiletype c
"  autocmd! BufRead,BufNewFile *.pc     setfiletype esqlc
"augroup END

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
exec 'source ' . g:g_s_rcfilepath . '/vimconf/colors/lch-dark.vim'
"exec 'source ' . g:g_s_rcfilepath . '/vimconf/colors/lch-light.vim'

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
"         Statusline和Buffer设置                "
"-----------------------------------------------"
if (g:g_use_lsp == 0) && (g:g_use_dap == 0) && (g:g_nvim_flg == 0)
  "不启用lsp/dsp并且不是NeoVim 时才加载
  exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/statusbar_pure.vim'
endif

"-----------------------------------------------"
"               终端设置                        "
"               \+a：打开/关闭终端              "
"-----------------------------------------------"
if (g:g_nvim_flg == 0)
  "只有vim加载terminal.vim，NeoVim使用toggleterm.nvim
  exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/terminal.vim'
endif

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
if (g:g_use_lsp == 0) && (g:g_use_dap == 0) && (g:g_nvim_flg == 0)
  "不启用lsp/dsp并且不是NeoVim 时才加载
  exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/snippets.vim'
endif

"-----------------------------------------------"
"               文件搜索设置                    "
"               QuickFix设置                    "
"               \+z：打开/关闭QuickFix          "
"-----------------------------------------------"
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

"Cobol高亮设定
let g:cobol_inline_comment = 1

"-----------------------------------------------"
"               文件树设置                      "
"-----------------------------------------------"
if (g:g_nvim_flg == 0)
  "不是NeoVim

  if (g:g_use_lsp == 0 && g:g_use_dap == 0)
    "不加载lsp和dap：使用netrw

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

    " 进入netrw的自动命令设置
    augroup lchtNetrwGroup
      autocmd!
      autocmd FileType netrw call <SID>NetrwBufEnter()
      "autocmd FileType netrw au BufEnter <buffer> call <SID>NetrwBufEnter()
      "autocmd FileType netrw au BufLeave <buffer> hi clear CursorLine
    augroup END

  else
    "加载lsp或dap：使用nerdtree（init/tree.vim）

    "禁用netrw
    let g:load_netrw = 1
    let g:loaded_netrwPlugin = 1

    exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/tree.vim'

  endif

else
  "NeoVim：在NeoVim设定中定义（lua/tree.lua）

    "禁用netrw
    let g:load_netrw = 1
    let g:loaded_netrwPlugin = 1

endif

"进入netrw时候运行的内容
"因为使用了vim-startify（启动页导航）插件，所以需要进入每个netrw的时候刷新设置
function! s:NetrwBufEnter()

  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()

  " 在工程跟路径下递归查找子文件
  "set path+=**
  exec 'set path='
  exec 'set path+=' . g:g_s_projectrootpath . '/**'
  " 搜索除外内容
  set wildignore=*.o,*.obj,*.dll,*.exe,*.bin,*.so*,*.a,*.out,*.jar,*.pak,*.class,*.zip,*gz,*.xz,*.bz2,*.7z,*.lha,*.deb,*.rpm,*.pdf,*.png,*.jpg,*.gif,*.bmp,*.doc*,*.xls*,*.ppt*,tags,.tags,.hg,.gitignore,.gitattributes,.git/**,.svn/**,.settings/**,.vscode/**

  " 设定环境变量
  let $PYTHONPATH = ''
  let $PYTHONPATH .= g:g_s_projectrootpath
  let $PYTHONPATH .= ';'.g:g_s_projectrootpath.'\src'
  let $PYTHONPATH .= ';'.g:g_s_projectrootpath.'\src\com'

endfunction

"-----------------------------------------------"
"               插件设置                        "
" vim（最小插件依赖）：g:g_use_lsp == 0 && g:g_use_dap == 0"
" viml（只开启lsp）：g:g_use_lsp == 1 && g:g_use_dap == 0"
" vimd（只开启dap）：g:g_use_lsp == 0 && g:g_use_dap == 1"
" vimf（加载所有）：g:g_use_lsp == 1 && g:g_use_dap == 1"
"-----------------------------------------------"
if (v:version > 799)
  "版本大于8的通用插件加载（Vim + NeoVim）

  "加载自带的matchit
  packadd matchit

  "加载开始导航页面设置
  exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/startmenu.vim'

  if (g:g_use_dap == 1)
    "加载DAP设置
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/dap.vim'
  endif

endif

if (v:version > 799) && (g:g_nvim_flg == 0)
  "版本大于8并且不是NeoVim的插件加载（NeoVim在init.lua下加载）

  "indentLine（缩进参考线）
  "https://github.com/Yggdroot/indentLine
  packadd indentLine
  let g:indentLine_defaultGroup = 'SpecialKey'
  "let g:indentLine_char_list = ['|', '¦', '┆', '┊']
  let g:indentLine_char_list = ['|']
  "禁用类型
  let g:indentLine_fileTypeExclude = ['text', 'cobol']
  "禁用buffer
  let g:indentLine_bufTypeExclude = ['help', 'terminal']
  let g:indentLine_bufNameExclude = ['NERD_tree.*']
  if (g:g_space_tab_flg == 0)
    "使用空格
    let g:indentLine_enabled = 1
  else
    "使用TAB
    let g:indentLine_enabled = 0
  endif
  let g:vim_json_conceal = 0
  let g:markdown_syntax_conceal = 0

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
    let g:vim_dict_config = {'css':'css,css3', 'html':'html,javascript,css,css3', 'markdown':'text'}

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

    "加载文件模糊查找（LeaderF）
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/finder.vim'

    "加载状态栏和Buffer插件（lightline.vim + lightline-bufferline）
    exec 'source ' . g:g_s_rcfilepath . '/vimconf/init/statusbar_lightline.vim'

    "需要最后加载图标
    "https://github.com/ryanoasis/vim-devicons
    set updatetime=100
    let g:webdevicons_enable_nerdtree = 1
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:DevIconsEnableFoldersOpenClose = 1
    packadd vim-devicons

  endif

  "tagbar（用tags表示代码大纲）
  "https://github.com/preservim/tagbar
  "packadd tagbar
  "按下F1表示
  "noremap <F1> :TagbarToggle<CR>

endif

"-----------------------------------------------"
"               结束设置                        "
"-----------------------------------------------"
filetype on                              " 开启文件类型检测
filetype plugin indent on
filetype plugin on                       " 设置加载对应文件类型的插件
