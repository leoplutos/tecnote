scriptencoding utf-8
"after/syntax/css.vim

hi link cssTagName Function
hi link cssPseudoClassId Function
hi link cssAttributeSelector Special
hi link cssProp Special
hi link cssAttr Variables
hi link cssColor Variables

"syntax list cssVendor
syntax clear cssVendor
hi clear cssVendor
hi! link cssVendor NONE
