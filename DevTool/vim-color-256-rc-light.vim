scriptencoding utf-8
"vim-color-256-rc-light.vim

"全局变量colorRcFile=1：256暗色系
"全局变量colorRcFile=2：256亮色系
"全局变量colorRcFile=3：16色系
let g:colorRcFile=2

"-----------------------------------------------"
"               颜色设置                        "
"-----------------------------------------------"
":hi 可以确认当前的设定内容
":so $VIMRUNTIME/syntax/colortest.vim 可以确认颜色
set background=light

hi Normal       term=none cterm=none ctermfg=16 ctermbg=255 gui=none guifg=#000000 guibg=#f3f3f3
"NonText       : 换行符（深灰色）
hi NonText      term=none cterm=none ctermfg=249 gui=none guifg=#b2b2b2
"SpecialKey    : TAB符（深灰色）
hi SpecialKey   term=none cterm=none ctermfg=249 gui=none guifg=#b2b2b2
"StatusLine    : 底部状态栏
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=249 ctermbg=17 gui=bold,reverse guifg=#b2b2b2 guibg=#00005f
"TabLineSel    : 上部TAB栏
hi TabLine      term=none cterm=none ctermfg=102 ctermbg=253 gui=none guifg=#8f8391 guibg=#dadada
hi TabLineSel   term=underline cterm=none ctermfg=237 ctermbg=255 gui=none guifg=#2c2c2c guibg=#f3f3f3

"Comment    : 注释(灰色)
hi Comment      term=none cterm=none ctermfg=248 gui=none guifg=#a8a8a8
"Constant   : 常量，例如数字、引号内字符串、布尔值
hi Constant     term=none cterm=none ctermfg=23 gui=none guifg=#2F5E5E
"Identifier : 标识符
hi Identifier   term=none cterm=none ctermfg=18 gui=none guifg=#0000a0
"Statement  : 编程语言的声明，一般是像“if”或“while”这样的关键字。
hi Statement    term=bold cterm=bold ctermfg=18 gui=bold guifg=#0000a0
"PreProc    : 预处理，例如C语言中的“#include”
hi PreProc      term=none cterm=none ctermfg=18 gui=none guifg=#0000a0
"Type       : 变量类型，例如“int”
hi Type         term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s”
hi Special      term=none cterm=none ctermfg=32 gui=none guifg=#001080
"Function   : 函数名
hi Function     term=none cterm=none ctermfg=22 gui=none guifg=#006400
"Underlined : 文本下划线。
"hi Underlined   term=underline cterm=underline ctermfg=21 gui=underline guifg=#0000ff

"Search     : 搜索高亮（黄底黑字）
hi Search       term=reverse cterm=none ctermfg=17 ctermbg=226 gui=none guifg=#00005f guibg=#ffff00
hi CurSearch    term=reverse cterm=none ctermfg=17 ctermbg=40 gui=none guifg=#00005f guibg=#00d700
"Cursor：光标，CursorLine : 光标所在行，CursorColumn: 光标所在列
hi Cursor       term=reverse ctermfg=231 ctermbg=234 guifg=#ffffff guibg=#1E1E1E
hi iCursor      term=reverse ctermfg=231 ctermbg=21 guifg=#ffffff guibg=#0000ff
hi CursorLine   term=reverse ctermbg=159 guibg=#96ffff
hi CursorColumn term=reverse ctermbg=159 guibg=#96ffff
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
hi Visual       term=reverse ctermbg=147 guibg=#abd6fe
hi WarningMsg   term=bold cterm=bold ctermfg=0 ctermbg=226 guifg=#000000 guibg=#ffff00
"hi Ignore       ctermfg=237 guifg=bg
hi Error        term=reverse ctermfg=231 ctermbg=196 guifg=#ffffff guibg=#ff0000
"弹出菜单
hi Pmenu        term=bold ctermfg=233 ctermbg=231 guifg=#121212 guibg=#ffffff
hi PmenuSel     term=bold ctermfg=255 ctermbg=32 guifg=#eeeeee guibg=#0060c0
hi VertSplit    term=reverse ctermfg=49 ctermbg=49 guifg=#00ffaf guibg=#00ffaf
hi DiffAdd      term=bold ctermfg=71 ctermbg=251 guifg=#50a14f guibg=#d0d0d0
hi DiffChange   term=bold ctermfg=94 ctermbg=251 guifg=#986801 guibg=#d0d0d0
hi DiffDelete   term=bold ctermfg=166 ctermbg=251 gui=bold guifg=#e45649 guibg=#d0d0d0
hi DiffText     term=reverse cterm=bold ctermfg=33 ctermbg=251 gui=bold guifg=#4078f2 guibg=#d0d0d0
hi Folded       term=standout ctermfg=23 ctermbg=255 guifg=#494b53 guibg=#fafafa
hi FoldColumn   term=standout ctermfg=145 ctermbg=254 guifg=#a0a1a7 guibg=#f0f0f0
hi SignColumn   term=standout ctermfg=1 ctermbg=255 guifg=DarkBlue guibg=#fafafa

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
