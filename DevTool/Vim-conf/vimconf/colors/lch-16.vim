scriptencoding utf-8
"lch-16.vim

"全局变量g:g_i_colorflg（1：256暗色系，2：256亮色系，3：16色系）
let g:g_i_colorflg=3

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
set background=dark
"highlight clear
"if exists("syntax_on")
"  syntax reset
"endif

hi Normal       term=none cterm=none ctermfg=lightgray ctermbg=black gui=none guifg=lightgray guibg=black
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=darkgray gui=none guifg=darkgray
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=darkgray gui=none guifg=darkgray
"StatusLine    : 底部状态栏（白底黑字粗体，因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=white ctermbg=black gui=bold,reverse guifg=white guibg=black
"TabLineSel    : 上部TAB栏
hi TabLine      term=none cterm=none ctermfg=black ctermbg=lightgray gui=none guifg=black guibg=lightgray
hi TabLineSel   term=underline cterm=none ctermfg=lightgray ctermbg=black gui=none guifg=lightgray guibg=black
hi Directory    term=bold cterm=none ctermfg=cyan gui=none guifg=cyan

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=darkgray gui=none guifg=darkgray
"Constant   : 常量，例如数字、引号内字符串、布尔值
hi Constant     term=none cterm=none ctermfg=cyan gui=none guifg=cyan
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=lightmagenta gui=none guifg=lightmagenta
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。
hi Statement    term=none cterm=none ctermfg=lightmagenta gui=none guifg=lightmagenta
"PreProc    : 预处理，例如C语言中的“#include”
hi PreProc      term=none cterm=none ctermfg=lightmagenta gui=none guifg=lightmagenta
"Type       : 变量类型，例如“int”
hi Type         term=none cterm=none ctermfg=lightmagenta gui=none guifg=lightmagenta
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”
hi Special      term=none cterm=none ctermfg=lightblue gui=none guifg=lightblue
"Function   : 函数名
hi Function     term=none cterm=none ctermfg=lightgreen gui=none guifg=lightgreen
"Underlined : 文本下划线。

"Search     : 搜索高亮（黄底黑字）
hi Search       term=reverse cterm=none ctermbg=yellow gui=none guibg=yellow
hi CurSearch    term=reverse cterm=none ctermfg=green ctermbg=black gui=none guifg=green guibg=black
"Cursor：光标，CursorLine : 光标所在行，CursorColumn: 光标所在列
hi Cursor       term=reverse ctermfg=black ctermbg=lightgray guifg=black guibg=lightgray
hi iCursor      term=reverse ctermfg=black ctermbg=yellow guifg=black guibg=yellow
"hi CursorLine   term=reverse ctermbg=darkblue guibg=darkblue
"hi CursorColumn term=reverse ctermbg=darkblue guibg=darkblue
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=darkcyan gui=none guifg=darkcyan
"LineNr     : 当前行号
hi CursorLineNr term=none cterm=none ctermfg=yellow gui=none guifg=yellow
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=white ctermbg=red gui=bold guifg=white guibg=red
hi MoreMsg      term=bold cterm=bold ctermfg=green gui=bold guifg=green
hi ModeMsg      term=bold cterm=bold ctermfg=green gui=bold guifg=green
hi Question     term=bold cterm=bold ctermfg=green gui=bold guifg=green
"hi Visual       term=reverse ctermfg=16 ctermbg=250 guifg=#000000 guibg=#bcbcbc
hi Visual       term=reverse ctermbg=darkblue guibg=darkblue
hi WarningMsg   term=bold cterm=bold ctermfg=black ctermbg=yellow guifg=black guibg=yellow
hi Ignore       ctermfg=darkgray guifg=bg
hi Error        term=reverse ctermfg=white ctermbg=red guifg=white guibg=red
"弹出菜单
hi Pmenu        term=bold ctermfg=black ctermbg=lightcyan guifg=black guibg=lightcyan
hi PmenuSel     term=bold ctermfg=lightgray ctermbg=darkblue guifg=lightgray guibg=darkblue
hi VertSplit    term=reverse ctermfg=darkgray ctermbg=darkgray guifg=darkgray guibg=darkgray
hi DiffAdd      term=bold ctermbg=darkgreen guibg=darkgreen
hi DiffChange   term=bold ctermbg=darkcyan guibg=darkcyan
hi DiffDelete   term=bold ctermfg=black ctermbg=lightred gui=bold guifg=black guibg=lightred
hi DiffText     term=reverse cterm=bold ctermfg=black ctermbg=cyan gui=bold guifg=black guibg=cyan
hi Folded       term=standout ctermfg=lightgray ctermbg=darkblue guifg=lightgray guibg=darkblue
hi FoldColumn   term=standout ctermfg=Cyan ctermbg=darkblue guifg=Cyan guibg=darkblue
hi SignColumn   term=standout ctermfg=Cyan ctermbg=darkblue guifg=Cyan guibg=darkblue
"终端颜色
if has('terminal')
  hi Terminal     term=none cterm=none ctermbg=lightgray ctermfg=black gui=none guibg=lightgray guifg=black
  "let g:terminal_ansi_colors = [
  "\ "#000000", "#cd3131", "#0dbc79", "#e5e510",
  "\ "#2472c8", "#bc3fbc", "#11a8cd", "#e5e5e5",
  "\ "#666666", "#f14c4c", "#23d18b", "#f5f543",
  "\ "#3b8eea", "#d670d6", "#29b8db", "#e5e5e5"
  "\ ]
endif
"QuickFi选中行
hi QuickFixLine term=reverse cterm=none ctermbg=darkblue gui=none guibg=darkblue
