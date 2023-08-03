::设置utf-8
::chcp 65001

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
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set PS_IP=%%a
set PS_GREEN=$E[32m
set PS_YELLOW=$E[33m
set PS_BLUE=$E[34m
set PS_MAGENTA=$E[35m
set PS_CLEAR=$E[0m
set PROMPT=%PS_GREEN%[%PS_IP%]%PS_CLEAR%%PS_MAGENTA%%USERNAME%@%ComputerName%%PS_CLEAR%:%PS_YELLOW%$P%PS_CLEAR%$_%PS_BLUE%#%PS_CLEAR%$s
echo Prompt Setting Complited
goto GoOn

:GoOn
::设置环境变量
set MINGW_HOME=D:\Tools\WorkTool\C\codeblocks-20.03mingw-nosetup\MinGW\bin
set PATH=%PATH%;%MINGW_HOME%
set CARGO_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.70
set RUSTUP_HOME=D:\Tools\WorkTool\Rust\Rust_gnu_1.70
set PATH=%PATH%;%CARGO_HOME%\bin
set GIT_HOME=D:\Tools\WorkTool\Team\Git\cmd
set PATH=%PATH%;%GIT_HOME%
set JAVA_HOME=D:\Tools\WorkTool\Java\jdk17.0.6
set PATH=%PATH%;%JAVA_HOME%\bin
set PYTHON_HOME=D:\Tools\WorkTool\Python\Python38-32
set PATH=%PATH%;%PYTHON_HOME%;%PYTHON_HOME%\Scripts
set VSCODE_HOME=D:\Tools\WorkTool\Text\VSCode-win32-x64-1.78.2
set PATH=%PATH%;%VSCODE_HOME%
set NINJA_HOME=D:\Tools\WorkTool\C\ninja-win
set PATH=%PATH%;%NINJA_HOME%
set GVIM_HOME=D:\Tools\WorkTool\Text\vim90
set PATH=%PATH%;%GVIM_HOME%
set ANT_HOME=D:\Tools\WorkTool\Java\apache-ant-1.10.13
set PATH=%PATH%;%ANT_HOME%\bin
::echo 环境变量载入完成
echo Environment Variable Setting Complited

::设置常用路径
set app=D:\WorkSpace\Rust\hello_world
set bin=D:\WorkSpace\Rust\hello_world\target\debug
set log=D:\WorkSpace\Rust\hello_world\log

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
doskey cda=cd /d %app%
doskey cdb=cd /d %bin%
doskey cdl=cd /d %log%
::echo 别名载入完成，键入alias查看
echo Alias Setting Complited

@echo on

::@cmd /k
