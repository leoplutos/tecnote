scriptencoding utf-8
"after/ftplugin/typescript.vim

setlocal smartindent

if(g:g_i_osflg==1 || g:g_i_osflg==2)

  if executable('prettier')
    nnoremap <buffer> <F12> :%!prettier --print-width 1000 --use-tabs --tab-width 4 --stdin-filepath %<CR>
  elseif executable('clang-format')
    nnoremap <buffer> <F12> :%!clang-format.exe --assume-filename=example.js --style="{BasedOnStyle: Google, UseTab: ForIndentation, IndentWidth: 4, TabWidth: 4, ColumnLimit: 0, Language: JavaScript, SeparateDefinitionBlocks: Always, MaxEmptyLinesToKeep: 1}"<CR>
  endif

endif
