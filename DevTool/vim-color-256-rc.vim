scriptencoding utf-8
"vim-color-256-rc.vim

"全局变量colorRcFile=1：256暗色系
"全局变量colorRcFile=2：256亮色系
"全局变量colorRcFile=3：16色系
let g:colorRcFile=1

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
set background=dark

hi Normal       term=none cterm=none ctermfg=253 ctermbg=234 gui=none guifg=#D4D4D4 guibg=#1E1E1E
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=238 gui=none guifg=#444444
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=238 gui=none guifg=#444444
"StatusLine    : 底部状态栏（因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=15 ctermbg=0 gui=bold,reverse guifg=#ffffff guibg=#000000
"TabLineSel    : 上部TAB栏
hi TabLine      term=none cterm=none ctermfg=248 ctermbg=238 gui=none guifg=#a8a8a8 guibg=#444444
hi TabLineSel   term=underline cterm=none ctermfg=15 ctermbg=234 gui=none guifg=#ffffff guibg=#1E1E1E

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=241 gui=none guifg=#606060
"Constant   : 常量，例如数字、引号内字符串、布尔值
hi Constant     term=none cterm=none ctermfg=108 gui=none guifg=#809980
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。
hi Statement    term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"PreProc    : 预处理，例如C语言中的“#include”
hi PreProc      term=none cterm=none ctermfg=75 gui=none guifg=#64afef
"Type       : 变量类型，例如“int”
hi Type         term=none cterm=none ctermfg=177 gui=none guifg=#c678dd
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”
hi Special      term=none cterm=none ctermfg=123 gui=none guifg=#9CDCFE
"Function   : 函数名
hi Function     term=none cterm=none ctermfg=114 gui=none guifg=#98c379
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
hi LineNr       term=none cterm=none ctermfg=66 gui=none guifg=#6c8086
"LineNr     : 当前行号
hi CursorLineNr term=none cterm=none ctermfg=226 gui=none guifg=#ffff00
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=15 ctermbg=196 gui=bold guifg=#ffffff guibg=#ff0000
hi MoreMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi ModeMsg      term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
hi Question     term=bold cterm=bold ctermfg=143 gui=bold guifg=#b5bd68
"hi Visual       term=reverse ctermfg=16 ctermbg=250 guifg=#000000 guibg=#bcbcbc
hi Visual       term=reverse ctermbg=16 guibg=#000000
hi WarningMsg   term=bold cterm=bold ctermfg=0 ctermbg=226 guifg=#000000 guibg=#ffff00
hi Ignore       ctermfg=237 guifg=bg
hi Error        term=reverse ctermfg=15 ctermbg=196 guifg=#ffffff guibg=#ff0000
"弹出菜单
hi Pmenu        term=bold ctermfg=255 ctermbg=237 guifg=#eeeeee guibg=#303030
hi PmenuSel     term=bold ctermfg=255 ctermbg=17 guifg=#eeeeee guibg=#03385c
hi VertSplit    term=reverse ctermfg=237 ctermbg=237 guifg=#303030 guibg=#303030
hi DiffAdd      term=bold ctermbg=58 guibg=#4c4e39
hi DiffChange   term=bold ctermbg=24 guibg=#2B5B77
hi DiffDelete   term=bold ctermfg=16 ctermbg=167 gui=bold guifg=#1d1f21 guibg=#cc6666
hi DiffText     term=reverse cterm=bold ctermfg=16 ctermbg=109 gui=bold guifg=#282a2e guibg=#81a2be
hi Folded       term=standout ctermfg=245 ctermbg=16 guifg=#969896 guibg=#1d1f21
hi FoldColumn   term=standout ctermfg=11 ctermbg=16 guifg=Cyan guibg=#1d1f21
hi SignColumn   term=standout ctermfg=11 ctermbg=16 guifg=Cyan guibg=#1d1f21

"Java语言高亮设定
let java_highlight_all=1
let java_highlight_functions=1

"各种语言的函数(Function)高亮设定
if (&ft=='c' || &ft=='cpp')
  "C/C++
  syn match    cCustomParen    "?=(" contains=cParen,cCppParen
  syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
  syn match    cCustomScope    "::"
  syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
  syn match    cCustomComment  "\/\/.*$"
  syn region cCustomComment start="\/\*" end="\*\/"
  hi def link cCustomFunc Function
  hi def link cCustomClass Type
  hi link cCustomComment Comment
elseif (&ft=='java')
  "Java
  syn match javaCustomOperator "[-+&|<>=!\/~.,;:*%&^?()\[\]{}]"
  syn match javaCustomParen "?=(" contains=javaParen
  syn match javaCustomFunc "\.\s*\w\+\s*(\@=" contains=javaCustomOperator,javaCustomParen
  syn match javaCustomComment "\/\/.*$"
  syn region javaFuncDef start=+^\s\+\(\(public\|protected\|private\|static\|abstract\|final\|native\|synchronized\)\s\+\)*\(\(void\|boolean\|char\|byte\|short\|int\|long\|float\|double\|\([A-Za-z_][A-Za-z0-9_$]*\.\)*[A-Z][A-Za-z0-9_$]*\)\(<[^>]*>\)\=\(\[\]\)*\s\+[a-z][A-Za-z0-9_$]*\|[A-Z][A-Za-z0-9_$]*\)\s*\ze(+ end=+\ze(+ contains=javaScopeDecl,javaType,javaStorageClass,javaComment,javaLineComment,@javaClasses
  syn region javaCustomComment start="\/\*" end="\*\/"
  hi clear javaCustomOperator
  hi link javaCustomFunc Function
  hi link javaFuncDef Function
  hi link javaCustomComment Comment
  hi link javaC_JavaLang Type
elseif (&ft=='python')
  syn match pyCustomParen     "(" contains=cParen
  syn match pyCustomFunc      "\w\+\s*(" contains=pyCustomParen
  syn match pyCustomScope     "\."
  syn match pyCustomAttribute "\.\w\+" contains=pyCustomScope
  syn match pyCustomMethod    "\.\w\+\s*(" contains=pyCustomScope,pyCustomParen
  hi def link pyCustomFunc  Function
  hi def link pyCustomMethod Function
  hi def link pyCustomAttribute Identifier
elseif (&ft=='go')
  syn match goCustomParen     "(" contains=cParen
  syn match goCustomFuncDef   "func\s\+\w\+\s*(" contains=goDeclaration,goCustomParen
  syn match goCustomFunc      "import\s\+(\|\(\w\+\s*\)(" contains=goCustomParen,goImport
  syn match goCustomScope     "\."
  syn match goCustomAttribute "\.\w\+" contains=goCustomScope
  syn match goCustomMethod    "\.\w\+\s*(" contains=goCustomScope,goCustomParen
  hi def link goCustomMethod Function
  hi def link goCustomAttribute Identifier
  hi def link goCustomFuncDef Function
  hi def link goCustomFunc Function
endif
