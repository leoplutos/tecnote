scriptencoding utf-8
"buildtask.vim

"设置tags
set tags=./.tags;,.tags

"GCC编译设定
function! s:setGccCompiler()
  compiler gcc
  setlocal makeprg=gcc\ -Wall\ -Werror\ -Wfatal-errors\ -Wextra\ -Wpedantic\ -fdiagnostics-color=never\ -g\ -x\ c\ -fexec-charset=utf-8\ -DLOG_USE_COLOR\ -DDEBUG\ -static-libgcc\ -std=c11\ -I../include\ -o\ ../bin/Debug/%<.exe\ %
endfunction

"Python编译设定
function! s:setPythonCompiler()
  compiler pylint
  setlocal makeprg=python\ %
endfunction

"Java编译设定
function! s:setJavaCompiler()
  compiler javac
  setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
  "如果编译时的编码不是utf8时需要设定makeencoding
  "setlocal makeencoding=sjis
  setlocal makeencoding=euc-cn
  setlocal makeprg=javac\ -sourcepath\ .\ -d\ ../bin\ -classpath\ .;../lib/*\ -encoding\ UTF-8\ -J-Duser.language=en\ %
endfunction

"Rust编译设定
function! s:setRustCompiler()
  compiler cargo
  setlocal makeprg=cargo\ build
endfunction

"GCC运行设定
function! s:runGccApplication()
  let l:filename = expand("%:r")
  "call TerminalOpen()
  "let bid = get(t:, '__terminal_bid__', -1)
  "call term_sendkeys(bid, "chcp 65001 && ..\\bin\\Debug\\".l:filename.".exe\r\n")
  call TerminalSend("chcp 65001 && ..\\bin\\Debug\\".l:filename.".exe\r\n")
endfunction

"Python运行设定
function! s:runPythonApplication()
  let l:filename = expand("%")
  call TerminalSend("python ".l:filename."\r\n")
endfunction

"Java运行设定
function! s:runJavaApplication()
  let l:filename = expand("%:r")
  call TerminalSend("cd ../bin\r\n")
  sleep 100m
  call TerminalSend("chcp 65001 && java -classpath \.;\.\./lib/* -Dfile\.encoding=UTF-8 ".l:filename."\r\n")
endfunction

"Rust编译设定
function! s:runRustCargoBuild()
  call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
  sleep 100m
  call TerminalSend("chcp 65001 && cargo build\r\n")
endfunction
"Rust运行设定
function! s:runRustCargoRun()
  call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
  sleep 100m
  call TerminalSend("chcp 65001 && cargo run\r\n")
endfunction

"按照文件类型自定义编译类型
augroup lchBuildGroup
  autocmd!
  autocmd filetype c call s:setGccCompiler()
  autocmd filetype python call s:setPythonCompiler()
  autocmd filetype java call s:setJavaCompiler()
  autocmd filetype rust call s:setRustCompiler()
augroup END

"编译设定
function! s:runBuild()
  if (&ft=='c')
    make
  elseif (&ft=='python')
    make
  elseif (&ft=='java')
    make
  elseif (&ft=='rust')
    "call s:runRustCargoBuild()
    make
  endif
endfunction

"运行设定
function! s:runTask()
  if (&ft=='c')
    call s:runGccApplication()
  elseif (&ft=='python')
    call s:runPythonApplication()
  elseif (&ft=='java')
    call s:runJavaApplication()
  elseif (&ft=='rust')
    call s:runRustCargoRun()
  endif
endfunction

" [普通模式]F5：编译
nnoremap <F5> :call <SID>runBuild()<CR>
" [普通模式]F6：运行(<SID>意思为允许使用映射中的脚本本地函数，这里用s:会报错)
nnoremap <F6> :call <SID>runTask()<CR>

"运行tags生成
function! s:runMakeTags()
  " 执行[git rev-parse --show-toplevel]命令找到git的根目录
  "let l:g_s_projectrootpath = system('git rev-parse --show-toplevel')

  " 取得当前目录
  let l:cache_pwd = ''
  redir => l:cache_pwd
    silent pwd
  redir END
  let l:cache_pwd = substitute(l:cache_pwd, '[\r\n]', '', 'g')

  " 设定ctags参数
  "let l:opt = '--append=yes --recurse=yes --langmap=C:+.pc --c-kinds=defghlmstuvxzLD --output-format=e-ctags'
  "if &filetype ==# 'c'
  "  let l:opt = l:opt.' --languages=C'
  "elseif &filetype !=# ''
  "  let l:opt = l:opt.' --languages='.&filetype
  "endif
  let l:opt = '--append=yes --recurse=yes --langmap=C:+.pc --c-kinds=defghlmstuvxzLD --output-format=e-ctags'

  " 设定ctags文件名
  let l:tagfile = '.tags'

  " 生成ctags文件
  try
    exe 'lcd '.g:g_s_projectrootpath
    "call system('ctags --tag-relative --recurse --sort=yes --append=no '.l:opt.' -f '.l:tagfile.' '.g:g_s_projectrootpath) " 用绝对路径生成
    call system('ctags '.l:opt.' -f '.l:tagfile)
    echo 'done'
  catch
    echo 'error:' . v:exception
  finally
    exe 'lcd '.l:cache_pwd
  endtry
endfunction

" [普通模式]F7：生成tags
nnoremap <F7> :call <SID>runMakeTags()<CR>

"初始化工程文件夹
function! s:initProjectFolder()
  call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
  sleep 100m
  call TerminalSend("rm .root\r\n")
  sleep 100m
  call TerminalSend("rm .tags\r\n")
  sleep 100m
  call TerminalSend("touch .root\r\n")
  sleep 100m
  call <SID>runMakeTags()
endfunction

" [普通模式]F8：初始化工程文件夹
nnoremap <F8> :call <SID>initProjectFolder()<CR>
