scriptencoding utf-8
"after/ftplugin/html.vim

setlocal smartindent
syntax sync fromstart

if executable('prettier') == 0
  nnoremap <buffer> <F12> gg=G
endif
