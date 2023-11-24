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

"-----------------------------------------------"
"               文本高亮                        "
"-----------------------------------------------"
hi Normal       term=none cterm=none ctermfg=16 ctermbg=231 gui=none guifg=#000000 guibg=#f8f8ff
"SpecialKey    : TAB符
hi SpecialKey   term=none cterm=none ctermfg=252 gui=none guifg=#d3d3d3
"NonText       : 换行符
hi NonText      term=none cterm=none ctermfg=252 gui=none guifg=#d3d3d3
hi Directory    term=none cterm=none ctermfg=18 gui=none guifg=#000087
"提示信息
hi ErrorMsg     term=bold cterm=bold ctermfg=196 ctermbg=231 gui=bold guifg=#ff0000 guibg=#f8f8ff
"Search     : 搜索高亮
hi Search       term=reverse cterm=none ctermfg=17 ctermbg=226 gui=none guifg=#00005f guibg=#ffff00
hi CurSearch    term=reverse cterm=none ctermfg=17 ctermbg=40 gui=none guifg=#00005f guibg=#00d700
hi MoreMsg      term=bold cterm=bold ctermfg=53 gui=bold guifg=#5f005f
hi ModeMsg      term=bold cterm=bold ctermfg=53 gui=bold guifg=#5f005f
"LineNr     : 行号
hi LineNr       term=none cterm=none ctermfg=66 gui=none guifg=#6c8086
hi CursorLine   term=reverse cterm=none ctermbg=158 gui=none guibg=#afffd7
hi Question     term=bold cterm=bold ctermfg=53 gui=bold guifg=#5f005f
"StatusLine    : 底部状态栏（因为设定了reverse，所以gb和fb要反过来）
hi StatusLine   term=bold,reverse cterm=bold,reverse ctermfg=189 ctermbg=17 gui=bold,reverse guifg=#cfc8f4 guibg=#00005f
hi StatusLineNC term=reverse cterm=reverse ctermfg=159 ctermbg=103 gui=reverse guifg=#afffff guibg=#79849d
"分割窗口线
hi VertSplit    term=reverse ctermfg=253 ctermbg=253 guifg=#d9d9df guibg=#d9d9df
hi Title        term=bold cterm=bold ctermfg=19 gui=bold guifg=#0000a0
hi Visual       term=reverse ctermbg=153 guibg=#abd6fe
hi VisualNOS    term=bold cterm=bold gui=bold
hi WarningMsg   term=bold cterm=bold ctermfg=94 ctermbg=231 gui=bold guifg=#8c6c3e guibg=#f8f8ff
hi WildMenu     term=standout ctermfg=236 ctermbg=157 guifg=#333333 guibg=#c1f5b0
hi Folded       term=standout cterm=none ctermfg=37 ctermbg=231 gui=none guifg=#25b0bc guibg=#fcfcfc
hi FoldColumn   term=standout ctermfg=21 ctermbg=231 guifg=#1212ff guibg=#f8f8ff
hi DiffAdd      term=bold ctermbg=187 guibg=#d7e4aa
hi DiffChange   term=bold ctermbg=189 guibg=#c9cbfe
hi DiffDelete   term=standout cterm=none ctermfg=253 ctermbg=231 gui=none guifg=#dadada guibg=#f8f8ff
hi DiffText     term=reverse cterm=bold ctermfg=252 ctermbg=67 gui=bold guifg=#d0d0d0 guibg=#567fa8
"左侧导航线（和TabLineFill相同即可）
hi SignColumn   term=standout ctermfg=26 ctermbg=255 guifg=#005fd7 guibg=#f1f1f6
hi clear Conceal
hi! link Conceal SpecialKey
hi SpellBad     term=reverse cterm=undercurl ctermfg=196 ctermbg=231 gui=undercurl guifg=#ff0000 guibg=#f8f8ff guisp=#ff0000
hi SpellCap     term=reverse cterm=undercurl ctermfg=196 ctermbg=231 gui=undercurl guifg=#ff0000 guibg=#f8f8ff guisp=#ff0000
hi SpellRare    term=reverse cterm=undercurl ctermfg=196 ctermbg=231 gui=undercurl guifg=#ff0000 guibg=#f8f8ff guisp=#ff0000
hi SpellLocal   term=underline cterm=undercurl ctermfg=196 ctermbg=231 gui=undercurl guifg=#ff0000 guibg=#f8f8ff guisp=#ff0000
"弹出菜单
hi Pmenu        ctermfg=16 ctermbg=230 guifg=#000000 guibg=#fdf7e5
hi PmenuSel     ctermfg=231 ctermbg=25 guifg=#ffffff guibg=#0060c0
hi PmenuSbar    ctermbg=251 guibg=#c6c6c6
hi PmenuThumb   ctermbg=234 guibg=#1e1e1e
hi PmenuMatch   cterm=bold ctermfg=19 gui=bold guifg=#1212af
hi PmenuMatchFuzzy cterm=bold ctermfg=33 gui=bold guifg=#3f8adb
hi PmenuDeprecated   term=strikethrough cterm=strikethrough ctermfg=146 gui=strikethrough guifg=#a8aecb guisp=#ff0000
hi PmenuFg      ctermfg=16 guifg=#000000
hi PmenuSelBg   ctermbg=25 guibg=#0060c0
"TabLine    : 上部TAB栏
hi TabLine      term=none cterm=none ctermfg=102 ctermbg=254 gui=none guifg=#8f8391 guibg=#e8e8ef
hi TabLineSel   term=underline cterm=none ctermfg=231 ctermbg=67 gui=none guifg=#f7f7f0 guibg=#5e74a2
hi TabLineFill  term=reverse cterm=none ctermfg=255 ctermbg=255 gui=none guifg=#f3f3f3 guibg=#f1f1f6
hi CursorColumn term=reverse ctermbg=158 guibg=#afffd7
"CursorLineNr     : 当前行号
hi CursorLineNr term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
hi ColorColumn  term=reverse ctermbg=254 guibg=#e8e8ef
"QuickFixLine选中行
hi QuickFixLine term=reverse cterm=none ctermbg=50 gui=none guibg=#00ffd7
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
hi Cursor       term=reverse ctermfg=255 ctermbg=16 guifg=#f9f9f9 guibg=#000000
hi iCursor      term=reverse ctermfg=255 ctermbg=21 guifg=#f9f9f9 guibg=#0000ff
hi MatchParen   term=reverse ctermbg=49 guibg=#20f5b0

"-----------------------------------------------"
"               语法高亮                        "
"-----------------------------------------------"
"Comment    : 注释
hi Comment      term=none cterm=none ctermfg=248 gui=none guifg=#70a670
"Constant   : 常量，例如__LINE__ __FILE__ __DATE__
hi Constant     term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
"Special    : 特殊符号，通常是类似字符串中的“\n”“%s” (备份 #ec5800)
hi Special      term=none cterm=none ctermfg=25 gui=none guifg=#0451a5
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
hi Error        term=reverse ctermfg=231 ctermbg=203 guifg=#ffffff guibg=#fb4040
hi Todo         term=standout ctermfg=17 ctermbg=226 guifg=#000030 guibg=#eeee00
"String     : 字符串
hi String       term=none cterm=none ctermfg=23 gui=none guifg=#2F5E5E
hi Character    term=none cterm=none ctermfg=23 gui=none guifg=#2F5E5E
"Number     : 数字
hi Number       term=none cterm=none ctermfg=33 gui=none guifg=#0087ff
"Function   : 函数名
hi Function     term=none cterm=none ctermfg=22 gui=none guifg=#006400
"Structure  : 结构体
hi Structure    term=none cterm=none ctermfg=196 gui=none guifg=#ff0000
hi Debug        term=none cterm=none ctermfg=130 gui=none guifg=#b15c00
"自定义-Variables
hi Variables    term=none cterm=none ctermfg=90 gui=none guifg=#870087
hi clear Typedef
hi! link Typedef Structure
hi ThinTitle    term=none cterm=none ctermfg=19 gui=none guifg=#0000a0
hi Annotation   term=none cterm=none ctermfg=89 gui=none guifg=#87005f
hi clear SpecialComment
hi! link SpecialComment Comment
hi CommonTag    term=none cterm=none ctermfg=88 gui=none guifg=#800000
hi Interface    term=none cterm=none ctermfg=33 gui=none guifg=#0080ff
hi EnumMember   term=none cterm=none ctermfg=25 gui=none guifg=#0070c1
hi Property     term=none cterm=none ctermfg=127 gui=none guifg=#be00be
hi Parameter    term=none cterm=none ctermfg=30 gui=none guifg=#408080
hi Struct       term=none cterm=none ctermfg=196 gui=none guifg=#ff0000
hi Regexp       term=none cterm=none ctermfg=125 gui=none guifg=#811f3f
hi Macro        term=none cterm=none ctermfg=19 gui=none guifg=#0930aa
hi Lifetime     term=none cterm=none ctermfg=18 gui=none guifg=#000087
hi BreakPoint   term=none cterm=none ctermfg=160 gui=none guifg=#e51400
hi BreakLogPoint   term=none cterm=none ctermfg=75 gui=none guifg=#61afef
hi BreakPointDisabled   term=none cterm=none ctermfg=102 gui=none guifg=#848484
hi ProgramCounter   term=reverse ctermbg=153 guibg=#cee1f2
hi DebugLine    term=reverse ctermbg=229 guibg=#e4efb3
hi DapVirtualText term=none cterm=none ctermfg=243 ctermbg=230 gui=none guifg=#7f7865 guibg=#fff1cb
"hi ToolbarLine  term=underline ctermbg=252 guibg=#d3d3d3
"hi ToolbarButton cterm=bold ctermfg=231 ctermbg=241 gui=bold guifg=#ffffff guibg=#666666
hi ToolbarLine  term=underline ctermbg=252 guibg=#d3d3d3
hi ToolbarButton cterm=bold ctermfg=231 ctermbg=241 gui=bold guifg=#ffffff guibg=#666666
hi Deprecated   term=strikethrough cterm=strikethrough gui=strikethrough guisp=#ff0000
hi FileExplorerNormal term=none cterm=none ctermfg=236 ctermbg=255 gui=none guifg=#2c2c2c guibg=#f3f3f9
hi FinderNormal term=none cterm=none ctermfg=16 ctermbg=255 gui=none guifg=#000000 guibg=#f3f3f9
hi FinderInputText term=none cterm=none ctermfg=230 ctermbg=243 gui=none guifg=#f2ebc7 guibg=#6e7476
hi FinderBorder term=none cterm=none ctermfg=103 ctermbg=255 gui=none guifg=#8d8dbf guibg=#f3f3f9
hi FinderDividingLine term=none cterm=none ctermfg=60 ctermbg=255 gui=none guifg=#535972 guibg=#f3f3f9
hi FinderFileName term=none cterm=none ctermfg=16 gui=none guifg=#000000
hi FinderLineNumber term=none cterm=none ctermfg=16 gui=none guifg=#000000
hi FinderColumnNumbe term=none cterm=none ctermfg=16 gui=none guifg=#000000
hi StartMenuHeader term=none cterm=none ctermfg=33 gui=none guifg=#2e7de9
hi StartMenuFooter term=none cterm=none ctermfg=94 gui=none guifg=#8c6c3e
hi StartMenuProjectTitle term=none cterm=none ctermfg=21 gui=none guifg=#0000ff
hi StartMenuProjectTitleIcon term=none cterm=none ctermfg=37 gui=none guifg=#00a5a8
hi StartMenuProjectIcon term=none cterm=none ctermfg=167 gui=none guifg=#d75a57
hi StartMenuMruTitle term=none cterm=none ctermfg=33 gui=none guifg=#0095f7
hi StartMenuMruIcon term=none cterm=none ctermfg=37 gui=none guifg=#00a5a8
hi StartMenuFiles term=none cterm=none ctermfg=239 gui=none guifg=#4b505a
hi StartMenuShortCut term=none cterm=none ctermfg=65 gui=none guifg=#71926c

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
hi netrwExe     term=standout ctermfg=23 guifg=#326464

"-----------------------------------------------"
"               vim-lsp高亮                     "
"-----------------------------------------------"
hi lspReference term=reverse ctermbg=153 guibg=#add6ff
hi! clear LspCodeActionText
hi LspErrorText term=reverse ctermfg=231 ctermbg=196 guifg=#ffffff guibg=#ff0000
hi LspWarningText term=reverse ctermfg=16 ctermbg=226 guifg=#000000 guibg=#ffff00
hi LspInformationText term=reverse ctermfg=16 ctermbg=33 guifg=#000000 guibg=#1a85ff
hi LspHintText term=reverse ctermfg=16 ctermbg=29 guifg=#000000 guibg=#118c74
hi LspErrorHighlight term=standout cterm=undercurl gui=undercurl guisp=#ff0000
hi LspWarningHighlight term=standout cterm=undercurl gui=undercurl guisp=#bf8803
hi LspInformationHighlight term=standout cterm=undercurl gui=undercurl guisp=#1a85ff
hi LspHintHighlight term=standout cterm=undercurl gui=undercurl guisp=#118c74
hi LspErrorVirtualText term=reverse ctermfg=196 ctermbg=224 guifg=#ff0000 guibg=#fce6dc
hi LspWarningVirtualText term=reverse ctermfg=136 ctermbg=224 guifg=#bf8803 guibg=#fce6dc
hi LspInformationVirtualText term=reverse ctermfg=33 ctermbg=224 guifg=#1a85ff guibg=#fce6dc
hi LspHintVirtualText term=reverse ctermfg=29 ctermbg=224 guifg=#118c74 guibg=#fce6dc
hi lspInlayHintsType term=reverse cterm=none ctermfg=237 ctermbg=254 gui=none guifg=#3b3b3b guibg=#e2e3e4
hi lspInlayHintsParameter term=reverse cterm=none ctermfg=237 ctermbg=254 gui=none guifg=#3b3b3b guibg=#e2e3e4
hi LspErrorFloatText term=reverse ctermfg=196 guifg=#ff0000
hi LspWarningFloatText term=reverse ctermfg=136 guifg=#bf8803
hi LspInformationFloatText term=reverse ctermfg=33 guifg=#1a85ff
hi LspHintFloatText term=reverse ctermfg=29 guifg=#118c74

"-----------------------------------------------"
"               其他高亮                        "
"-----------------------------------------------"
"日语全角空格
"hi JapaneseWhitespace term=standout ctermfg=253 ctermbg=253 guifg=#d9d9df guibg=#d9d9df
hi JapaneseWhitespace term=standout ctermfg=250 ctermbg=217 guifg=#c0c0c0 guibg=#fbaeae
"行尾空格(包括tab)
hi ExtraWhitespace    term=standout ctermfg=250 ctermbg=217 guifg=#c0c0c0 guibg=#fbaeae
"tagbar插件高亮
hi link TagbarKind ThinTitle
hi link TagbarScope ThinTitle

"-----------------------------------------------"
"               NeoVim高亮                      "
"-----------------------------------------------"
if has('nvim')
  "基础区域
  hi clear TermCursor
  hi! link TermCursor Cursor
  "TermCursorNC
  hi MsgArea term=none cterm=none ctermfg=232 gui=none guifg=#080808
  hi MsgSeparator term=none cterm=none ctermfg=146 ctermbg=235 gui=none guifg=#a9b1d6 guibg=#1f2335
  hi NormalFloat term=none cterm=none ctermfg=16 ctermbg=255 gui=none guifg=#000000 guibg=#efeff6
  hi FloatBorder term=none cterm=none ctermfg=236 ctermbg=255 gui=none guifg=#2c2c2c guibg=#efeff6
  hi FloatSelBg  term=none cterm=none ctermbg=25 gui=none guibg=#0060bc
  hi clear FloatTitle
  hi! link FloatTitle StartMenuHeader
  hi clear FloatFooter
  hi! link FloatFooter StartMenuFooter
  "hi clear NormalNC
  "hi! link NormalNC Normal
  hi clear WinSeparator
  hi! link WinSeparator VertSplit
  "hi clear PmenuKind
  "hi! link PmenuKind Pmenu
  "hi clear PmenuKindSel
  "hi! link PmenuKindSel PmenuSel
  "hi clear PmenuExtra
  "hi! link PmenuExtra PmenuSel
  "hi clear PmenuExtraSel
  "hi! link PmenuExtraSel Normal
  "hi clear Whitespace
  "hi! link Whitespace NonText
  hi clear WinBar
  "hi clear WinBarNC
  "hi! link WinBarNC WinBar
  hi Substitute term=none cterm=none ctermfg=255 ctermbg=197 gui=none guifg=#e9e9ed guibg=#f52a65

  "TreeSitter区域
  hi clear @parameter
  hi! link @parameter Parameter
  hi clear @field
  hi! link @field Identifier
  hi clear @property
  hi! link @property Property
  hi clear @variable
  hi! link @variable @lsp
  hi clear @namespace
  hi! link @namespace Property

  "Lsp区域
  hi clear LspReferenceText
  hi! link LspReferenceText lspReference
  hi clear LspReferenceRead
  hi! link LspReferenceRead lspReference
  hi clear LspReferenceWrite
  hi! link LspReferenceWrite lspReference
  hi clear LspInlayHint
  hi! link LspInlayHint lspInlayHintsParameter
  hi clear DiagnosticError
  hi! DiagnosticError ctermfg=196 guifg=#ff0000
  hi clear DiagnosticWarn
  "hi! DiagnosticWarn ctermfg=226 guifg=#ffff00
  hi! DiagnosticWarn ctermfg=136 guifg=#bf8803
  hi clear DiagnosticInfo
  hi! DiagnosticInfo ctermfg=33 guifg=#1a85ff
  hi clear DiagnosticHint
  hi! DiagnosticHint ctermfg=29 guifg=#118c74
  hi clear DiagnosticOk
  hi! DiagnosticOk ctermfg=28 guifg=#208020
  hi clear DiagnosticUnderlineError
  hi! DiagnosticUnderlineError cterm=underline gui=underline guisp=#ff0000
  hi clear DiagnosticUnderlineWarn
  hi! DiagnosticUnderlineWarn cterm=underline gui=underline guisp=#bf8803
  hi clear DiagnosticUnderlineInfo
  hi! DiagnosticUnderlineInfo cterm=underline gui=underline guisp=#1a85ff
  hi clear DiagnosticUnderlineHint
  hi! DiagnosticUnderlineHint cterm=underline gui=underline guisp=#118c74
  hi clear DiagnosticUnderlineOk
  hi! DiagnosticUnderlineOk cterm=underline gui=underline guisp=#208020
  hi clear DiagnosticVirtualTextError
  hi! link DiagnosticVirtualTextError LspErrorVirtualText
  hi clear DiagnosticVirtualTextWarn
  hi! link DiagnosticVirtualTextWarn LspWarningVirtualText
  hi clear DiagnosticVirtualTextInfo
  hi! link DiagnosticVirtualTextInfo LspInformationVirtualText
  hi clear DiagnosticVirtualTextHint
  hi! link DiagnosticVirtualTextHint LspHintVirtualText
  hi clear DiagnosticVirtualTextOk
  hi! DiagnosticVirtualTextOk term=reverse ctermfg=28 ctermbg=224 guifg=#208020 guibg=#fce6dc
  hi clear DiagnosticFloatingError
  hi! link DiagnosticFloatingError DiagnosticError
  hi clear DiagnosticFloatingWarn
  hi! link DiagnosticFloatingWarn DiagnosticWarn
  hi clear DiagnosticFloatingInfo
  hi! link DiagnosticFloatingInfo DiagnosticInfo
  hi clear DiagnosticFloatingHint
  hi! link DiagnosticFloatingHint DiagnosticHint
  hi clear DiagnosticFloatingOk
  hi! link DiagnosticFloatingOk DiagnosticOk
  hi clear DiagnosticSignError
  hi! link DiagnosticSignError LspErrorText
  hi clear DiagnosticSignWarn
  hi! link DiagnosticSignWarn LspWarningText
  hi clear DiagnosticSignInfo
  hi! link DiagnosticSignInfo LspInformationText
  hi clear DiagnosticSignHint
  hi! link DiagnosticSignHint LspHintText
  hi clear DiagnosticSignOk
  hi! DiagnosticSignOk term=reverse ctermfg=16 ctermbg=28 guifg=#000000 guibg=#208020
  hi clear DiagnosticDeprecated
  hi! link DiagnosticDeprecated Deprecated
  "hi clear DiagnosticUnnecessary
  "hi clear LspInlayHint
  "hi clear LspCodeLens
  "hi clear LspCodeLensSeparator
  "hi clear LspSignatureActiveParameter
  hi clear LspInfoBorder
  hi! link LspInfoBorder FloatBorder
  "hi clear ALEErrorSign
  "hi clear ALEWarningSign
  "hi clear DapStoppedLine
  hi clear @type
  hi! link @type Struct
  hi clear @lsp.type.class
  hi! link @lsp.type.class Struct
  hi clear @lsp.type.decorator
  hi! link @lsp.type.decorator Annotation
  hi clear @lsp.type.enum
  hi! link @lsp.type.enum Struct
  hi clear @lsp.type.enumMember
  hi! link @lsp.type.enumMember EnumMember
  hi clear @lsp.type.function
  hi! link @lsp.type.function Function
  hi clear @lsp.type.interface
  hi! link @lsp.type.interface Interface
  hi clear @lsp.type.macro
  hi! link @lsp.type.macro Macro
  hi clear @lsp.type.method
  hi! link @lsp.type.method Function
  hi clear @lsp.type.namespace
  hi! link @lsp.type.namespace Property
  hi clear @lsp.type.parameter
  hi! link @lsp.type.parameter Parameter
  hi clear @lsp.type.property
  hi! link @lsp.type.property Property
  hi clear @lsp.type.struct
  hi! link @lsp.type.struct Struct
  hi clear @lsp.type.type
  hi! link @lsp.type.type Struct
  hi clear @lsp.type.typeParameter
  hi! link @lsp.type.typeParameter Parameter
  hi clear @lsp.type.variable
  hi! link @lsp.type.variable @lsp
  hi clear @lsp.type.comment
  hi! link @lsp.type.comment Comment
  hi clear @lsp.type.number
  hi! link @lsp.type.number Number
  hi clear @lsp.type.string
  hi! link @lsp.type.string String
  hi clear @lsp.type.generic
  hi! link @lsp.type.generic Property
  hi clear @lsp.type.keyword
  hi! link @lsp.type.keyword Statement
  hi clear @lsp.type.lifetime
  hi! link @lsp.type.lifetime Lifetime
  hi clear @lsp.type.operator
  hi! link @lsp.type.operator Special
  hi clear @lsp.type.builtinType
  hi! link @lsp.type.builtinType Statement

  "ident_line区域
  hi IndentBlankLineBase cterm=nocombine ctermfg=252 gui=nocombine guifg=#d3d3d3
  hi IndentBlankLineUnderlineBase cterm=underline ctermfg=252 gui=underline guifg=#d3d3d3

  "设定neovim终端的ANCI颜色
  let g:terminal_color_0  = '#000000'
  let g:terminal_color_1  = '#cd3131'
  let g:terminal_color_2  = '#0dbc79'
  let g:terminal_color_3  = '#e5e510'
  let g:terminal_color_4  = '#2472c8'
  let g:terminal_color_5  = '#bc3fbc'
  let g:terminal_color_6  = '#11a8cd'
  let g:terminal_color_7  = '#e5e5e5'
  let g:terminal_color_8  = '#666666'
  let g:terminal_color_9  = '#f14c4c'
  let g:terminal_color_10 = '#23d18b'
  let g:terminal_color_11 = '#f5f543'
  let g:terminal_color_12 = '#3b8eea'
  let g:terminal_color_13 = '#d670d6'
  let g:terminal_color_14 = '#29b8db'
  let g:terminal_color_15 = '#e5e5e5'
endif
