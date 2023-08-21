scriptencoding utf-8
"format.vim

if(g:g_i_osflg==1 || g:g_i_osflg==2)

  "按照文件类型自定义格式化
  augroup lchFormatGroup
    autocmd!
    autocmd FileType c,cpp setlocal formatprg=clang-format\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    autocmd FileType c,cpp setlocal equalprg=clang-format\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    autocmd FileType java,javascript,json,objc,proto,cs setlocal formatprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    autocmd FileType java,javascript,json,objc,proto,cs setlocal equalprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    autocmd FileType python setlocal formatprg=black\ -q\ 2>nul\ --stdin-filename\ %\ -
    autocmd FileType python setlocal equalprg=black\ -q\ 2>nul\ --stdin-filename\ %\ -
    autocmd FileType rust setlocal formatprg=rustfmt.exe\ %
    autocmd FileType rust setlocal equalprg=rustfmt.exe\ %
  augroup END

  " [普通模式]F9：格式化当前函数
  "在各个after/ftplugin中设置
  " [普通模式]F10：格式化当前文件
  nnoremap <F10> gggqG

endif
