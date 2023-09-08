scriptencoding utf-8
"buildtask.vim

"设置tags
set tags=./.tags;,.tags

"-----------------------------------------------

"C/Cpp设定编译器
function! s:setGccCompiler()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if filereadable(g:g_s_projectrootpath.'/build.ninja')
    "[ninja]判断build.ninja是否存在
  elseif filereadable(g:g_s_projectrootpath.'/CMakeLists.txt')
    "[cmake]判断CMakeLists.txt是否存在
  else
    "gcc编译
    compiler gcc
    setlocal makeprg=gcc\ -Wall\ -Werror\ -Wfatal-errors\ -Wextra\ -Wpedantic\ -fdiagnostics-color=never\ -g\ -x\ c\ -fexec-charset=utf-8\ -DLOG_USE_COLOR\ -DDEBUG\ -static-libgcc\ -std=c11\ -I../include\ -o\ ../bin/Debug/%<.exe\ %
  endif
endfunction

"C/Cpp开始编译
function! s:runCCppBuild()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if filereadable(g:g_s_projectrootpath.'/build.ninja')
    "[ninja]判断build.ninja是否存在
    call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
    sleep 100m
    let l:filename = expand("%")
    call TerminalSend("ninja\r\n")
  elseif filereadable(g:g_s_projectrootpath.'/CMakeLists.txt')
    "[cmake]判断CMakeLists.txt是否存在
    call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
    sleep 100m
    let l:filename = expand("%")
    call TerminalSend("cmake --build build\r\n")
  else
    "gcc编译
    make
  endif
endfunction

"C/Cpp开始运行
function! s:runGccApplication()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend("chcp 65001\r\n")
  sleep 100m
  let l:filename = expand("%:r")
  call TerminalSend("cd ".g:g_s_projectrootpath."\\bin\\Debug\r\n")
  sleep 100m
  call TerminalSend(l:filename.".exe\r\n")
endfunction

"C/Cpp测试
function! s:runCTest()
endfunction

"-----------------------------------------------

"Python编译设定
function! s:setPythonCompiler()
  "compiler pylint
  setlocal makeprg=pylint\ %
endfunction

"Python运行设定
function! s:runPythonApplication()
  let l:filename = expand("%")
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend("set PYTHONPATH=".g:g_s_projectrootpath."\\src;".g:g_s_projectrootpath."\\src\\com\r\n")
  sleep 100m
  call TerminalSend("python ".l:filename."\r\n")
endfunction


"Python测试设定
function! s:runPythonTest()
endfunction

"-----------------------------------------------

"Java设定编译器
function! s:setJavaCompiler()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if filereadable(g:g_s_projectrootpath.'/build.xml')
    "[ant]判断build.xml是否存在
    compiler ant
    "setlocal makeencoding=sjis
    "setlocal makeencoding=euc-cn
    setlocal makeencoding=gbk
  elseif filereadable(g:g_s_projectrootpath.'/pom.xml')
    "[maven]判断pom.xml是否存在
  else
    "javac编译
    compiler javac
    setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
    "如果编译时的编码不是utf8时需要设定makeencoding
    "setlocal makeencoding=sjis
    "setlocal makeencoding=euc-cn
    setlocal makeencoding=gbk
    setlocal makeprg=javac\ -sourcepath\ .\ -d\ ../bin\ -classpath\ .;../lib/*\ -encoding\ UTF-8\ -J-Duser.language=en\ %
  endif
endfunction

"Java开始编译
function! s:runJavaBuild()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if filereadable(g:g_s_projectrootpath.'/build.xml')
    "[ant]判断build.xml是否存在
    exe 'lcd '.g:g_s_projectrootpath
    make
  elseif filereadable(g:g_s_projectrootpath.'/pom.xml')
    "[maven]判断pom.xml是否存在
    call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
    sleep 100m
    let l:filename = expand("%")
    call TerminalSend("mvn compile\r\n")
  else
    make
  endif
endfunction

"Java运行设定
function! s:runJavaApplication()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if filereadable(g:g_s_projectrootpath.'/build.xml')
    "[ant]判断build.xml是否存在
    echo 'ant project! please run by yourself!' 
  elseif filereadable(g:g_s_projectrootpath.'/pom.xml')
    "[maven]判断pom.xml是否存在
    call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
    sleep 100m
    call TerminalSend("mvn exec:java -Dexec.mainClass=\"my.mavenbatsample.App\" -Dexec.args=\"arg0 arg1 arg2\"\r\n")
  else
    let l:filename = expand("%:r")
    call TerminalSend("cd ".g:g_s_projectrootpath."/bin\r\n")
    sleep 100m
    call TerminalSend("chcp 65001 && java -classpath \.;\.\./lib/* -Dfile\.encoding=UTF-8 ".l:filename."\r\n")
  endif
endfunction

"Java测试设定
function! s:runJavaTest()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if filereadable(g:g_s_projectrootpath.'/build.xml')
    "[ant]判断build.xml是否存在
  elseif filereadable(g:g_s_projectrootpath.'/pom.xml')
    "[maven]判断pom.xml是否存在
    call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
    sleep 100m
    let l:filename = expand("%")
    call TerminalSend("mvn test\r\n")
  else
  endif
endfunction

"-----------------------------------------------

"Rust编译设定
function! s:setRustCompiler()
  compiler cargo
endfunction
"Rust编译设定
"function! s:runRustCargoBuild()
"  call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
"  sleep 100m
"  call TerminalSend("chcp 65001 && cargo build\r\n")
"endfunction

"Rust运行设定
function! s:runRustCargoRun()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
  sleep 100m
  call TerminalSend("chcp 65001 && cargo run\r\n")
endfunction

"Rust测试设定
function! s:runRustCargoTest()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
  sleep 100m
  call TerminalSend("chcp 65001 && cargo test\r\n")
endfunction

"从这里开始的几个函数是为了修复cargo build命令的时候QuickFix的问题
function! s:cargo_quickfix_CmdPre() abort
    if &filetype ==# 'rust' && get(b:, 'current_compiler', '') ==# 'cargo' &&
         \ &makeprg =~ '\V\^cargo\ \.\*'
        let b:rust_compiler_cargo_qf_has_lcd = haslocaldir()
        let b:rust_compiler_cargo_qf_prev_cd = getcwd()
        let b:rust_compiler_cargo_qf_prev_cd_saved = 1
        let l:nearest = fnamemodify(s:cargo_nearestRootCargo(0), ':h')
        execute 'lchdir! '.l:nearest
    else
        let b:rust_compiler_cargo_qf_prev_cd_saved = 0
    endif
endfunction

function! s:cargo_quickfix_CmdPost() abort
    if exists("b:rust_compiler_cargo_qf_prev_cd_saved") && b:rust_compiler_cargo_qf_prev_cd_saved
        if b:rust_compiler_cargo_qf_has_lcd
            execute 'lchdir! '.b:rust_compiler_cargo_qf_prev_cd
        else
            execute 'chdir! '.b:rust_compiler_cargo_qf_prev_cd
        endif
        let b:rust_compiler_cargo_qf_prev_cd_saved = 0
    endif
endfunction

function! s:cargo_nearestRootCargo(is_getcwd) abort
    let l:workspace_cargo = s:cargo_nearestWorkspaceCargo(a:is_getcwd)
    if l:workspace_cargo !=# ''
        return l:workspace_cargo
    endif
    return s:nearest_cargo(a:is_getcwd)
endfunction

function! s:cargo_nearestWorkspaceCargo(is_getcwd) abort
    let l:nearest = s:nearest_cargo(a:is_getcwd)
    while l:nearest !=# ''
        for l:line in readfile(l:nearest, '', 0x100)
            if l:line =~# '\V[workspace]'
                return l:nearest
            endif
        endfor
        let l:next = fnamemodify(l:nearest, ':p:h:h')
        let l:nearest = s:nearest_cargo(0, l:next)
    endwhile
    return ''
endfunction

function! s:nearest_cargo(...) abort
    let l:is_getcwd = get(a:, 1, 0)
    if l:is_getcwd 
        let l:starting_path = get(a:, 2, getcwd())
    else
        let l:starting_path = get(a:, 2, expand('%:p:h'))
    endif

    return findfile('Cargo.toml', l:starting_path . ';')
endfunction

augroup RustCargoQuickFixHooks
    autocmd!
    autocmd QuickFixCmdPre make call <SID>cargo_quickfix_CmdPre()
    autocmd QuickFixCmdPost make call <SID>cargo_quickfix_CmdPost()
augroup END


"-----------------------------------------------

"Go编译设定
function! s:setGoCompiler()
  compiler go
  setlocal makeprg=go\ build\ -o\ ./bin/main.exe\ ./src
endfunction
"Go编译设定
function! s:runGoBuild()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  exe 'lcd '.g:g_s_projectrootpath
  make
endfunction

"Go运行设定
function! s:runGoRun()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
  sleep 100m
  call TerminalSend("go run ./src/main.go\r\n")
endfunction

"Go测试设定
function! s:runGoTest()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
  sleep 100m
  call TerminalSend("go test ./src/sub\r\n")
endfunction

"-----------------------------------------------

"运行tags生成
function! s:runMakeTags()
  " 执行[git rev-parse --show-toplevel]命令找到git的根目录
  "let l:g_s_projectrootpath = system('git rev-parse --show-toplevel')
  let g:g_s_projectrootpath = GetProjectRoot()

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

"-----------------------------------------------

"初始化工程文件夹
function! s:initProjectFolder()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend("cd ".g:g_s_projectrootpath."\r\n")
  sleep 100m
  call TerminalSend("rm .root\r\n")
  sleep 100m
  call TerminalSend("rm .tags\r\n")
  sleep 100m
  call TerminalSend("touch .root\r\n")
  sleep 100m
  "call <SID>runMakeTags()
endfunction

"-----------------------------------------------"
"               编译设定                        "
"-----------------------------------------------"
function! s:runBuild()
  if (&ft=='c')
    "make
    call s:runCCppBuild()
  elseif (&ft=='python')
    make
  elseif (&ft=='java')
    "make
    call s:runJavaBuild()
  elseif (&ft=='rust')
    "call s:runRustCargoBuild()
    "mark c = make check = cargo check
    "mark b = make build = cargo build
    "mark t = make test = cargo test
    make b
  elseif (&ft=='go')
    call s:runGoBuild()
  endif
endfunction

"-----------------------------------------------"
"               运行设定                        "
"-----------------------------------------------"
function! s:runTask()
  if (&ft=='c')
    call s:runGccApplication()
  elseif (&ft=='python')
    call s:runPythonApplication()
  elseif (&ft=='java')
    call s:runJavaApplication()
  elseif (&ft=='rust')
    call s:runRustCargoRun()
  elseif (&ft=='go')
    call s:runGoRun()
  endif
endfunction

"-----------------------------------------------"
"               运行测试                        "
"-----------------------------------------------"
function! s:runTest()
  if (&ft=='c')
    call s:runCTest()
  elseif (&ft=='python')
    call s:runPythonTest()
  elseif (&ft=='java')
    call s:runJavaTest()
  elseif (&ft=='rust')
    call s:runRustCargoTest()
  elseif (&ft=='go')
    call s:runGoTest()
  endif
endfunction

"-----------------------------------------------"
"          按照文件类型自定义编译类型           "
"-----------------------------------------------"
augroup lchBuildGroup
  autocmd!
  autocmd filetype c call s:setGccCompiler()
  autocmd filetype python call s:setPythonCompiler()
  autocmd filetype java call s:setJavaCompiler()
  autocmd filetype rust call s:setRustCompiler()
  autocmd filetype go call s:setGoCompiler()
augroup END

"-----------------------------------------------"
"               快捷键绑定                      "
"-----------------------------------------------"
" [普通模式]F9：编译
nnoremap <F9> :call <SID>runBuild()<CR>
" [普通模式]F10：运行(<SID>意思为允许使用映射中的脚本本地函数，这里用s:会报错)
nnoremap <F10> :call <SID>runTask()<CR>
" [普通模式]F11：测试
nnoremap <F11> :call <SID>runTest()<CR>

"-----------------------------------------------"
"               命令绑定                        "
"-----------------------------------------------"
"命令 :Maketag 生成tags
command! -nargs=? Maketag call <SID>runMakeTags()
"命令 :Init 初始化工程文件夹
command! -nargs=? Init call <SID>initProjectFolder()
