scriptencoding utf-8
"vim-color-256-rc.vim

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
set background=dark

hi Normal      term=none cterm=none ctermfg=253 ctermbg=234 gui=none guifg=#D4D4D4 guibg=#1E1E1E
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=238 gui=none guifg=#444444
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=238 gui=none guifg=#444444
"StatusLine    : 底部状态栏（白底黑字粗体，因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=white ctermbg=black gui=bold,reverse guifg=white guibg=black
"TabLineSel    : 上部TAB栏（蓝底黄字粗体）
hi TabLine      term=underline cterm=reverse ctermfg=59 ctermbg=250 gui=reverse guifg=#4d5057 guibg=#c5c8c6
hi TabLineSel   term=bold cterm=bold ctermfg=11 ctermbg=27 gui=bold guifg=#ffff00 guibg=#005fff

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=241 gui=none guifg=#606060
"Constant   : 常量，例如数字、引号内字符串、布尔值
hi Constant     term=none cterm=none ctermfg=167 gui=none guifg=#ce9178
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=207 gui=none guifg=#c586c0
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。
hi Statement    term=bold cterm=bold ctermfg=207 gui=bold guifg=#c586c0
"PreProc    : 预处理，例如C语言中的“#include”
hi PreProc      term=none cterm=none ctermfg=207 gui=none guifg=#c586c0
"Type       : 变量类型，例如“int”
hi Type         term=bold cterm=bold ctermfg=128 gui=bold guifg=#569cd6
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”
hi Special      term=none cterm=none ctermfg=123 gui=none guifg=#9cdcfe
"Underlined : 文本下划线。
"hi Underlined   term=underline cterm=underline ctermfg=21 gui=underline guifg=#0000ff

"Search     : 搜索高亮（黄底黑字）
hi Search       term=reverse cterm=none ctermfg=253 ctermbg=24 gui=none guifg=#D4D4D4 guibg=#314365
hi CurSearch    term=reverse cterm=none ctermfg=253 ctermbg=40 gui=none guifg=#D4D4D4 guibg=#00d700
"Cursor：光标，CursorLine : 光标所在行，CursorColumn: 光标所在列
hi Cursor       term=reverse ctermfg=16 ctermbg=253 guifg=#000000 guibg=#D4D4D4
hi iCursor      term=reverse ctermfg=16 ctermbg=226 guifg=#000000 guibg=#ffff00
hi CursorLine   term=reverse ctermbg=233 guibg=#121212
hi CursorColumn term=reverse ctermbg=233 guibg=#121212
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=246 gui=none guifg=#90908a
"LineNr     : 当前行号
hi CursorLineNr term=bold cterm=bold ctermfg=226 gui=bold guifg=#ffff00
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=White ctermbg=Red gui=bold guifg=White guibg=Red
hi MoreMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi ModeMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi Question     term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
"hi Visual       term=reverse ctermfg=16 ctermbg=250 guifg=#000000 guibg=#bcbcbc
hi Visual       term=reverse ctermbg=16 guibg=#000000
hi WarningMsg   term=bold cterm=bold ctermfg=226 gui=bold guifg=#ffff00
hi Ignore       ctermfg=237 guifg=bg
hi Error        term=reverse ctermfg=White ctermbg=196 guifg=White guibg=Red
"弹出菜单
hi Pmenu        term=bold ctermfg=White ctermbg=13 guifg=#ffffff guibg=#ff00ff
hi PmenuSel     term=bold ctermfg=White ctermfg=8 guifg=#ffffff guibg=#808080
hi VertSplit    term=reverse ctermfg=59 ctermbg=59 guifg=#4d5057 guibg=#4d5057
hi DiffAdd      term=bold ctermbg=58 guibg=#4c4e39
hi DiffChange   term=bold ctermbg=24 guibg=#2B5B77
hi DiffDelete   term=bold ctermfg=16 ctermbg=167 gui=bold guifg=#1d1f21 guibg=#cc6666
hi DiffText     term=reverse cterm=bold ctermfg=16 ctermbg=109 gui=bold guifg=#282a2e guibg=#81a2be
hi Folded       term=standout ctermfg=245 ctermbg=16 guifg=#969896 guibg=#1d1f21
hi FoldColumn   term=standout ctermfg=11 ctermbg=16 guifg=Cyan guibg=#1d1f21
hi SignColumn   term=standout ctermfg=11 ctermbg=16 guifg=Cyan guibg=#1d1f21
