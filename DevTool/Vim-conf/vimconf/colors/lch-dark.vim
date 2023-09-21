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

"-----------------------------------------------"
"               文本高亮                        "
"-----------------------------------------------"
hi Normal       term=none cterm=none ctermfg=188 ctermbg=234 gui=none guifg=#d4d4d4 guibg=#1e1e1e
"SpecialKey    : TAB符
hi SpecialKey   term=none cterm=none ctermfg=239 gui=none guifg=#505050
"NonText       : 换行符
hi NonText      term=none cterm=none ctermfg=239 gui=none guifg=#505050
hi Directory    term=none cterm=none ctermfg=87 gui=none guifg=#5fffff
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=196 ctermbg=234 gui=bold guifg=#ff0000 guibg=#1e1e1e
"Search     : 搜索高亮
hi Search       term=reverse cterm=none ctermfg=17 ctermbg=226 gui=none guifg=#00005f guibg=#ffff00
hi CurSearch    term=reverse cterm=none ctermfg=17 ctermbg=40 gui=none guifg=#00005f guibg=#00d700
hi MoreMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi ModeMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=66 gui=none guifg=#6c8086
hi CursorLine   term=reverse ctermbg=236 guibg=#292e42
hi Question     term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
"StatusLine    : 底部状态栏（因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=231 ctermbg=16 gui=bold,reverse guifg=#ffffff guibg=#000000
hi StatusLineNC term=reverse cterm=reverse ctermfg=249 ctermbg=235 gui=reverse guifg=#b2b2b2 guibg=#252526
"分割窗口线
hi VertSplit    term=reverse ctermfg=237 ctermbg=237 guifg=#3e3e3e guibg=#3e3e3e
hi Title        term=bold cterm=bold ctermfg=214 gui=bold guifg=#f39c12
hi Visual       term=reverse ctermbg=60 guibg=#2e3c64
hi WarningMsg   term=bold cterm=bold ctermfg=226 ctermbg=234 gui=bold guifg=#ffff00 guibg=#1e1e1e
hi WildMenu     term=standout ctermfg=188 ctermbg=24 guifg=#d4d4d4 guibg=#264f78
hi Folded       term=standout cterm=none ctermfg=73 ctermbg=236 gui=none guifg=#56b6c2 guibg=#202d39
hi FoldColumn   term=standout ctermfg=170 ctermbg=234 guifg=#c678dd guibg=#1e1e1e
hi DiffAdd      term=bold ctermbg=58 guibg=#4b5920
hi DiffChange   term=bold ctermbg=24 guibg=#2b5b77
hi DiffDelete   term=standout cterm=none ctermfg=238 ctermbg=234 gui=none guifg=#444444 guibg=#1c1c1c
hi DiffText     term=reverse cterm=bold ctermfg=235 ctermbg=110 gui=bold guifg=#282a2e guibg=#81a2be
"左侧导航线（和TabLineFill相同即可）
hi SignColumn   term=standout ctermfg=51 ctermbg=236 guifg=#00ffff guibg=#2e2e2e
hi clear Conceal
hi! link Conceal SpecialKey
hi SpellBad     term=reverse cterm=undercurl ctermfg=203 ctermbg=234 gui=undercurl guifg=#f44747 guibg=#1e1e1e guisp=#f44747
hi SpellCap     term=reverse cterm=undercurl ctermfg=203 ctermbg=234 gui=undercurl guifg=#f44747 guibg=#1e1e1e guisp=#f44747
hi SpellRare    term=reverse cterm=undercurl ctermfg=203 ctermbg=234 gui=undercurl guifg=#f44747 guibg=#1e1e1e guisp=#f44747
hi SpellLocal   term=underline cterm=undercurl ctermfg=203 ctermbg=234 gui=undercurl guifg=#f44747 guibg=#1e1e1e guisp=#f44747
"弹出菜单
hi Pmenu        ctermfg=188 ctermbg=237 guifg=#d4d4d4 guibg=#3d3d45
hi PmenuSel     ctermfg=188 ctermbg=24 guifg=#d4d4d4 guibg=#073655
hi PmenuSbar    ctermbg=237 guibg=#3d3d40
hi PmenuThumb   ctermbg=250 guibg=#bbbbbb
"TabLine    : 上部TAB栏
hi TabLine      term=none cterm=none ctermfg=248 ctermbg=238 gui=none guifg=#a8a8a8 guibg=#444444
hi TabLineSel   term=underline cterm=none ctermfg=231 ctermbg=234 gui=none guifg=#ffffff guibg=#1e1e1e
hi TabLineFill  term=reverse cterm=none ctermfg=188 ctermbg=236 gui=none guifg=#d4d4d4 guibg=#2e2e2e
hi CursorColumn term=reverse ctermbg=233 guibg=#121212
"CursorLineNr     : 当前行号
hi CursorLineNr term=none cterm=none ctermfg=226 gui=none guifg=#ffff00
hi ColorColumn  term=reverse ctermbg=236 guibg=#2e2e2e
"QuickFixLine选中行
hi QuickFixLine term=reverse cterm=none ctermbg=24 gui=none guibg=#264f78
"终端的状态栏
hi clear StatusLineTerm
hi! link StatusLineTerm StatusLine
"终端的状态栏（未选中）
hi clear StatusLineTermNC
hi! link StatusLineTermNC StatusLineNC
hi clear LineNrAbove
hi! link LineNrAbove LineNr
hi clear LineNrBelow
hi! link LineNrBelow LineNr
"Cursor：光标，CursorLine : 光标所在行，CursorColumn: 光标所在列，iCursor：插入模式光标
hi Cursor       term=reverse ctermfg=234 ctermbg=188 guifg=#1e1e1e guibg=#d4d4d4
hi iCursor      term=reverse ctermfg=234 ctermbg=226 guifg=#1e1e1e guibg=#ffff00
hi MatchParen   term=reverse ctermbg=239 guibg=#51504f

"-----------------------------------------------"
"               语法高亮                        "
"-----------------------------------------------"
"Comment    : 注释（备份 #676e95）
hi Comment      term=none cterm=none ctermfg=241 gui=none guifg=#5f6167
"Constant   : 常量，例如__LINE__ __FILE__ __DATE__
hi Constant     term=none cterm=none ctermfg=75 gui=none guifg=#569CD6
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”
hi Special      term=none cterm=none ctermfg=117 gui=none guifg=#9CDCFE
"Identifier : 变量名
hi Identifier   term=none cterm=none ctermfg=187 gui=none guifg=#d4d4b0
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。
hi Statement    term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"PreProc    : 预处理，例如C语言中的“#include”
hi PreProc      term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"Type       : 变量类型，例如“int”
hi Type         term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"Underlined : 文本下划线。
hi Underlined   term=underline cterm=underline ctermfg=33 gui=underline guifg=#3794ff
hi Ignore       ctermfg=237 guifg=bg
hi Error        term=reverse ctermfg=231 ctermbg=124 guifg=#ffffff guibg=#aa1414
hi Todo         term=standout ctermfg=17 ctermbg=226 guifg=#000030 guibg=#eeee00
"String     : 字符串
hi String       term=none cterm=none ctermfg=108 gui=none guifg=#809980
hi Character    term=none cterm=none ctermfg=108 gui=none guifg=#809980
"Number     : 数字
hi Number       term=none cterm=none ctermfg=45 gui=none guifg=#00e8ef
"Function   : 函数名
hi Function     term=none cterm=none ctermfg=113 gui=none guifg=#96E072
"Structure  : 结构体
hi Structure    term=none cterm=none ctermfg=202 gui=none guifg=#ee5d43
"自定义-Variables
hi Variables    term=none cterm=none ctermfg=187 gui=none guifg=#d4d4b0
hi clear Typedef
hi! link Typedef Structure
hi ThinTitle    term=none cterm=none ctermfg=214 gui=none guifg=#f39c12
hi Annotation   term=none cterm=none ctermfg=34 gui=none guifg=#00af00
hi clear SpecialComment
hi! link SpecialComment Comment
hi CommonTag    term=none cterm=none ctermfg=244 gui=none guifg=#808080
hi Interface    term=none cterm=none ctermfg=170 gui=none guifg=#dd50dd
hi EnumMember   term=none cterm=none ctermfg=39 gui=none guifg=#4fc1ff
hi Property     term=none cterm=none ctermfg=43 gui=none guifg=#4ec9b0
hi Parameter    term=none cterm=none ctermfg=66 gui=none guifg=#4d8a94
hi Struct       term=none cterm=none ctermfg=202 gui=none guifg=#ee5d43
hi Regexp       term=none cterm=none ctermfg=60 gui=none guifg=#646695
hi Macro        term=none cterm=none ctermfg=75 gui=none guifg=#569cd6
hi Lifetime     term=none cterm=none ctermfg=189 gui=none guifg=#cdcdff
hi BreakPoint   term=none cterm=none ctermfg=160 gui=none guifg=#e51400
hi BreakPointDisabled   term=none cterm=none ctermfg=102 gui=none guifg=#848484
hi ProgramCounter   term=reverse ctermbg=17 guibg=#292e52
hi DebugLine    term=reverse ctermbg=58 guibg=#545835
"hi ToolbarLine  term=underline ctermbg=244 guibg=#7f7f7f
"hi ToolbarButton cterm=bold ctermfg=234 ctermbg=230 gui=bold guifg=#1d202f guibg=#eee8d5
hi ToolbarLine  term=underline ctermbg=60 guibg=#46475c
hi ToolbarButton cterm=bold ctermfg=234 ctermbg=73 gui=bold guifg=#1d202f guibg=#4abcc1
hi Deprecated   term=strikethrough cterm=strikethrough gui=strikethrough

"-----------------------------------------------"
"               终端高亮                        "
"-----------------------------------------------"
if has('terminal')
  hi Terminal     term=none cterm=none ctermbg=234 ctermfg=253 gui=none guibg=#1d1f21 guifg=#dadada
  let g:terminal_ansi_colors = [
  \ "#000000", "#cd3131", "#0dbc79", "#e5e510",
  \ "#2472c8", "#bc3fbc", "#11a8cd", "#e5e5e5",
  \ "#666666", "#f14c4c", "#23d18b", "#f5f543",
  \ "#3b8eea", "#d670d6", "#29b8db", "#e5e5e5"
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
hi netrwExe     term=standout ctermfg=150 guifg=#98c379

"-----------------------------------------------"
"               vim-lsp高亮                     "
"-----------------------------------------------"
hi lspReference term=reverse ctermbg=237 guibg=#3a3d41
"hi LspCodeActionText term=reverse ctermfg=16 ctermbg=143 guifg=#000000 guibg=#b5bd68
hi LspErrorText term=reverse ctermfg=231 ctermbg=196 guifg=#ffffff guibg=#ff0000
hi LspWarningText term=reverse ctermfg=16 ctermbg=226 guifg=#000000 guibg=#ffff00
hi LspInformationText term=reverse ctermfg=16 ctermbg=38 guifg=#000000 guibg=#0db9d7
hi LspHintText term=reverse ctermfg=16 ctermbg=36 guifg=#000000 guibg=#1abc9c
hi LspErrorHighlight term=standout cterm=undercurl gui=undercurl guisp=#ff0000
hi LspWarningHighlight term=standout cterm=undercurl gui=undercurl guisp=#ffff00
hi LspInformationHighlight term=standout cterm=undercurl gui=undercurl guisp=#0db9d7
hi LspHintHighlight term=standout cterm=undercurl gui=undercurl guisp=#1abc9c
hi LspErrorVirtualText term=reverse ctermfg=167 ctermbg=236 guifg=#db4b4b guibg=#362c3d
hi LspWarningVirtualText term=reverse ctermfg=179 ctermbg=237     guifg=#e0af68 guibg=#373640
hi LspInformationVirtualText term=reverse ctermfg=38 ctermbg=237 guifg=#0db9d7 guibg=#22374b
hi LspHintVirtualText term=reverse ctermfg=36 ctermbg=236 guifg=#1abc9c guibg=#233745

"-----------------------------------------------"
"               其他高亮                        "
"-----------------------------------------------"
"高亮行尾空格(包括tab)
hi ExtraWhitespace  term=standout ctermfg=239 ctermbg=52 guifg=#505050 guibg=#611414
augroup lchSyntaxGroup
  autocmd!
  autocmd Syntax * match ExtraWhitespace /\s\+$/
augroup END

"tagbar插件高亮
hi link TagbarKind ThinTitle
hi link TagbarScope ThinTitle

"-----------------------------------------------"
"               NeoVim高亮                      "
"-----------------------------------------------"
if has('nvim')
  hi clear WinSeparator
  hi! link WinSeparator VertSplit
endif
