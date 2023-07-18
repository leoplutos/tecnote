scriptencoding utf-8
"lch-light.vim

"全局变量g:g_i_colorflg（1：256暗色系，2：256亮色系，3：16色系）
let g:g_i_colorflg=2

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
set background=light
"highlight clear
"if exists("syntax_on")
"  syntax reset
"endif

hi Normal       term=none cterm=none ctermfg=16 ctermbg=255 gui=none guifg=#000000 guibg=#f9f9f9
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=250 gui=none guifg=#C0C0C0
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=250 gui=none guifg=#C0C0C0
"StatusLine    : 底部状态栏（因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=249 ctermbg=17 gui=bold,reverse guifg=#b2b2b2 guibg=#00005f
"TabLineSel    : 上部TAB栏
hi TabLine      term=none cterm=none ctermfg=102 ctermbg=253 gui=none guifg=#8f8391 guibg=#dadada
hi TabLineSel   term=underline cterm=none ctermfg=236 ctermbg=255 gui=none guifg=#2c2c2c guibg=#f3f3f3
hi Directory    term=bold cterm=none ctermfg=18 gui=none guifg=#000087

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=248 gui=none guifg=#a6a6a6
"Constant   : 常量，例如__LINE__ __FILE__ __DATE__
hi Constant     term=none cterm=none ctermfg=21 gui=none guifg=#0000FF
"Number     : 例如数字
hi Number       term=none cterm=none ctermfg=33 gui=none guifg=#0087ff
"String     : 例如字符串
hi String       term=none cterm=none ctermfg=23 gui=none guifg=#2F5E5E
hi Character    term=none cterm=none ctermfg=23 gui=none guifg=#2F5E5E
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=19 gui=none guifg=#0000a0
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。
hi Statement    term=none cterm=none ctermfg=19 gui=none guifg=#0000a0
"PreProc    : 预处理，例如C语言中的“#include”
hi PreProc      term=none cterm=none ctermfg=19 gui=none guifg=#0000a0
"Type       : 变量类型，例如“int”
hi Type         term=none cterm=none ctermfg=19 gui=none guifg=#0000a0
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”
hi Special      term=none cterm=none ctermfg=18 gui=none guifg=#001080
"Function   : 函数名
hi Function     term=none cterm=none ctermfg=22 gui=none guifg=#006400
"Structure  : 结构体
hi Structure    term=none cterm=none ctermfg=166 gui=none guifg=#e02838
"Underlined : 文本下划线。
"hi Underlined   term=underline cterm=underline ctermfg=21 gui=underline guifg=#0000ff

"Search     : 搜索高亮（黄底黑字）
hi Search       term=reverse cterm=none ctermfg=17 ctermbg=226 gui=none guifg=#00005f guibg=#ffff00
hi CurSearch    term=reverse cterm=none ctermfg=17 ctermbg=40 gui=none guifg=#00005f guibg=#00d700
"Cursor：光标，CursorLine : 光标所在行，CursorColumn: 光标所在列
hi Cursor       term=reverse ctermfg=231 ctermbg=234 guifg=#ffffff guibg=#1E1E1E
hi iCursor      term=reverse ctermfg=231 ctermbg=21 guifg=#ffffff guibg=#0000ff
hi CursorLine   term=reverse ctermbg=123 guibg=#96ffff
hi CursorColumn term=reverse ctermbg=123 guibg=#96ffff
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=66 gui=none guifg=#6c8086
"LineNr     : 当前行号
hi CursorLineNr term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=231 ctermbg=196 gui=bold guifg=#ffffff guibg=#ff0000
hi MoreMsg      term=bold cterm=bold ctermfg=16 gui=bold guifg=#000000
hi ModeMsg      term=bold cterm=bold ctermfg=16 gui=bold guifg=#000000
hi Question     term=bold cterm=bold ctermfg=19 gui=bold guifg=#0000af
"hi Visual       term=reverse ctermfg=16 ctermbg=252 guifg=#000000 guibg=#d0d0d0
hi Visual       term=reverse ctermbg=153 guibg=#abd6fe
hi WarningMsg   term=bold cterm=bold ctermfg=16 ctermbg=226 guifg=#000000 guibg=#ffff00
"hi Ignore       ctermfg=237 guifg=bg
hi Error        term=reverse ctermfg=231 ctermbg=196 guifg=#ffffff guibg=#ff0000
"弹出菜单
hi Pmenu        term=bold ctermfg=233 ctermbg=231 guifg=#121212 guibg=#ffffff
hi PmenuSel     term=bold ctermfg=255 ctermbg=25 guifg=#eeeeee guibg=#0060c0
hi VertSplit    term=reverse ctermfg=49 ctermbg=49 guifg=#00ffaf guibg=#00ffaf
hi DiffAdd      term=bold ctermfg=71 ctermbg=251 guifg=#50a14f guibg=#d0d0d0
hi DiffChange   term=bold ctermfg=94 ctermbg=251 guifg=#986801 guibg=#d0d0d0
hi DiffDelete   term=bold ctermfg=167 ctermbg=251 gui=bold guifg=#e45649 guibg=#d0d0d0
hi DiffText     term=reverse cterm=bold ctermfg=68 ctermbg=251 gui=bold guifg=#4078f2 guibg=#d0d0d0
hi Folded       term=standout ctermfg=239 ctermbg=255 guifg=#494b53 guibg=#fafafa
hi FoldColumn   term=standout ctermfg=247 ctermbg=255 guifg=#a0a1a7 guibg=#f0f0f0
hi SignColumn   term=standout ctermfg=18 ctermbg=255 guifg=DarkBlue guibg=#fafafa
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
hi QuickFixLine term=reverse cterm=none ctermbg=50 gui=none guibg=#00ffd7

"Java语言高亮设定
let java_highlight_all=1
let java_highlight_functions=1
