scriptencoding utf-8
"after/ftplugin/css.vim

setlocal smartindent

if executable('prettier') == 0
  nnoremap <buffer> <F12> gg=G
endif
