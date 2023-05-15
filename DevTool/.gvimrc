scriptencoding utf-8
".gvimrc

"-----------------------------------------------"
"               语言设置                        "
"-----------------------------------------------"
let $LANG = 'zh_CN.utf8'                  " 消息语言中文
set langmenu=zh_CN.UTF-8                  " 菜单语言中文
"let $LANG = 'en_US.utf8'                  " 消息语言英文
"set langmenu=en_US.UTF-8                  " 菜单语言英文
"let $LANG = 'ja_JP.utf8'                  " 消息语言日文
"set langmenu=ja_JP.UTF-8                  " 菜单语言日文
lang message zh_CN.UTF-8
set helplang=cn                           " 设置帮助文档语言
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"-----------------------------------------------"
"               GUI设置                         "
"-----------------------------------------------"
filetype indent plugin on
" 设置字体、字号
set guifont=SourceHanHWSC-Hybird-liga:h14,Inconsolata:h14:cANSI,JetBrains_Mono:h14:cANSI
"set guifontwide=Microsoft_YaHei_UI:h14:cGB2312,MS\ Gothic:h14:cms932
set lines=35 columns=148                  " 窗口大小
"colorscheme Tomorrow-Night                " 设置主题
"colorscheme delek
"set guioptions-=T                        " 不显示工具栏
"set guioptions-=m
"set guioptions-=l                        " 不显示滚动条
"set guioptions-=r
"set guioptions-=b
"set guioptions-=e                        " 使用默认的tab样式，而不是系统的tab
"set winaltkeys=no                        " 设置 alt 键不映射到菜单栏

" vim 文件折叠方式为 marker
augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker
augroup END

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
let scriptPath = expand("<sfile>:p:h")
"exec 'source' scriptPath . '/vim-color-256-rc.vim'
exec 'source' scriptPath . '/vim-color-256-rc-light.vim'
