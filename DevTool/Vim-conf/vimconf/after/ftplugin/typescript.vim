scriptencoding utf-8
"after/ftplugin/typescript.vim

setlocal smartindent

if executable('prettier')
  if (g:g_space_tab_flg == 0)
    "使用空格
    nnoremap <buffer> <F12> :%!prettier --print-width 1000 --tab-width 4 --stdin-filepath %<CR>
  else
    "使用TAB
    nnoremap <buffer> <F12> :%!prettier --print-width 1000 --use-tabs --tab-width 4 --stdin-filepath %<CR>
  endif
elseif executable('clang-format')
  if (g:g_space_tab_flg == 0)
    "使用空格
    "根据OS设定命令
    if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
      nnoremap <buffer> <F12> :%!clang-format.exe --assume-filename=example.js --style="{BasedOnStyle: Google, UseTab: Never, IndentWidth: 4, TabWidth: 4, ColumnLimit: 0, Language: JavaScript, SeparateDefinitionBlocks: Always, MaxEmptyLinesToKeep: 1}"<CR>
    else
      nnoremap <buffer> <F12> :%!clang-format --assume-filename=example.js --style="{BasedOnStyle: Google, UseTab: Never, IndentWidth: 4, TabWidth: 4, ColumnLimit: 0, Language: JavaScript, SeparateDefinitionBlocks: Always, MaxEmptyLinesToKeep: 1}"<CR>
    endif
  else
    "使用TAB
    "根据OS设定命令
    if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
      nnoremap <buffer> <F12> :%!clang-format.exe --assume-filename=example.js --style="{BasedOnStyle: Google, UseTab: ForIndentation, IndentWidth: 4, TabWidth: 4, ColumnLimit: 0, Language: JavaScript, SeparateDefinitionBlocks: Always, MaxEmptyLinesToKeep: 1}"<CR>
    else
      nnoremap <buffer> <F12> :%!clang-format --assume-filename=example.js --style="{BasedOnStyle: Google, UseTab: ForIndentation, IndentWidth: 4, TabWidth: 4, ColumnLimit: 0, Language: JavaScript, SeparateDefinitionBlocks: Always, MaxEmptyLinesToKeep: 1}"<CR>
    endif
  endif
endif
