scriptencoding utf-8
"format.vim

"clang-format
"    取自VSCode扩展ms-vscode.cpptools(在LLVM文件夹下)
"prettier
"    需要NodeJs安装
"    npm install -g --save-dev --save-exact prettier
"black
"    需要Python安装
"    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple black
"rustfmt
"    安装rust后自带，如果没有运行命令
"    rustup component add rustfmt
"gofmt
"    安装go后自带
"sql-formatter
"    需要NodeJs安装
"    npm install -g sql-formatter
"toml-fmt
"    需要rust安装
"    cargo install toml-fmt

"clang-format和prettier的判断
let g:g_clang_format_flg = 0
if executable('clang-format')
  let g:g_clang_format_flg = 1
endif
let g:g_prettier_flg = 0
if executable('prettier')
  let g:g_prettier_flg = 1
endif

"按照文件类型自定义格式化
augroup lchFormatGroup
  autocmd!

  "c/cpp
  if (g:g_space_tab_flg == 0)
    "使用空格
    autocmd FileType c,cpp setlocal formatprg=clang-format\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ Never,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    autocmd FileType c,cpp setlocal equalprg=clang-format\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ Never,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
  else
    "使用TAB
    autocmd FileType c,cpp setlocal formatprg=clang-format\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    autocmd FileType c,cpp setlocal equalprg=clang-format\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
  endif

  "java/object-c/proto/c#
  if (g:g_space_tab_flg == 0)
    "使用空格
    autocmd FileType java,objc,proto,cs setlocal formatprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ Never,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    autocmd FileType java,objc,proto,cs setlocal equalprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ Never,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
  else
    "使用TAB
    autocmd FileType java,objc,proto,cs setlocal formatprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    autocmd FileType java,objc,proto,cs setlocal equalprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
  endif

  "javascript/json
  "因为clang-format和prettier都支持javascript和json，所以哪个可以运行用哪个
  if (g:g_clang_format_flg == 1)
    if (g:g_space_tab_flg == 0)
      "使用空格
      autocmd FileType javascript,json setlocal formatprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ Never,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
      autocmd FileType javascript,json setlocal equalprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ Never,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    else
      "使用TAB
      autocmd FileType javascript,json setlocal formatprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
      autocmd FileType javascript,json setlocal equalprg=clang-format\ --assume-filename=%\ --style=\"{\ BasedOnStyle:\ Google,\ UseTab:\ ForIndentation,\ IndentWidth:\ 4,TabWidth:\ 4,\ ColumnLimit:\ 0}\"
    endif
  elseif (g:g_prettier_flg == 1)
    if (g:g_space_tab_flg == 0)
      "使用空格
      autocmd FileType javascript,json setlocal equalprg=prettier\ --print-width\ 1000\ --tab-width\ 4\ --stdin-filepath\ %
      autocmd FileType javascript,json setlocal formatprg=prettier\ --print-width\ 1000\ --tab-width\ 4\ --stdin-filepath\ %
    else
      "使用TAB
      autocmd FileType javascript,json setlocal equalprg=prettier\ --print-width\ 1000\ --use-tabs\ --tab-width\ 4\ --stdin-filepath\ %
      autocmd FileType javascript,json setlocal formatprg=prettier\ --print-width\ 1000\ --use-tabs\ --tab-width\ 4\ --stdin-filepath\ %
    endif
  endif

  "python - pep8推荐使用空格
  autocmd FileType python setlocal formatprg=black\ -q\ 2>nul\ --skip-string-normalization\ --stdin-filename\ %\ -
  autocmd FileType python setlocal equalprg=black\ -q\ 2>nul\ --skip-string-normalization\ --stdin-filename\ %\ -

  "rust - rustfmt推荐使用空格
  autocmd FileType rust setlocal formatprg=rustfmt\ -q\ --edition\ 2021\ --emit\ stdout\ %
  autocmd FileType rust setlocal equalprg=rustfmt\ -q\ --edition\ 2021\ --emit\ stdout\ %

  "go - gofmt强制使用TAB
  autocmd FileType go setlocal formatprg=gofmt\ %
  autocmd FileType go setlocal equalprg=gofmt\ %

  "html/css/less/scss/jsx/vue/graphQL/markdown/yaml
  if (g:g_prettier_flg == 1)
    if (g:g_space_tab_flg == 0)
      "使用空格
      autocmd FileType html,css,less,scss,javascriptreact,vue,graphql,markdown,yaml setlocal equalprg=prettier\ --print-width\ 1000\ --tab-width\ 4\ --stdin-filepath\ %
      autocmd FileType html,css,less,scss,javascriptreact,vue,graphql,markdown,yaml setlocal formatprg=prettier\ --print-width\ 1000\ --tab-width\ 4\ --stdin-filepath\ %
    else
      "使用TAB
      autocmd FileType html,css,less,scss,javascriptreact,vue,graphql,markdown,yaml setlocal equalprg=prettier\ --print-width\ 1000\ --use-tabs\ --tab-width\ 4\ --stdin-filepath\ %
      autocmd FileType html,css,less,scss,javascriptreact,vue,graphql,markdown,yaml setlocal formatprg=prettier\ --print-width\ 1000\ --use-tabs\ --tab-width\ 4\ --stdin-filepath\ %
    endif
  endif

  "typescript在after/ftplugin/typescript.vim中设定
  "xml在after/ftplugin/xml.vim中设定

  "sql
  if executable('sql-formatter')
    autocmd FileType sql setlocal equalprg=sql-formatter
    autocmd FileType sql setlocal formatprg=sql-formatter
  endif

  "toml
  if executable('toml-fmt')
    autocmd FileType toml setlocal equalprg=toml-fmt
    autocmd FileType toml setlocal formatprg=toml-fmt
  endif

augroup END

" [普通模式]F9：格式化当前函数
"在各个after/ftplugin中设置
" [普通模式]F12：格式化当前文件
nnoremap <F12> gggqG

