scriptencoding utf-8
"syntax/mustache.vim

" Quit if a syntax file was already loaded.
if exists("b:current_syntax")
  finish
endif

" We have a collection of html, css and javascript wrapped in
" tags. The default HTML syntax highlight works well enough.
runtime! syntax/html.vim

"高亮css
syntax include @css syntax/css.vim
syntax region mustache_css start=/<style/ end=+</style>+me=s-1 keepend fold contains=@css,mustacheSurroundingTag

syn region  mustacheSurroundingTag   contained start=+<\(script\|style\|template\)+ end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent
syn keyword htmlSpecialTagName  contained template
syn keyword htmlArg             contained scoped ts
syn match   htmlArg "[@v:][-:.0-9_a-z]*\>" contained

"syn region  mustachePartial start=/{{[<>]/lc=2 end=/}}/me=e-2
syn region  mustachePartial start=/{{[<>]/ end=/}}/ oneline
syn region  mustacheAttri start=/{{/ end=/}}/ contains=mustachePartial oneline

syntax sync fromstart

let b:current_syntax = "mustache"

hi link htmlTagN Structure
"hi link htmlTag Special
hi link jsObjectKey Property
hi link jsObjectProp Property
hi link jsObjectShorthandProp Structure
hi link jsThis Statement
hi link jsFuncArgs Parameter
hi link mustachePartial Property
hi link mustacheAttri Special
