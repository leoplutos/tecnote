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
" 设置字体、字号
set guifont=Inconsolata:h14:cANSI:qDRAFT,JetBrains_Mono:h14:cANSI:qDRAFT
"set guifontwide=ＭＳ_ゴシック:h14:cSHIFTJIS:qDRAFT,MS_Gothic:h14:cSHIFTJIS:qDRAFT,Microsoft_YaHei:h14:cGB2312:qDRAFT,Microsoft_YaHei_UI:h14:cGB2312:qDRAFT,SimSun:h14:cGB2312:qDRAFT,新宋体:h14:cGB2312:qDRAFT
set guifontwide=Microsoft_YaHei:h14:cGB2312:qDRAFT,Microsoft_YaHei_UI:h14:cGB2312:qDRAFT,SimSun:h14:cGB2312:qDRAFT,新宋体:h14:cGB2312:qDRAFT,ＭＳ_ゴシック:h14:cSHIFTJIS:qDRAFT,MS_Gothic:h14:cSHIFTJIS:qDRAFT
set mousehide                             " 当输入的时候隐藏鼠标
set lines=35 columns=148                  " 窗口大小
set guitablabel=\[%N\]%t%m                " 设定tab表示内容，例子为：[4]sample.file[+]，N为当前页号，t为文件名，m为修改标记。更多请看[:h statusline]
set rop=type:directx,renmode:4            " 开启Windows下DirectX，让字体更漂亮
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
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
let scriptPath = expand("<sfile>:p:h")
exec 'source' scriptPath . '/vim-color-256-rc.vim'
"exec 'source' scriptPath . '/vim-color-256-rc-light.vim'
