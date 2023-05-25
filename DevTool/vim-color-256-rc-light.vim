scriptencoding utf-8
"vim-color-256-rc-light.vim

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
set background=light

hi Normal      term=none cterm=none ctermfg=0 ctermbg=255 gui=none guifg=#000000 guibg=#fffbf0
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=249 gui=none guifg=#b2b2b2
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=249 gui=none guifg=#b2b2b2
"StatusLine    : 底部状态栏（黄底黑字粗体，因为设定了reverse，所以gb和fb要反过来）
"hi StatusLine   term=none,reverse cterm=none,reverse ctermfg=23 ctermbg=255 gui=none,reverse guifg=#586e75 guibg=#eee8d5
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=249 ctermbg=17 gui=bold,reverse guifg=#b2b2b2 guibg=#00005f
"TabLineSel    : 上部TAB栏（蓝底黄字粗体）
hi TabLine      term=underline cterm=none ctermfg=231 ctermbg=241 gui=none guifg=#ffffff guibg=#606060
hi TabLineSel   term=bold cterm=bold ctermfg=226 ctermbg=27 gui=bold guifg=#ffff00 guibg=#005fff

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=244 gui=none guifg=#808080
"Constant   : 常量，例如数字、引号内字符串、布尔值(浅蓝色)
hi Constant     term=none cterm=none ctermfg=33 gui=none guifg=#0087ff
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=29 gui=none guifg=#00875f
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。(蓝色)
hi Statement    term=bold cterm=bold ctermfg=18 gui=bold guifg=#0000a0
"PreProc    : 预处理，例如C语言中的“#include”(绿色)
hi PreProc      term=none cterm=none ctermfg=22 gui=none guifg=#005f00
"Type       : 变量类型，例如“int”(紫红色)
hi Type         term=bold cterm=bold ctermfg=58 gui=bold guifg=#5f5f00
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”(蓝色)
hi Special      term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
"Underlined : 文本下划线。
"hi Underlined   term=underline cterm=underline ctermfg=21 gui=underline guifg=#0000ff

"Search     : 搜索高亮（黄底黑字）
hi Search       term=reverse cterm=none ctermfg=17 ctermbg=226 gui=none guifg=#00005f guibg=#ffff00
hi CurSearch    term=reverse cterm=none ctermfg=17 ctermbg=40 gui=none guifg=#00005f guibg=#00d700
"Cursor：光标，CursorLine : 光标所在行，CursorColumn: 光标所在列
hi Cursor       term=reverse ctermfg=231 ctermbg=16 guifg=#F8F8F0 guibg=#1d1f21
hi iCursor      term=reverse ctermfg=231 ctermbg=52 guifg=#F8F8F0 guibg=#5f0000
hi CursorLine   term=reverse ctermbg=251 guibg=#c6c6c6
hi CursorColumn term=reverse ctermbg=251 guibg=#c6c6c6
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=52 gui=none guifg=#5f0000
"LineNr     : 当前行号
hi CursorLineNr term=bold cterm=bold ctermfg=21 gui=bold guifg=#0000ff
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=White ctermbg=196 gui=bold guifg=White guibg=Red
hi MoreMsg      term=bold cterm=bold ctermfg=16 ctermbg=231 gui=bold guifg=#000000 guibg=#ffffff
hi ModeMsg      term=bold cterm=bold ctermfg=16 ctermbg=231 gui=bold guifg=#000000 guibg=#ffffff
hi Question     term=bold cterm=bold ctermfg=19 gui=bold guifg=#0000af
"hi Visual       term=reverse ctermfg=16 ctermbg=252 guifg=#000000 guibg=#d0d0d0
hi Visual       term=reverse ctermbg=219 guibg=#ffafff
hi WarningMsg   term=bold cterm=bold ctermfg=0 ctermbg=226 guifg=Black guibg=Yellow
"hi Ignore       ctermfg=237 guifg=bg
hi Error        term=reverse ctermfg=White ctermbg=196 guifg=White guibg=Red
"弹出菜单
hi Pmenu        term=bold ctermfg=White ctermbg=13 guifg=#ffffff guibg=#ff00ff
hi PmenuSel     term=bold ctermfg=White ctermfg=8 guifg=#ffffff guibg=#808080
hi VertSplit    term=reverse ctermfg=49 ctermbg=49 guifg=#00ffaf guibg=#00ffaf
hi DiffAdd      term=bold ctermfg=71 ctermbg=251 guifg=#50a14f guibg=#d0d0d0
hi DiffChange   term=bold ctermfg=94 ctermbg=251 guifg=#986801 guibg=#d0d0d0
hi DiffDelete   term=bold ctermfg=166 ctermbg=251 gui=bold guifg=#e45649 guibg=#d0d0d0
hi DiffText     term=reverse cterm=bold ctermfg=33 ctermbg=251 gui=bold guifg=#4078f2 guibg=#d0d0d0
hi Folded       term=standout ctermfg=23 ctermbg=255 guifg=#494b53 guibg=#fafafa
hi FoldColumn   term=standout ctermfg=145 ctermbg=254 guifg=#a0a1a7 guibg=#f0f0f0
hi SignColumn   term=standout ctermfg=1 ctermbg=255 guifg=DarkBlue guibg=#fafafa
