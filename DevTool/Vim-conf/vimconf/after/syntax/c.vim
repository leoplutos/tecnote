scriptencoding utf-8
"c.vim

"C/C++
syn match    cCustomParen    "?=(" contains=cParen,cCppParen
syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
syn match    cCustomScope    "::"
syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
syn match    cCustomComment  "\/\/.*$"
syn region cCustomComment start="\/\*" end="\*\/"
hi def link cCustomFunc Function
hi def link cCustomClass Structure
hi link cCustomComment Comment
