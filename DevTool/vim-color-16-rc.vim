scriptencoding utf-8
"vim-color-16-rc.vim

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
set background=dark

"hi Normal      term=none cterm=none ctermfg=white gui=none guifg=white
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=DarkGrey gui=none guifg=DarkGrey
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=DarkGrey gui=none guifg=DarkGrey
"StatusLine    : 底部状态栏（白底黑字粗体，因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=white ctermbg=black gui=bold,reverse
"TabLineSel    : 上部TAB栏（蓝底黄字粗体）
hi TabLineSel   term=bold cterm=bold ctermfg=yellow ctermbg=darkblue gui=bold guifg=yellow guibg=darkblue

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=DarkGrey gui=none guifg=DarkGrey
"Constant   : 常量，例如数字、引号内字符串、布尔值(浅蓝色)
hi Constant     term=none cterm=none ctermfg=lightblue gui=none guifg=lightblue
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=Cyan gui=none guifg=Cyan
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。(蓝色)
hi Statement    term=bold cterm=bold ctermfg=blue gui=bold guifg=blue
"PreProc    : 预处理，例如C语言中的“#include”(绿色)
hi PreProc      term=none cterm=none ctermfg=green gui=none guifg=green
"Type       : 变量类型，例如“int”(红色)
hi Type         term=bold cterm=bold ctermfg=red gui=bold guifg=red
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”(深紫红色)
hi Special      term=none cterm=none ctermfg=darkmagenta gui=none guifg=darkmagenta
"Underlined : 文本下划线。
"Error      : 显示编程语言错误的文本。

"Search     : 搜索高亮（黄底黑字）
hi Search       term=reverse cterm=none ctermfg=black ctermbg=yellow gui=none guifg=black guibg=yellow
"CursorLine : 光标所在行（灰底黑字）
"hi CursorLine   term=underline cterm=underline ctermfg=black ctermbg=grey gui=underline guifg=black guibg=grey
"CursorLine : 光标（黄字）
"hi Cursor       term=underline cterm=underline ctermfg=Yellow gui=underline guifg=Yellow
"CursorLine : 光标所在行（灰底黑字）
"hi cursorcolumn term=underline cterm=underline ctermfg=black ctermbg=grey gui=underline guifg=black guibg=grey
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=Cyan gui=none guifg=Cyan
"LineNr     : 当前行号
hi CursorLineNr term=bold cterm=bold ctermfg=yellow gui=bold guifg=yellow
