scriptencoding utf-8
"vim-color-256-rc-light.vim

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
set background=light

"hi Normal      term=none cterm=none ctermfg=0 ctermbg=255 gui=none guifg=#000000 guibg=#fffbf0
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=249 gui=none guifg=#b2b2b2
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=249 gui=none guifg=#b2b2b2
"StatusLine    : 底部状态栏（黄底黑字粗体，因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=none,reverse cterm=none,reverse ctermfg=251 ctermbg=0 gui=none,reverse
"TabLineSel    : 上部TAB栏（蓝底黄字粗体）
hi TabLineSel   term=bold cterm=bold ctermfg=226 ctermbg=27 gui=bold guifg=#ffff00 guibg=#005fff

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=247 gui=none guifg=#9e9e9e
"Constant   : 常量，例如数字、引号内字符串、布尔值(浅蓝色)
hi Constant     term=none cterm=none ctermfg=33 gui=none guifg=#0087ff
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=53 gui=none guifg=#5f005f
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。(蓝色)
hi Statement    term=bold cterm=bold ctermfg=19 gui=bold guifg=#0000af
"PreProc    : 预处理，例如C语言中的“#include”(绿色)
hi PreProc      term=none cterm=none ctermfg=22 gui=none guifg=#005f00
"Type       : 变量类型，例如“int”(紫红色)
hi Type         term=bold cterm=bold ctermfg=196 gui=bold guifg=#0000af
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”(蓝色)
hi Special      term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
"Underlined : 文本下划线。
"Error      : 显示编程语言错误的文本。

"Search     : 搜索高亮（黄底黑字）
hi Search       term=reverse cterm=none ctermfg=17 ctermbg=226 gui=none guifg=#00005f guibg=#eeeeee
"CursorLine : 光标所在行（灰底黑字）
"hi CursorLine   term=underline cterm=underline ctermfg=black ctermbg=grey gui=underline guifg=black guibg=grey
"CursorLine : 光标（黄字）
"hi Cursor       term=underline cterm=underline ctermfg=Yellow gui=underline guifg=Yellow
"CursorLine : 光标所在行（灰底黑字）
"hi cursorcolumn term=underline cterm=underline ctermfg=black ctermbg=grey gui=underline guifg=black guibg=grey
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=52 gui=none guifg=#5f0000
"LineNr     : 当前行号
hi CursorLineNr term=bold cterm=bold ctermfg=21 gui=bold guifg=#0000ff
"提示信息
hi MoreMsg      term=bold ctermfg=19 gui=bold guifg=#0000af
hi Question     term=standout ctermfg=19 gui=bold guifg=#0000af
hi WarningMsg   term=standout ctermfg=88 guifg=#005f00
hi Ignore       ctermfg=237 guifg=bg
hi Error        term=reverse ctermfg=255 ctermbg=88 guifg=White guibg=#005f00
hi ErrorMsg     term=standout ctermfg=255 ctermbg=88 guifg=White guibg=#005f00
