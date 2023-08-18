scriptencoding utf-8
"qy-light.vim

"全局变量g:g_i_colorflg（1：256暗色系，2：256亮色系，3：16色系）
let g:g_i_colorflg=4

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

"-----------------------------------------------"
"               文本高亮                        "
"-----------------------------------------------"
hi Normal       term=none cterm=none ctermfg=16 ctermbg=230 gui=none guifg=#000000 guibg=#fffbf0
"SpecialKey    : TAB符
hi SpecialKey   term=none cterm=none ctermfg=250 gui=none guifg=#C0C0C0
"NonText       : 换行符
hi NonText      term=none cterm=none ctermfg=250 gui=none guifg=#C0C0C0
hi Directory    term=none cterm=none ctermfg=18 gui=none guifg=#000087
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=231 ctermbg=196 gui=bold guifg=#ffffff guibg=#ff0000
"Search     : 搜索高亮
hi Search       term=reverse cterm=none ctermfg=17 ctermbg=226 gui=none guifg=#00005f guibg=#ffff00
hi CurSearch    term=reverse cterm=none ctermfg=17 ctermbg=40 gui=none guifg=#00005f guibg=#00d700
hi MoreMsg      term=bold cterm=bold ctermfg=53 gui=bold guifg=#5f005f
hi ModeMsg      term=bold cterm=bold ctermfg=53 gui=bold guifg=#5f005f
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
hi CursorLine   term=reverse ctermbg=255 guibg=#ecece6
hi Question     term=bold cterm=bold ctermfg=53 gui=bold guifg=#5f005f
"StatusLine    : 底部状态栏（因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=123 ctermbg=17 gui=bold,reverse guifg=#87ffff guibg=#00005f
hi StatusLineNC term=reverse cterm=reverse ctermfg=159 ctermbg=17 gui=reverse guifg=#afffff guibg=#00005f
hi VertSplit    term=reverse ctermfg=49 ctermbg=49 guifg=#00ffaf guibg=#00ffaf
hi Title        term=bold cterm=bold ctermfg=19 gui=bold guifg=#0000a0
hi Visual       term=reverse ctermbg=153 guibg=#abd6fe
hi WarningMsg   term=bold cterm=bold ctermfg=16 ctermbg=226 gui=bold guifg=#000000 guibg=#ffff00
hi WildMenu     term=standout ctermfg=236 ctermbg=157 guifg=#333333 guibg=#c1f5b0
hi Folded       term=standout cterm=none ctermfg=37 ctermbg=231 gui=none guifg=#25b0bc guibg=#fcfcfc
hi FoldColumn   term=standout ctermfg=21 ctermbg=230 guifg=#1212ff guibg=#fffbf0
hi DiffAdd      term=bold ctermbg=187 guibg=#d7e4aa
hi DiffChange   term=bold ctermbg=189 guibg=#c9cbfe
hi DiffDelete   term=standout cterm=none ctermfg=253 ctermbg=230 gui=none guifg=#dadada guibg=#fffbf0
hi DiffText     term=reverse cterm=bold ctermfg=252 ctermbg=67 gui=bold guifg=#d0d0d0 guibg=#567fa8
hi SignColumn   term=standout ctermfg=26 ctermbg=230 guifg=#005fd7 guibg=#fffbf0
hi clear Conceal
hi! link Conceal SpecialKey
hi SpellBad     term=reverse cterm=undercurl ctermfg=196 ctermbg=230 gui=undercurl guifg=#ff0000 guibg=#fffbf0 guisp=#ff0000
hi SpellCap     term=reverse cterm=undercurl ctermfg=196 ctermbg=230 gui=undercurl guifg=#ff0000 guibg=#fffbf0 guisp=#ff0000
hi SpellRare    term=reverse cterm=undercurl ctermfg=196 ctermbg=230 gui=undercurl guifg=#ff0000 guibg=#fffbf0 guisp=#ff0000
hi SpellLocal   term=underline cterm=undercurl ctermfg=196 ctermbg=230 gui=undercurl guifg=#ff0000 guibg=#fffbf0 guisp=#ff0000
"弹出菜单
hi Pmenu        ctermfg=233 ctermbg=255 guifg=#121212 guibg=#efefef
hi PmenuSel     ctermfg=255 ctermbg=25 guifg=#eeeeee guibg=#0060c0
hi PmenuSbar    ctermbg=251 guibg=#c6c6c6
hi PmenuThumb   ctermbg=234 guibg=#1e1e1e
"TabLine    : 上部TAB栏
hi TabLine      term=none cterm=none ctermfg=102 ctermbg=253 gui=none guifg=#8f8391 guibg=#dadada
hi TabLineSel   term=underline cterm=none ctermfg=236 ctermbg=230 gui=none guifg=#2c2c2c guibg=#fffbf0
hi TabLineFill  term=reverse cterm=none ctermfg=255 ctermbg=255 gui=none guifg=#f3f3f3 guibg=#efebe0
hi CursorColumn term=reverse ctermbg=158 guibg=#afffd7
"CursorLineNr     : 当前行号
hi CursorLineNr term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
hi ColorColumn  term=reverse ctermbg=252 guibg=#d3d3d3
"QuickFixLine选中行
hi QuickFixLine term=reverse cterm=none ctermbg=50 gui=none guibg=#00ffd7
"终端的状态栏
hi clear StatusLineTerm
hi! link StatusLineTerm StatusLine
"终端的状态栏（未选中）
hi clear StatusLineTermNC
hi! link StatusLineTermNC StatusLineNC
"Cursor：光标，CursorLine : 光标所在行，CursorColumn: 光标所在列，iCursor：插入模式光标
hi Cursor       term=reverse ctermfg=255 ctermbg=16 guifg=#f9f9f9 guibg=#000000
hi iCursor      term=reverse ctermfg=255 ctermbg=21 guifg=#f9f9f9 guibg=#0000ff
hi MatchParen   term=reverse ctermbg=49 guibg=#20f5b0

"-----------------------------------------------"
"               语法高亮                        "
"-----------------------------------------------"
"Comment    : 注释
hi Comment      term=none cterm=none ctermfg=28 gui=none guifg=#0a881b
"Constant   : 常量，例如__LINE__ __FILE__ __DATE__
hi Constant     term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”
hi Special      term=none cterm=none ctermfg=196 gui=none guifg=#ff1717
"Identifier : 变量名
hi Identifier   term=none cterm=none ctermfg=90 gui=none guifg=#870087
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。
hi Statement    term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
"PreProc    : 预处理，例如C语言中的“#include”
hi PreProc      term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
"Type       : 变量类型，例如“int”
hi Type         term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
"Underlined : 文本下划线。
hi Underlined   term=underline cterm=underline ctermfg=20 gui=underline guifg=#002ad1
hi Ignore       ctermfg=254 guifg=bg
hi Error        term=reverse ctermfg=231 ctermbg=196 guifg=#ffffff guibg=#ff0000
"String     : 字符串
hi String       term=none cterm=none ctermfg=88 gui=none guifg=#991313
hi Character    term=none cterm=none ctermfg=88 gui=none guifg=#991313
"Number     : 数字
hi Number       term=none cterm=none ctermfg=124 gui=none guifg=#be0000
"Function   : 函数名
hi Function     term=none cterm=none ctermfg=16 gui=none guifg=#000000
"Structure  : 结构体
hi Structure    term=none cterm=none ctermfg=196 gui=none guifg=#ff0000
"自定义-Variables
hi Variables    term=none cterm=none ctermfg=90 gui=none guifg=#870087
hi clear Typedef
hi! link Typedef Structure
hi ThinTitle    term=none cterm=none ctermfg=19 gui=none guifg=#0000a0
hi Annotation   term=none cterm=none ctermfg=89 gui=none guifg=#87005f
hi clear SpecialComment
hi! link SpecialComment Comment
hi CommonTag    term=none cterm=none ctermfg=88 gui=none guifg=#800000

"-----------------------------------------------"
"               终端高亮                        "
"-----------------------------------------------"
if has('terminal')
  hi Terminal     term=none cterm=none ctermbg=194 ctermfg=16 gui=none guibg=#e6edcd guifg=#000000
  let g:terminal_ansi_colors = [
  \ "#000000", "#ff0000", "#00ff00", "#ffff00",
  \ "#2020ff", "#ff00ff", "#00ffff", "#ffffff",
  \ "#404040", "#c00000", "#00c000", "#c0c000",
  \ "#4040c0", "#c000c0", "#00c0c0", "#c0c0c0"
  \ ]
endif

"-----------------------------------------------"
"               netrw高亮                       "
"-----------------------------------------------"
"netrw的缩进线
hi clear netrwTreeBar
hi! link netrwTreeBar SpecialKey
"netrw的文件夹后面的/
hi clear netrwClassify
hi! link netrwClassify Directory
"netrw的可执行文件
hi netrwExe     term=standout ctermfg=23 guifg=#326464

"-----------------------------------------------"
"               其他高亮                        "
"-----------------------------------------------"
"高亮行尾空格(包括tab)
"hi ExtraWhitespace  term=standout ctermfg=250 ctermbg=203 guifg=#C0C0C0 guibg=#FF6464
"augroup lchSyntaxGroup
"  autocmd!
"  autocmd Syntax * match ExtraWhitespace /\s\+$/
"augroup END

"tagbar插件高亮
hi link TagbarKind ThinTitle
hi link TagbarScope ThinTitle