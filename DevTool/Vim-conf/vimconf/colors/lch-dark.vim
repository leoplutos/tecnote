scriptencoding utf-8
"lch-dark.vim

"全局变量g:g_i_colorflg（1：256暗色系，2：256亮色系，3：16色系）
let g:g_i_colorflg=1

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

hi Normal       term=none cterm=none ctermfg=253 ctermbg=234 gui=none guifg=#D4D4D4 guibg=#1E1E1E
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=240 gui=none guifg=#505050
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=240 gui=none guifg=#505050
"StatusLine    : 底部状态栏（因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=231 ctermbg=16 gui=bold,reverse guifg=#ffffff guibg=#000000
"TabLineSel    : 上部TAB栏
hi TabLine      term=none cterm=none ctermfg=248 ctermbg=238 gui=none guifg=#a8a8a8 guibg=#444444
hi TabLineSel   term=underline cterm=none ctermfg=231 ctermbg=234 gui=none guifg=#ffffff guibg=#1E1E1E
hi Directory    term=bold cterm=none ctermfg=87 gui=none guifg=#5fffff

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=241 gui=none guifg=#5f6167
"Constant   : 常量，例如__LINE__ __FILE__ __DATE__
hi Constant     term=none cterm=none ctermfg=75 gui=none guifg=#569CD6
"Number     : 例如数字
hi Number       term=none cterm=none ctermfg=45 gui=none guifg=#00e8ef
"String     : 例如字符串
hi String       term=none cterm=none ctermfg=108 gui=none guifg=#809980
hi Character    term=none cterm=none ctermfg=108 gui=none guifg=#809980
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。
hi Statement    term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"PreProc    : 预处理，例如C语言中的“#include”
hi PreProc      term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"Type       : 变量类型，例如“int”
hi Type         term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”
hi Special      term=none cterm=none ctermfg=117 gui=none guifg=#9CDCFE
"Function   : 函数名
hi Function     term=none cterm=none ctermfg=113 gui=none guifg=#96E072
"Structure  : 结构体
hi Structure    term=none cterm=none ctermfg=202 gui=none guifg=#ee5d43
"Underlined : 文本下划线。
"hi Underlined   term=underline cterm=underline ctermfg=21 gui=underline guifg=#0000ff

"Search     : 搜索高亮（黄底黑字）
hi Search       term=reverse cterm=none ctermfg=17 ctermbg=226 gui=none guifg=#00005f guibg=#ffff00
hi CurSearch    term=reverse cterm=none ctermfg=17 ctermbg=40 gui=none guifg=#00005f guibg=#00d700
"Cursor：光标，CursorLine : 光标所在行，CursorColumn: 光标所在列
hi Cursor       term=reverse ctermfg=16 ctermbg=253 guifg=#000000 guibg=#D4D4D4
hi iCursor      term=reverse ctermfg=16 ctermbg=226 guifg=#000000 guibg=#ffff00
hi CursorLine   term=reverse ctermbg=233 guibg=#121212
hi CursorColumn term=reverse ctermbg=233 guibg=#121212
"LineNr     : 行号
"hi LineNr       term=none cterm=none ctermfg=66 gui=none guifg=#6c8086 guibg=#292929
hi LineNr       term=none cterm=none ctermfg=66 gui=none guifg=#6c8086
"LineNr     : 当前行号
"hi CursorLineNr term=none cterm=none ctermfg=226 gui=none guifg=#ffff00 guibg=#292929
hi CursorLineNr term=none cterm=none ctermfg=226 gui=none guifg=#ffff00
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=231 ctermbg=196 gui=bold guifg=#ffffff guibg=#ff0000
hi MoreMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi ModeMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi Question     term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
"hi Visual       term=reverse ctermfg=16 ctermbg=250 guifg=#000000 guibg=#bcbcbc
hi Visual       term=reverse ctermbg=16 guibg=#000000
hi WarningMsg   term=bold cterm=bold ctermfg=0 ctermbg=226 guifg=#000000 guibg=#ffff00
hi Ignore       ctermfg=237 guifg=bg
hi Error        term=reverse ctermfg=15 ctermbg=196 guifg=#ffffff guibg=#ff0000
"弹出菜单
hi Pmenu        term=bold ctermfg=255 ctermbg=236 guifg=#eeeeee guibg=#303030
hi PmenuSel     term=bold ctermfg=255 ctermbg=24 guifg=#eeeeee guibg=#03385c
hi VertSplit    term=reverse ctermfg=236 ctermbg=236 guifg=#303030 guibg=#303030
hi DiffAdd      term=bold ctermbg=239 guibg=#4c4e39
hi DiffChange   term=bold ctermbg=24 guibg=#2B5B77
hi DiffDelete   term=bold ctermfg=234 ctermbg=167 gui=bold guifg=#1d1f21 guibg=#cc6666
hi DiffText     term=reverse cterm=bold ctermfg=235 ctermbg=110 gui=bold guifg=#282a2e guibg=#81a2be
hi Folded       term=standout ctermfg=246 ctermbg=234 guifg=#969896 guibg=#1d1f21
hi FoldColumn   term=standout ctermfg=51 ctermbg=234 guifg=Cyan guibg=#1d1f21
hi SignColumn   term=standout ctermfg=51 ctermbg=234 guifg=Cyan guibg=#1d1f21
"终端颜色
if has('terminal')
  hi Terminal     term=none cterm=none ctermbg=234 ctermfg=253 gui=none guibg=#1d1f21 guifg=#dadada
  let g:terminal_ansi_colors = [
  \ "#000000", "#cd3131", "#0dbc79", "#e5e510",
  \ "#2472c8", "#bc3fbc", "#11a8cd", "#e5e5e5",
  \ "#666666", "#f14c4c", "#23d18b", "#f5f543",
  \ "#3b8eea", "#d670d6", "#29b8db", "#e5e5e5"
  \ ]
endif
"QuickFi选中行
hi QuickFixLine term=reverse cterm=none ctermbg=24 gui=none guibg=#264f78

"Java语言高亮设定
let java_highlight_all=1
let java_highlight_functions=1
