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
    autocmd FileType python setlocal formatprg=black\ -q\ 2>nul\ --skip-string-normalization\ --stdin-filename\ %\ -
    autocmd FileType python setlocal equalprg=black\ -q\ 2>nul\ --skip-string-normalization\ --stdin-filename\ %\ -
    autocmd FileType rust setlocal formatprg=rustfmt\ -q\ --edition\ 2021\ --emit\ stdout\ %
    autocmd FileType rust setlocal equalprg=rustfmt\ -q\ --edition\ 2021\ --emit\ stdout\ %
    autocmd FileType go setlocal formatprg=gofmt\ %
    autocmd FileType go setlocal equalprg=gofmt\ %
    "typescript的格式化在after/ftplugin/typescript.vim中设定
    "autocmd FileType typescript setlocal formatprg=clang-format\ --assume-filename=example.js\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0,\ Language:\ JavaScript,\ SeparateDefinitionBlocks:\ Always,\ MaxEmptyLinesToKeep:\ 1}\"
    "autocmd FileType typescript setlocal equalprg=clang-format\ --assume-filename=example.js\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0,\ Language:\ JavaScript,\ SeparateDefinitionBlocks:\ Always,\ MaxEmptyLinesToKeep:\ 1}\"
  augroup END

  " [普通模式]F9：格式化当前函数
  "在各个after/ftplugin中设置
  " [普通模式]F12：格式化当前文件
  nnoremap <F12> gggqG

endif
