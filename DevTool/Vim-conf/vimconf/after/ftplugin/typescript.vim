scriptencoding utf-8
"after/ftplugin/typescript.vim

setlocal smartindent

if(g:g_i_osflg==1 || g:g_i_osflg==2)

  nnoremap <buffer> <F10> :%!clang-format.exe --assume-filename=example.js --style="{BasedOnStyle: Google, UseTab: ForIndentation, IndentWidth: 4, TabWidth: 4, ColumnLimit: 0, Language: JavaScript, SeparateDefinitionBlocks: Always, MaxEmptyLinesToKeep: 1}"<CR>

endif
