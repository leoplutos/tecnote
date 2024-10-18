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
::设定NerdFont的图标（需要chcp 65001）
echo SetPromptNerdFont
for /f "delims=" %%i in ('echo ╭') do (set STR_LINE1_PRE=%%i)
for /f "delims=" %%i in ('echo ╰') do (set STR_LINE2_PRE=%%i)
for /f "delims=" %%i in ('echo ') do (set STR_LEFT_SEMICIRCLE=%%i)
for /f "delims=" %%i in ('echo ') do (set STR_RIGHT_SEMICIRCLE=%%i)
for /f "delims=" %%i in ('echo ') do (set STR_LEFT_ARROW=%%i)
for /f "delims=" %%i in ('echo ') do (set STR_WIN_ICON=%%i)
for /f "delims=" %%i in ('echo ') do (set STR_TIME_ICON=%%i)
for /f "delims=" %%i in ('echo ') do (set STR_USER_ICON=%%i)
for /f "delims=" %%i in ('echo 󰩠') do (set STR_IP_ICON=%%i)
for /f "delims=" %%i in ('echo ') do (set STR_DIRECTORY_ICON=%%i)
for /f "tokens=3" %%a in ('"netsh interface ip show address "以太网" | findstr "IP Address""') do (set STR_IP=%%a)
set PS_BLACK=$E[30m
set PS_RED=$E[31m
set PS_GREEN=$E[32m
set PS_YELLOW=$E[33m
set PS_BLUE=$E[34m
set PS_MAGENTA=$E[35m
set PS_CYAN=$E[36m
set PS_BRIGHTBLACK=$E[90m
set PS_BRIGHTRED=$E[91m
set PS_BRIGHTGREEN=$E[92m
set PS_BRIGHTYELLOW=$E[93m
set PS_BRIGHTBLUE=$E[94m
set PS_BRIGHTMAGENTA=$E[95m
set PS_BRIGHTCYAN=$E[96m
set PS_CLEAR=$E[0m
set PS_TIME=$E[96;100m
set PS_SHELL=$E[90;43m
set PS_HOST=$E[37;44m
set PS_IPADDR=$E[90;106m
set PS_PATH=$E[33;100m
::暗色用
set PROMPT=%PS_MAGENTA%%STR_LINE1_PRE%%PS_BRIGHTBLACK%%STR_LEFT_SEMICIRCLE%%PS_TIME%%STR_TIME_ICON%$s$t$s%PS_SHELL%$s%STR_WIN_ICON%$scmd$s%PS_HOST%$s%STR_USER_ICON%$s%USERNAME%@%ComputerName%$s%PS_IPADDR%$s%STR_IP_ICON%$s%STR_IP%$s%PS_PATH%$s%STR_DIRECTORY_ICON%$s$s$P$s%PS_CLEAR%%PS_BRIGHTBLACK%%STR_LEFT_ARROW%%PS_CLEAR%$_%PS_MAGENTA%%STR_LINE2_PRE%%PS_BLUE%#%PS_CLEAR%$s
::set PROMPT=%PS_MAGENTA%%STR_LINE1_PRE%%PS_YELLOW%%STR_WIN_ICON%$s[cmd]%PS_GREEN%[%STR_IP%]%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_YELLOW%$P$_%PS_MAGENTA%%STR_LINE2_PRE%%PS_BLUE%#%PS_CLEAR%$s
::亮色用(qiao)
::set PROMPT=%PS_BLUE%%STR_WIN_ICON%$s[cmd]%PS_GREEN%[%STR_IP%]%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_BLACK%$P$_%PS_BLUE%#%PS_CLEAR%$s
set STR_LINE1_PRE=
set STR_LINE2_PRE=
set STR_LEFT_SEMICIRCLE=
set STR_RIGHT_SEMICIRCLE=
set STR_LEFT_ARROW=
set STR_WIN_ICON=
set STR_TIME_ICON=
set STR_USER_ICON=
set STR_IP_ICON=
set STR_DIRECTORY_ICON=
set STR_IP=
set PS_BLACK=
set PS_RED=
set PS_GREEN=
set PS_YELLOW=
set PS_BLUE=
set PS_MAGENTA=
set PS_CYAN=
set PS_BRIGHTBLACK=
set PS_BRIGHTRED=
set PS_BRIGHTGREEN=
set PS_BRIGHTYELLOW=
set PS_BRIGHTBLUE=
set PS_BRIGHTMAGENTA=
set PS_BRIGHTCYAN=
set PS_CLEAR=
set PS_TIME=
set PS_SHELL=
set PS_HOST=
set PS_IPADDR=
set PS_PATH=
echo Prompt Setting Complited
::进入用户文件夹
cd /d %USERPROFILE%
goto GoOn

:SetPromptWithOutNerdFont
echo SetPromptWithOutNerdFont
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do (set STR_IP=%%a)
set PS_BLACK=$E[30m
set PS_RED=$E[31m
set PS_GREEN=$E[32m
set PS_YELLOW=$E[33m
set PS_BLUE=$E[34m
set PS_MAGENTA=$E[35m
set PS_CYAN=$E[36m
set PS_CLEAR=$E[0m
::暗色用
set PROMPT=%PS_GREEN%[%STR_IP%]%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_YELLOW%$P$_%PS_BLUE%#%PS_CLEAR%$s
::亮色用(qiao)
::set PROMPT=%PS_GREEN%[%STR_IP%]%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_BLACK%$P$_%PS_BLUE%#%PS_CLEAR%$s
set STR_IP=
set PS_BLACK=
set PS_RED=
set PS_GREEN=
set PS_YELLOW=
set PS_BLUE=
set PS_MAGENTA=
set PS_CYAN=
set PS_CLEAR=
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
set PYTHON_HOME=D:\Tools\WorkTool\Python\Python312
set PATH=%PATH%;%PYTHON_HOME%;%PYTHON_HOME%\Scripts
::Zig
set ZIG_HOME=D:\Tools\WorkTool\Zig\zig-windows-x86_64-0.13.0
set PATH=%PATH%;%ZIG_HOME%
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
set BUF_HOME=D:\Tools\WorkTool\Build\buf
set PATH=%PATH%;%BUF_HOME%
set NINJA_HOME=D:\Tools\WorkTool\Build\ninja-win
set PATH=%PATH%;%NINJA_HOME%
::gRPC
set PROTOC_HOME=D:\Tools\WorkTool\Build\protoc-win64
set PATH=%PATH%;%PROTOC_HOME%\bin
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
