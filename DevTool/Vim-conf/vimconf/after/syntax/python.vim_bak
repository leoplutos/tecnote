scriptencoding utf-8
"after/syntax/python.vim

syn match pyCustomParen     "(" contains=cParen
syn match pyCustomFunc      "\w\+\s*(" contains=pyCustomParen
syn match pyCustomScope     "\."
syn match pyCustomAttribute "\.\w\+" contains=pyCustomScope
syn match pyCustomMethod    "\.\w\+\s*(" contains=pyCustomScope,pyCustomParen
hi def link pyCustomFunc  Function
hi def link pyCustomMethod Function
hi def link pyCustomAttribute Statement
