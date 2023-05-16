scriptencoding utf-8
"vim-color-256-rc.vim

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
set background=dark

hi Normal      term=none cterm=none ctermfg=250 ctermbg=16 gui=none guifg=#c5c8c6 guibg=#1d1f21
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=238 gui=none guifg=#444444
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=238 gui=none guifg=#444444
"StatusLine    : 底部状态栏（白底黑字粗体，因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=none,reverse cterm=none,reverse ctermfg=15 ctermbg=0 gui=none,reverse guifg=#4d5057 guibg=#f0c674
"TabLineSel    : 上部TAB栏（蓝底黄字粗体）
hi TabLineSel   term=bold cterm=bold ctermfg=11 ctermbg=27 gui=bold guifg=#ffff00 guibg=#005fff

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=241 gui=none guifg=#606060
"Constant   : 常量，例如数字、引号内字符串、布尔值(浅蓝色)
hi Constant     term=none cterm=none ctermfg=14 gui=none guifg=#00ffff
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=167 gui=none guifg=#cc6666
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。(蓝色)
hi Statement    term=bold cterm=bold ctermfg=33 gui=bold guifg=#0087ff
"PreProc    : 预处理，例如C语言中的“#include”(绿色)
hi PreProc      term=none cterm=none ctermfg=139 gui=none guifg=#8787c8
"Type       : 变量类型，例如“int”(红色)
hi Type         term=bold cterm=bold ctermfg=202 gui=bold guifg=#ff5f00
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”(深紫红色)
hi Special      term=none cterm=none ctermfg=201 gui=none guifg=#ff00ff
"Underlined : 文本下划线。
"Error      : 显示编程语言错误的文本。

"Search     : 搜索高亮（黄底黑字）
hi Search       term=reverse cterm=none ctermfg=17 ctermbg=11 gui=none guifg=#00005f guibg=#ffff00
hi CurSearch    term=reverse cterm=none ctermfg=17 ctermbg=40 gui=none guifg=#00005f guibg=#00d700
"CursorLine : 光标所在行（灰底）
hi CursorLine   term=underline ctermbg=66 guibg=#5f8787
"CursorLine : 光标（黄字）
"hi Cursor       term=underline cterm=underline ctermfg=Yellow gui=underline guifg=Yellow
"CursorLine : 光标所在行（灰底黑字）
"hi cursorcolumn term=underline cterm=underline ctermfg=black ctermbg=grey gui=underline guifg=black guibg=grey
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=219 gui=none guifg=#ffafff
"LineNr     : 当前行号
hi CursorLineNr term=bold cterm=bold ctermfg=226 gui=bold guifg=#ffff00
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=White ctermbg=196 gui=bold guifg=White guibg=Red
hi MoreMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi ModeMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi Question     term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi Visual       term=reverse ctermfg=16 ctermbg=250 guifg=#000000 guibg=#bcbcbc
hi WarningMsg   term=bold cterm=bold ctermfg=226 gui=bold guifg=#ffff00
hi Ignore       ctermfg=237 guifg=bg
hi Error        term=reverse ctermfg=White ctermbg=196 guifg=White guibg=Red
