scriptencoding utf-8
"after/syntax/go.vim

syn match goCustomParen     "(" contains=cParen
syn match goCustomFuncDef   "func\s\+\w\+\s*(" contains=goDeclaration,goCustomParen
syn match goCustomFunc      "import\s\+(\|\(\w\+\s*\)(" contains=goCustomParen,goImport
syn match goCustomScope     "\."
syn match goCustomAttribute "\.\w\+" contains=goCustomScope
syn match goCustomMethod    "\.\w\+\s*(" contains=goCustomScope,goCustomParen
hi def link goCustomMethod Function
hi def link goCustomAttribute Statement
hi def link goCustomFuncDef Function
hi def link goCustomFunc Function
hi link goDeclType Structure
