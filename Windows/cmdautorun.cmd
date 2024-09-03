::参数说明
::参数1：是否启用NerdFont图标，如果传递则启用，不传递则不启用。传递值例子：cmdautorun.cmd 1

@echo off

::设置命令提示符
::set PROMPT=$P$G
::取得Windows版本(Windows10及更高则设定Prompt)
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
set /a WIN_VERSION=VERSION+0
::如果版本大于10则设置ANSI颜色
if %WIN_VERSION% geq 10 (
    goto SetPrompt
) else (
    goto GoOn
)

:SetPrompt
::取得参数1
set "USE_NERD_FONT_FLG=%~1"
if defined USE_NERD_FONT_FLG (
  ::如果参数1存在-使用NerdFont
  chcp 65001
  goto :SetPromptNerdFont
) else (
  ::如果参数1不存在-不使用NerdFont
  goto :SetPromptWithOutNerdFont
)

:SetPromptNerdFont
::设定WIN_ICON=NerdFont的Windows图标（需要chcp 65001），最后面加了一个无法看见的空格（No-Break SpaceU+00A0）占位，实际命令：echo {e70f}{00A0}
for /f "delims=" %%i in ('echo  ') do (set WIN_ICON=%%i)
::for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do (set PS_IP=%%a)
for /f "tokens=3" %%a in ('"netsh interface ip show address "以太网" | findstr "IP Address""') do (set PS_IP=%%a)
set PS_BLACK=$E[30m
set PS_RED=$E[31m
set PS_GREEN=$E[32m
set PS_YELLOW=$E[33m
set PS_BLUE=$E[34m
set PS_MAGENTA=$E[35m
set PS_CYAN=$E[36m
set PS_CLEAR=$E[0m
set PROMPT=%PS_YELLOW%%WIN_ICON%[cmd]%PS_CLEAR%%PS_GREEN%[%PS_IP%]%PS_CLEAR%%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_YELLOW%$P%PS_CLEAR%$_%PS_BLUE%#%PS_CLEAR%$s
::亮色用
::set PROMPT=%PS_BLUE%%WIN_ICON%[cmd]%PS_CLEAR%%PS_GREEN%[%PS_IP%]%PS_CLEAR%%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_BLACK%$P%PS_CLEAR%$_%PS_BLUE%#%PS_CLEAR%$s
echo Prompt Setting Complited
::进入用户文件夹
cd /d %USERPROFILE%
goto GoOn

:SetPromptWithOutNerdFont
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do (set PS_IP=%%a)
set PS_BLACK=$E[30m
set PS_RED=$E[31m
set PS_GREEN=$E[32m
set PS_YELLOW=$E[33m
set PS_BLUE=$E[34m
set PS_MAGENTA=$E[35m
set PS_CYAN=$E[36m
set PS_CLEAR=$E[0m
set PROMPT=%PS_GREEN%[%PS_IP%]%PS_CLEAR%%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_YELLOW%$P%PS_CLEAR%$_%PS_BLUE%#%PS_CLEAR%$s
::亮色用
::set PROMPT=%PS_GREEN%[%PS_IP%]%PS_CLEAR%%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_BLACK%$P%PS_CLEAR%$_%PS_BLUE%#%PS_CLEAR%$s
echo Prompt Setting Complited
goto GoOn

:GoOn
::设置环境变量
::C
set MINGW_HOME=D:\Tools\WorkTool\C\MinGW64\bin
set PATH=%PATH%;%MINGW_HOME%
::Rust
set CARGO_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.79
set RUSTUP_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.79
set RUST_SRC_PATH=D:\Tools\WorkTool\Rust\Rust_gnu_1.79\toolchains\stable-x86_64-pc-windows-gnu\lib\rustlib\src\rust\src
set PATH=%PATH%;%CARGO_HOME%\bin
::Golang
set GO111MODULE=on
set GOROOT=D:\Tools\WorkTool\Go\go1.22.5.windows-amd64
set GOPATH=D:\Tools\WorkTool\Go\go_global
set PATH=%PATH%;%GOROOT%\bin;%GOPATH%\bin
::Java
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk-21.0.3+9
set PATH=%PATH%;%JAVA_HOME%\bin
::set ANT_HOME=D:\Tools\WorkTool\Java\apache-ant-1.10.13
::set PATH=%PATH%;%ANT_HOME%\bin
set MAVEN_HOME=D:\Tools\WorkTool\Java\apache-maven-3.9.7
set PATH=%PATH%;%MAVEN_HOME%\bin
set GRADLE_HOME=D:\Tools\WorkTool\Java\gradle-8.5
set PATH=%PATH%;%GRADLE_HOME%\bin
::Python
set PYTHON_HOME=D:\Tools\Python312
set PATH=%PATH%;%PYTHON_HOME%;%PYTHON_HOME%\Scripts
::Kotlin
set KOTLIN_HOME=D:\Tools\WorkTool\Kotlin\kotlin-compiler-1.9.10
set PATH=%PATH%;%KOTLIN_HOME%\bin
::NodeJs
set NODEJS_HOME=D:\Tools\WorkTool\Web\node-v20.15.1-win-x64
set PATH=%PATH%;%NODEJS_HOME%
set NODEJS_GLOBAL_HOME=%NODEJS_HOME%\node_global
set PATH=%PATH%;%NODEJS_GLOBAL_HOME%
::BunJs
set BUNJS_HOME=D:\Tools\WorkTool\Web\bun-windows-x64
set PATH=%PATH%;%BUNJS_HOME%
::Git
set GIT_HOME=D:\Tools\WorkTool\Team\Git\cmd
set PATH=%PATH%;%GIT_HOME%
set GITUI_HOME=D:\Tools\WorkTool\Team\gitui-win
set PATH=%PATH%;%GITUI_HOME%
set LAZYGIT_HOME=D:\Tools\WorkTool\Team\Lazygit
set PATH=%PATH%;%LAZYGIT_HOME%
::Search
set RIPGREP_HOME=D:\Tools\WorkTool\Search\ripgrep\bin
set PATH=%PATH%;%RIPGREP_HOME%
set FZF_HOME=D:\Tools\WorkTool\Search\fzf\bin
set PATH=%PATH%;%FZF_HOME%
set BAT_HOME=D:\Tools\WorkTool\Search\bat\bin
set PATH=%PATH%;%BAT_HOME%
::VSCode
set VSCODE_HOME=D:\Tools\WorkTool\Text\VSCode-win32-x64
set PATH=%PATH%;%VSCODE_HOME%
::NeoVim
::set VIM_HOME=D:\Tools\WorkTool\Team\Git\usr\bin
::set PATH=%PATH%;%VIM_HOME%
::set GVIM_HOME=D:\Tools\WorkTool\Text\vim90
::set PATH=%PATH%;%GVIM_HOME%
set NVIM_HOME=D:\Tools\WorkTool\Text\nvim-win64\bin
set PATH=%PATH%;%NVIM_HOME%
::BuildTool
set NINJA_HOME=D:\Tools\WorkTool\C\ninja-win
set PATH=%PATH%;%NINJA_HOME%
::Editor
set HELIX_HOME=D:\Tools\WorkTool\Text\helix
set PATH=%PATH%;%HELIX_HOME%
::WezTerm
set WEZTERM_HOME=D:\Tools\WorkTool\Linux\WezTerm
set PATH=%PATH%;%WEZTERM_HOME%
::Sqlite
set SQLITE3_HOME=D:\Tools\WorkTool\DB\Sqlite3
set PATH=%PATH%;%SQLITE3_HOME%
::Gobang
set GOBANG_HOME=D:\Tools\WorkTool\DB\Gobang
set PATH=%PATH%;%GOBANG_HOME%
::gRPC
set PROTOC_HOME=D:\Tools\WorkTool\Go\protoc-25.0-win64
set PATH=%PATH%;%PROTOC_HOME%\bin
set PROTOC_JAVASCRIPT_HOME=D:\Tools\WorkTool\Go\protobuf-javascript-3.21.2-win64
set PATH=%PATH%;%PROTOC_JAVASCRIPT_HOME%\bin
::Redis
set REDIS_HOME=D:\Tools\WorkTool\DB\Redis-x64-5.0.14.1
set PATH=%PATH%;%REDIS_HOME%
::Etcd
set ETCDCTL_API=3
set ENDPOINTS=localhost:2379
set ETCD_HOME=D:\Tools\WorkTool\DB\etcd-v3.5.15-windows-amd64
set PATH=%PATH%;%ETCD_HOME%
::7-Zip
set ZIP7_HOME=C:\Program Files\7-Zip
set PATH=%PATH%;%ZIP7_HOME%
::Docker
::set DOCKER_HOME=D:\Tools\WorkTool\Container\docker
::set PATH=%PATH%;%DOCKER_HOME%
::set DOCKER_HOST=tcp://localhost:3101
::echo 环境变量载入完成
echo Environment Variable Setting Complited

::设置常用路径
set personal_workspace=D:\WorkSpace
set personal_log=D:\WorkSpace\log

::设置别名
doskey ls=dir /b $*
doskey ll=dir /ONE $*
doskey llt=dir /OD $*
doskey lla=dir /a $*
doskey env=set $*
doskey which=where $*
doskey cat=type $*
doskey rm=del $*
doskey mv=move $*
doskey cp=copy $*
doskey touch=copy nul $*
doskey cd=cd /d $*
doskey pwd=chdir
doskey mkdir=md $*
doskey ps=tasklist $*
doskey traceroute=tracert $*
doskey tracepath=pathping $*
doskey ifconfig=ipconfig $*
doskey clear=cls
doskey clearb=cls
doskey shell=PowerShell $*
doskey history=doskey /history
doskey alias=doskey /macros
doskey cdw=cd /d %personal_workspace%
doskey cdl=cd /d %personal_log%
doskey lg=lazygit $*
doskey gu=gitui $*
doskey vi=vim $*
doskey vim=nvim $*
doskey vimf=vim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
doskey vimc=vim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
doskey vimv=vim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
doskey gvimf=gvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
doskey gvimc=gvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
doskey gvimv=gvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
doskey nvimf=nvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
doskey nvimc=nvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
doskey nvimv=nvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
::echo 别名载入完成，键入alias查看
echo Alias Setting Complited

@echo on

::@cmd /k
