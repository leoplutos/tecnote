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
set guifont=等距更纱黑体_SC:h14:cANSI:qDRAFT,更紗等幅ゴシック_J:h14:cANSI:qDRAFT,Inconsolata:h14:cANSI:qDRAFT,JetBrains_Mono:h14:cANSI:qDRAFT
"set guifont=ＭＳ_ゴシック:h14:cANSI:qDRAFT,Inconsolata:h14:cANSI:qDRAFT,JetBrains_Mono:h14:cANSI:qDRAFT
"set guifontwide=ＭＳ_ゴシック:h14:cSHIFTJIS:qDRAFT,MS_Gothic:h14:cSHIFTJIS:qDRAFT,Microsoft_YaHei:h14:cGB2312:qDRAFT,Microsoft_YaHei_UI:h14:cGB2312:qDRAFT,SimSun:h14:cGB2312:qDRAFT,新宋体:h14:cGB2312:qDRAFT
set guifontwide=等距更纱黑体_SC:h14:cGB2312:qDRAFT,更紗等幅ゴシック_J:h14:cSHIFTJIS:qDRAFT,Microsoft_YaHei:h14:cGB2312:qDRAFT,Microsoft_YaHei_UI:h14:cGB2312:qDRAFT,SimSun:h14:cGB2312:qDRAFT,新宋体:h14:cGB2312:qDRAFT,ＭＳ_ゴシック:h14:cSHIFTJIS:qDRAFT,MS_Gothic:h14:cSHIFTJIS:qDRAFT
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
set shellslash                            " 使用/，不使用windows的\（在用netrw . 打开文件夹的时候特别有用）

"在普通模式下用块状光标，在插入模式下用条状光标（形状类似英文 "I" 的样子），然后在替换模式中使用下划线形状的光标。
set guicursor=n-v:block-Cursor       "在普通和可视模式里，使用块光标和"Cursor"高亮组的颜色
set guicursor+=i-c-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150     "在插入,命令行和命令行插入模式里，使用30%的垂直线光标和"iCursor"高亮组的颜色。闪烁也加快一点。
set guicursor+=r-cr:hor15-iCursor-blinkwait300-blinkon200-blinkoff150       "在替换和命令行替换模式里，使用15%的水平线光标和"iCursor"高亮组的颜色。闪烁也加快一点。

" 让 Vim 在启动时最大化窗口
augroup lchguigroup
  autocmd!
  autocmd GUIEnter * simalt ~x
augroup END

" vim 文件折叠方式为 marker
augroup ft_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

"-----------------------------------------------"
"               特殊符号设置                      "
"-----------------------------------------------"
set listchars=tab:^\ ,precedes:<,extends:>
"set listchars=tab:^\ ,trail:.,precedes:<,extends:>,nbsp:%,space:.,eol:↲
"set listchars=tab:^\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:↲
"set listchars=tab:^\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:⏎
"set listchars=tab:→\ ,trail:␣,precedes:«,extends:»,nbsp:%,space:␣,eol:↲
