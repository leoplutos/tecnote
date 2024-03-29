scriptencoding utf-8
"buildtask.vim

"设置tags
set tags=./.tags;,.tags

"-----------------------------------------------
"终端插件类型
let g:terminal_plugin_type = 1
if exists('*Tapi_TerminalEdit')
  "如果存在Tapi_TerminalEdit函数则为使用[vim-terminal-help]插件
  let g:terminal_plugin_type = 0
endif

"拼接发行命令的字符串
"使用[vim-terminal-help]插件时，需要在行尾加换行
function! s:contactCommand(cmdtext)
  let l:result_cmd = ''
  let l:result_cmd .= a:cmdtext
  if (g:terminal_plugin_type == 0)
    let l:result_cmd .= "\r"
  endif
  return l:result_cmd
endfunction

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
    call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
    sleep 100m
    call TerminalSend(s:contactCommand('ninja'))
  elseif filereadable(g:g_s_projectrootpath.'/CMakeLists.txt')
    "[cmake]判断CMakeLists.txt是否存在
    call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
    sleep 100m
    call TerminalSend(s:contactCommand('cmake --build build'))
  else
    "gcc编译
    make
  endif
endfunction

"C/Cpp开始运行
function! s:runGccApplication()
  let l:filename_noext = expand('%:r')
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
    call TerminalSend(s:contactCommand('chcp 65001'))
    sleep 100m
  endif
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath . '/bin/Debug'))
  sleep 100m
  if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
    call TerminalSend(s:contactCommand(l:filename_noext . '.exe'))
  else
    call TerminalSend(s:contactCommand('./' . l:filename_noext . '.exe'))
  endif
endfunction

"C/Cpp开始测试
function! s:runCTest()
endfunction

"-----------------------------------------------

"Python设定编译器
function! s:setPythonCompiler()
  if filereadable(g:g_s_projectrootpath.'/pyproject.toml')
    "读取pyproject.toml内容
    let xml = join(readfile(g:g_s_projectrootpath.'/pyproject.toml'), "\n")
    "检查是否存在tool.poetry，不存在index为-1
    let index = stridx(xml, 'tool.poetry')
    if (index >= 0)
      "Poetry工程
    else
      "普通工程
      setlocal makeprg=pylint\ %
    end
  else
    "普通工程
    setlocal makeprg=pylint\ %
  end
endfunction

"Python开始编译
function! s:runPythonBuild()
  if filereadable(g:g_s_projectrootpath.'/pyproject.toml')
    "读取pyproject.toml内容
    let xml = join(readfile(g:g_s_projectrootpath.'/pyproject.toml'), "\n")
    "检查是否存在tool.poetry，不存在index为-1
    let index = stridx(xml, 'tool.poetry')
    if (index >= 0)
      "Poetry工程
      call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
      sleep 100m
      call TerminalSend(s:contactCommand('poetry build'))
    else
      "普通工程
      make
    end
  else
    "普通工程
    make
  end
endfunction

"Python开始运行
function! s:runPythonApplication()
  let l:filename = expand('%')
  let l:filepath = expand('%:p:h')
  if filereadable(g:g_s_projectrootpath.'/pyproject.toml')
    "读取pyproject.toml内容
    let xml = join(readfile(g:g_s_projectrootpath.'/pyproject.toml'), "\n")
    "检查是否存在tool.poetry，不存在index为-1
    let index = stridx(xml, 'tool.poetry')
    if (index >= 0)
      "Poetry工程
      call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
      sleep 100m
      call TerminalSend(s:contactCommand('poetry run pyrun'))
    else
      "普通工程
      " 使用GetProjectRoot()函数找到跟目录
      let g:g_s_projectrootpath = GetProjectRoot()
      if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
        call TerminalSend(s:contactCommand('set PYTHONPATH=' . g:g_s_projectrootpath . '/src;' . g:g_s_projectrootpath . '/src/com'))
      else
        call TerminalSend(s:contactCommand('export PYTHONPATH=' . g:g_s_projectrootpath . '/src:' . g:g_s_projectrootpath . '/src/com'))
      endif
      sleep 100m
      call TerminalSend(s:contactCommand('cd ' . l:filepath))
      sleep 100m
      if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
        call TerminalSend(s:contactCommand('python ' . l:filename))
      else
        call TerminalSend(s:contactCommand('python3 ' . l:filename))
      endif
    end
  else
    "普通工程
    " 使用GetProjectRoot()函数找到跟目录
    let g:g_s_projectrootpath = GetProjectRoot()
    if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
      call TerminalSend(s:contactCommand('set PYTHONPATH=' . g:g_s_projectrootpath . '/src;' . g:g_s_projectrootpath . '/src/com'))
    else
      call TerminalSend(s:contactCommand('export PYTHONPATH=' . g:g_s_projectrootpath . '/src:' . g:g_s_projectrootpath . '/src/com'))
    endif
    sleep 100m
    call TerminalSend(s:contactCommand('cd ' . l:filepath))
    sleep 100m
    if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
      call TerminalSend(s:contactCommand('python ' . l:filename))
    else
      call TerminalSend(s:contactCommand('python3 ' . l:filename))
    endif
  end
endfunction

"Python开始测试
function! s:runPythonTest()
  if filereadable(g:g_s_projectrootpath.'/pyproject.toml')
    "读取pyproject.toml内容
    let xml = join(readfile(g:g_s_projectrootpath.'/pyproject.toml'), "\n")
    "检查是否存在tool.poetry，不存在index为-1
    let index = stridx(xml, 'tool.poetry')
    if (index >= 0)
      "Poetry工程
      call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
      sleep 100m
      call TerminalSend(s:contactCommand('poetry run pytest -s --log-level=INFO --log-cli-level=INFO'))
    else
      "普通工程
      call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
      sleep 100m
      call TerminalSend(s:contactCommand('pytest'))
    end
  else
    "普通工程
    call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
    sleep 100m
    call TerminalSend(s:contactCommand('pytest'))
  end
endfunction

"-----------------------------------------------

"Java设定编译器
function! s:setJavaCompiler()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if filereadable(g:g_s_projectrootpath.'/build.xml')
    "[ant]判断build.xml文件是否存在
    compiler ant
    "setlocal makeencoding=sjis
    "setlocal makeencoding=euc-cn
    setlocal makeencoding=gbk
  elseif filereadable(g:g_s_projectrootpath.'/pom.xml')
    "[maven]判断pom.xml文件是否存在
  elseif isdirectory(g:g_s_projectrootpath.'/.gradle')
    "[gradle]判断.gradle目录是否存在
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
    "[ant]判断build.xml文件是否存在
    exe 'lcd '.g:g_s_projectrootpath
    make
  elseif filereadable(g:g_s_projectrootpath.'/pom.xml')
    call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
    sleep 100m
    "[maven]判断pom.xml文件是否存在
    "读取pom.xml内容
    let xml = join(readfile(g:g_s_projectrootpath.'/pom.xml'), "\n")
    "检查是否存在spring-boot-，不存在index为-1
    let index = stridx(xml, 'spring-boot-')
    if (index >= 0)
      "spring工程
      call TerminalSend(s:contactCommand('mvnw clean package'))
    else
      "普通maven工程
      call TerminalSend(s:contactCommand('mvn compile'))
    end
  elseif isdirectory(g:g_s_projectrootpath.'/.gradle')
    "[gradle]判断.gradle目录是否存在
    call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
    sleep 100m
    "读取build.gradle.kts内容
    let index = -1
    if filereadable(g:g_s_projectrootpath.'/build.gradle.kts')
      let kts = join(readfile(g:g_s_projectrootpath.'/build.gradle.kts'), "\n")
      "检查是否存在spring-boot-，不存在index为-1
      let index = stridx(kts, 'spring-boot-')
    end
    if (index >= 0)
      "spring工程
      call TerminalSend(s:contactCommand('gradlew clean bootJar'))
    else
      "普通gradle工程
      call TerminalSend(s:contactCommand('gradlew build'))
    end
  else
    make
  endif
endfunction

"Java开始运行
function! s:runJavaApplication()
  let l:filename_noext = expand('%:r')
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  " 取得jar的名字
  let l:jar_file_name = globpath(g:g_s_projectrootpath.'/build_result', '*.jar', 1, 0)
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
  sleep 100m
  if filereadable(g:g_s_projectrootpath.'/build.xml')
    "[ant]判断build.xml文件是否存在
    "call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath . '/build_result'))
    "sleep 100m
    call TerminalSend(s:contactCommand('java -jar ' . l:jar_file_name))
  elseif filereadable(g:g_s_projectrootpath.'/pom.xml')
    "[maven]判断pom.xml文件是否存在
    "读取pom.xml内容
    let xml = join(readfile(g:g_s_projectrootpath.'/pom.xml'), "\n")
    "检查是否存在spring-boot-，不存在index为-1
    let index = stridx(xml, 'spring-boot-')
    if (index >= 0)
      "spring工程
      call TerminalSend(s:contactCommand('mvnw spring-boot:run'))
    else
      "普通maven工程
      call TerminalSend(s:contactCommand('mvn exec:java -Dexec.mainClass="my.mavenbatsample.App" -Dexec.args="arg0 arg1 arg2"'))
    end
  elseif isdirectory(g:g_s_projectrootpath.'/.gradle')
    "[gradle]判断.gradle目录是否存在
    "读取build.gradle.kts内容
    let index = -1
    if filereadable(g:g_s_projectrootpath.'/build.gradle.kts')
      let kts = join(readfile(g:g_s_projectrootpath.'/build.gradle.kts'), "\n")
      "检查是否存在spring-boot-，不存在index为-1
      let index = stridx(kts, 'spring-boot-')
    end
    if (index >= 0)
      "spring工程
      call TerminalSend(s:contactCommand('gradlew bootRun'))
    else
      "普通gradle工程
      call TerminalSend(s:contactCommand('gradlew run'))
    end
  else
    if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
      call TerminalSend(s:contactCommand('chcp 65001'))
      sleep 100m
    endif
    call TerminalSend(s:contactCommand('cd bin'))
    sleep 100m
    call TerminalSend(s:contactCommand('java -classpath .;../lib/* -Dfile.encoding=UTF-8 ' . l:filename_noext))
  endif
endfunction

"Java开始测试
function! s:runJavaTest()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
  sleep 100m
  if filereadable(g:g_s_projectrootpath.'/build.xml')
    "[ant]判断build.xml文件是否存在
  elseif filereadable(g:g_s_projectrootpath.'/pom.xml')
    "[maven]判断pom.xml文件是否存在
    "读取pom.xml内容
    let xml = join(readfile(g:g_s_projectrootpath.'/pom.xml'), "\n")
    "检查是否存在spring-boot-，不存在index为-1
    let index = stridx(xml, 'spring-boot-')
    if (index >= 0)
      "spring工程
      call TerminalSend(s:contactCommand('mvnw test'))
    else
      "普通maven工程
      call TerminalSend(s:contactCommand('mvn test'))
    end
  elseif isdirectory(g:g_s_projectrootpath.'/.gradle')
    "[gradle]判断.gradle目录是否存在
    "读取build.gradle.kts内容
    let index = -1
    if filereadable(g:g_s_projectrootpath.'/build.gradle.kts')
      let kts = join(readfile(g:g_s_projectrootpath.'/build.gradle.kts'), "\n")
      "检查是否存在spring-boot-，不存在index为-1
      let index = stridx(kts, 'spring-boot-')
    end
    if (index >= 0)
      "spring工程
      call TerminalSend(s:contactCommand('gradlew test'))
    else
      "普通maven工程
      call TerminalSend(s:contactCommand('gradlew test'))
    end
  else
  endif
endfunction

"-----------------------------------------------

"Rust设定编译器
function! s:setRustCompiler()
  compiler cargo
endfunction

"Rust开始运行
function! s:runRustCargoRun()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
    call TerminalSend(s:contactCommand('chcp 65001'))
    sleep 100m
  endif
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
  sleep 100m
  call TerminalSend(s:contactCommand('cargo run'))
endfunction

"Rust开始测试
function! s:runRustCargoTest()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  if (g:g_i_osflg == 1 || g:g_i_osflg == 2 || g:g_i_osflg == 3)
    call TerminalSend(s:contactCommand('chcp 65001'))
    sleep 100m
  endif
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
  sleep 100m
  call TerminalSend(s:contactCommand('cargo test'))
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

"Go设定编译器
function! s:setGoCompiler()
  compiler go
  setlocal makeprg=go\ build\ -o\ ./bin/main.exe\ ./src
endfunction
"Go开始编译
function! s:runGoBuild()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  exe 'lcd '.g:g_s_projectrootpath
  make
endfunction

"Go开始运行
function! s:runGoRun()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
  sleep 100m
  call TerminalSend(s:contactCommand('go run ./src/main.go'))
endfunction

"Go开始测试
function! s:runGoTest()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
  sleep 100m
  call TerminalSend(s:contactCommand('go test ./src/sub'))
endfunction

"-----------------------------------------------

"TypeScript设定编译器
function! s:setTsCompiler()
  compiler tsc
endfunction
"TypeScript开始编译
function! s:runTsBuild()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
  sleep 100m
  call TerminalSend(s:contactCommand('tsc -p tsconfig.json'))
endfunction
"TypeScript开始运行
function! s:runTsRun()
  " 使用GetProjectRoot()函数找到跟目录
  let g:g_s_projectrootpath = GetProjectRoot()
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
  sleep 100m
  "start在package.json的scripts处定义
  call TerminalSend(s:contactCommand('npm run start'))
endfunction
"TypeScript开始测试
function! s:runTsTest()
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
  call TerminalSend(s:contactCommand('cd ' . g:g_s_projectrootpath))
  sleep 100m
  call TerminalSend(s:contactCommand('rm .root'))
  sleep 100m
  call TerminalSend(s:contactCommand('rm .tags'))
  sleep 100m
  call TerminalSend(s:contactCommand('touch .root'))
  sleep 100m
  "call <SID>runMakeTags()
endfunction

"-----------------------------------------------"
"               编译设定                        "
"-----------------------------------------------"
function! s:runBuild()
  if (&ft=='c')
    call s:runCCppBuild()
  elseif (&ft=='python')
    "make
    call s:runPythonBuild()
  elseif (&ft=='java')
    call s:runJavaBuild()
  elseif (&ft=='rust')
    "call s:runRustCargoBuild()
    "mark c = make check = cargo check
    "mark b = make build = cargo build
    "mark t = make test = cargo test
    make b
  elseif (&ft=='go')
    call s:runGoBuild()
  elseif (&ft=='typescript' || &ft=='typescript.tsx' || &ft=='typescriptreact')
    call s:runTsBuild()
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
  elseif (&ft=='typescript' || &ft=='typescript.tsx' || &ft=='typescriptreact')
    call s:runTsRun()
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
  elseif (&ft=='typescript' || &ft=='typescript.tsx' || &ft=='typescriptreact')
    call s:runTsTest()
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
  autocmd filetype typescript,typescript.tsx,typescriptreact call s:setTsCompiler()
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
