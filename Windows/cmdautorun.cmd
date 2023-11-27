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
::设定WIN_ICON=NerdFont的Windows图标（需要chcp 65001），最后面加了一个无法看见的空格（No-Break SpaceU+00A0）占位，实际命令：echo {e70f}{U+00A0}
for /f "delims=" %%i in ('echo  ') do (set WIN_ICON=%%i)
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do (set PS_IP=%%a)
set PS_RED=$E[31m
set PS_GREEN=$E[32m
set PS_YELLOW=$E[33m
set PS_BLUE=$E[34m
set PS_MAGENTA=$E[35m
set PS_CYAN=$E[36m
set PS_CLEAR=$E[0m
set PROMPT=%PS_RED%%WIN_ICON%%PS_CLEAR%%PS_GREEN%[%PS_IP%]%PS_CLEAR%%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_YELLOW%$P%PS_CLEAR%$_%PS_BLUE%#%PS_CLEAR%$s
echo Prompt Setting Complited
::进入用户文件夹
cd /d %USERPROFILE%
goto GoOn

:SetPromptWithOutNerdFont
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do (set PS_IP=%%a)
set PS_RED=$E[31m
set PS_GREEN=$E[32m
set PS_YELLOW=$E[33m
set PS_BLUE=$E[34m
set PS_MAGENTA=$E[35m
set PS_CYAN=$E[36m
set PS_CLEAR=$E[0m
set PROMPT=%PS_GREEN%[%PS_IP%]%PS_CLEAR%%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_YELLOW%$P%PS_CLEAR%$_%PS_BLUE%#%PS_CLEAR%$s
echo Prompt Setting Complited
goto GoOn

:GoOn
::设置环境变量
set MINGW_HOME=D:\Tools\WorkTool\C\MinGW64\bin
set PATH=%PATH%;%MINGW_HOME%
set CARGO_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.70
set RUSTUP_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.70
set RUST_SRC_PATH=D:\Tools\WorkTool\Rust\Rust_gnu_1.70\toolchains\stable-x86_64-pc-windows-gnu\lib\rustlib\src\rust\src
set GO111MODULE=on
set PATH=%PATH%;%CARGO_HOME%\bin
set GIT_HOME=D:\Tools\WorkTool\Team\Git\cmd
set PATH=%PATH%;%GIT_HOME%
set GITUI_HOME=D:\Tools\WorkTool\Team\gitui-win
set PATH=%PATH%;%GITUI_HOME%
set LAZYGIT_HOME=D:\Tools\WorkTool\Team\Lazygit
set PATH=%PATH%;%LAZYGIT_HOME%
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk17.0.6
set PATH=%PATH%;%JAVA_HOME%\bin
set KOTLIN_HOME=D:\Tools\WorkTool\Kotlin\kotlin-compiler-1.9.10
set PATH=%PATH%;%KOTLIN_HOME%\bin
set PYTHON_HOME=D:\Tools\WorkTool\Python\Python38-32
set PATH=%PATH%;%PYTHON_HOME%;%PYTHON_HOME%\Scripts
set VSCODE_HOME=D:\Tools\WorkTool\Text\VSCode-win32-x64-1.81.1
set PATH=%PATH%;%VSCODE_HOME%
set RIPGREP_HOME=D:\Tools\WorkTool\Search\ripgrep
set PATH=%PATH%;%RIPGREP_HOME%\bin
set NINJA_HOME=D:\Tools\WorkTool\C\ninja-win
set PATH=%PATH%;%NINJA_HOME%
::set VIM_HOME=D:\Tools\WorkTool\Team\Git\usr\bin
::set PATH=%PATH%;%VIM_HOME%
set GVIM_HOME=D:\Tools\WorkTool\Text\vim90
set PATH=%PATH%;%GVIM_HOME%
set NVIM_HOME=D:\Tools\WorkTool\Text\nvim-win64\bin
set PATH=%PATH%;%NVIM_HOME%
set ANT_HOME=D:\Tools\WorkTool\Java\apache-ant-1.10.13
set PATH=%PATH%;%ANT_HOME%\bin
set MAVEN_HOME=D:\Tools\WorkTool\Java\apache-maven-3.9.4
set PATH=%PATH%;%MAVEN_HOME%\bin
set NODEJS_HOME=D:\Tools\WorkTool\NodeJs\node-v18.17.1-win-x64
set PATH=%PATH%;%NODEJS_HOME%
set NODEJS_GLOBAL_HOME=D:\Tools\WorkTool\NodeJs\node-v18.17.1-win-x64\node_global
set PATH=%PATH%;%NODEJS_GLOBAL_HOME%
set GOROOT=D:\Tools\WorkTool\Go\go1.21.1.windows-amd64
set GOPATH=D:\Tools\WorkTool\Go\go_global
set PATH=%PATH%;%GOROOT%\bin;%GOPATH%\bin
set WEZTERM_HOME=D:\Tools\WorkTool\Linux\WezTerm
set PATH=%PATH%;%WEZTERM_HOME%
set SQLITE3_HOME=D:\Tools\WorkTool\DB\Sqlite3
set PATH=%PATH%;%SQLITE3_HOME%
set GOBANG_HOME=D:\Tools\WorkTool\DB\Gobang
set PATH=%PATH%;%GOBANG_HOME%
set PROTOC_HOME=D:\Tools\WorkTool\Go\protoc-25.0-win64
set PATH=%PATH%;%PROTOC_HOME%\bin
set PROTOC_JAVASCRIPT_HOME=D:\Tools\WorkTool\Go\protobuf-javascript-3.21.2-win64
set PATH=%PATH%;%PROTOC_JAVASCRIPT_HOME%\bin
set REDIS_HOME=D:\Tools\WorkTool\DB\Redis\Redis-x64-5.0.14.1
set PATH=%PATH%;%REDIS_HOME%
set ZIP7_HOME=C:\Program Files\7-Zip
set PATH=%PATH%;%ZIP7_HOME%
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
doskey viml=vim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 0"
doskey vimd=vim $* --cmd "let g:g_use_lsp = 0 | let g:g_use_dap = 1"
doskey vimf=vim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
doskey vimc=vim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
doskey vimv=vim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
doskey vima=vim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 2"
doskey gviml=gvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 0"
doskey gvimd=gvim $* --cmd "let g:g_use_lsp = 0 | let g:g_use_dap = 1"
doskey gvimf=gvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
doskey gvimc=gvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
doskey gvimv=gvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
doskey gvima=gvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 2"
doskey nviml=nvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 0"
doskey nvimd=nvim $* --cmd "let g:g_use_lsp = 0 | let g:g_use_dap = 1"
doskey nvimf=nvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
doskey nvimc=nvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
doskey nvimv=nvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
doskey nvima=nvim $* --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 2"
::echo 别名载入完成，键入alias查看
echo Alias Setting Complited

@echo on

::@cmd /k
