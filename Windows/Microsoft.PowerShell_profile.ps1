#设置utf-8
#chcp 65001

#可以设定的颜色 Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White
#暗色用-普通
function dark-normal {
	$localIpAddresses =(Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4'} | Where-Object {$_.PrefixOrigin -eq 'Dhcp'}).IPAddress
	#设定str_win_icon=NerdFont的Windows图标，最后面加了一个无法看见的空格（No-Break SpaceU+00A0）占位，实际字符：{e70f}{00A0}
	#取得字符码[convert]::ToInt32("e70f",16)  -->  59151
	$str_win_icon=[char]59151
	#取得字符码[convert]::ToInt32("00A0",16)  -->  160
	$no_break_space=[char]160
	#Windows图标-黄色
	Write-Host "$str_win_icon$no_break_space" -NoNewLine -ForegroundColor Blue
	Write-Host "[PowerShell]" -NoNewLine -ForegroundColor Yellow
	#ip地址-绿色
	Write-Host "[$localIpAddresses]" -NoNewLine -ForegroundColor Green
	#用户名@计算机名-品红色
	Write-Host "$env:USERNAME@$env:ComputerName" -NoNewLine -ForegroundColor Magenta
	#:-白色
	Write-Host ":" -NoNewLine -ForegroundColor White
	#当前路径-黄色(换行)
	Write-Host ($(Get-Location)) -ForegroundColor Yellow
	#井号-蓝色
	Write-Host "#" -NoNewLine -ForegroundColor Blue
}

#暗色用-nerdps
function dark-nerdps {
	$localIpAddresses =(Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4'} | Where-Object {$_.PrefixOrigin -eq 'Dhcp'}).IPAddress
	#取得字符码[convert]::ToInt32("256d",16)  -->  9581
	$str_line1_pre=[char]9581
	#取得字符码[convert]::ToInt32("2570",16)  -->  9584
	$str_line2_pre=[char]9584
	#取得字符码[convert]::ToInt32("e0b6",16)  -->  57526
	$str_left_semicircle=[char]57526
	#取得字符码[convert]::ToInt32("e0b4",16)  -->  57524
	$str_right_semicircle=[char]57524
	#取得字符码[convert]::ToInt32("e0b0",16)  -->  57520
	$str_right_arrow=[char]57520
	#取得字符码[convert]::ToInt32("e70f",16)  -->  59151
	$str_win_icon=[char]59151
	#取得字符码[convert]::ToInt32("e683",16)  -->  59011
	$str_powershell_icon=[char]59011
	#取得字符码[convert]::ToInt32("f43a",16)  -->  62522
	$str_time_icon=[char]62522
	#取得字符码[convert]::ToInt32("f007",16)  -->  61447
	$str_user_icon=[char]61447
	#取得字符码[convert]::ToInt32("f0c1",16)  -->  61633
	$str_ip_icon=[char]61633
	#取得字符码[convert]::ToInt32("f4d4",16)  -->  62676
	$str_directory_icon=[char]62676

	#第一行
	Write-Host "$str_line1_pre" -NoNewLine -ForegroundColor Magenta
	Write-Host "$str_left_semicircle" -NoNewLine -ForegroundColor DarkGray
	Write-Host "$str_time_icon $(Get-Date -Format "HH:mm:ss.ff") " -NoNewLine -ForegroundColor DarkCyan -BackgroundColor DarkGray
	Write-Host " $str_win_icon PowerShell " -NoNewLine -ForegroundColor DarkGray -BackgroundColor Yellow
	Write-Host " $str_user_icon $env:USERNAME@$env:ComputerName " -NoNewLine -ForegroundColor White -BackgroundColor DarkBlue
	Write-Host " $str_ip_icon $localIpAddresses " -NoNewLine -ForegroundColor DarkGray -BackgroundColor Cyan
	Write-Host " $str_directory_icon  $(Get-Location) " -NoNewLine -ForegroundColor Yellow -BackgroundColor DarkGray
	Write-Host "$str_right_arrow" -ForegroundColor DarkGray
	#第二行
	Write-Host "$str_line2_pre" -NoNewLine -ForegroundColor Magenta
	Write-Host "#" -NoNewLine -ForegroundColor Blue
}

#亮色用(qiao)-普通
function light-normal {
}

#设置命令提示符
function prompt {
	# 1: dark-normal
	# 2: dark-nerdps
	# 3: light-normal
	$variable = 2
	if ($variable -eq 1) {
		dark-normal
	} elseif ($variable -eq 2) {
		dark-nerdps
	} elseif ($variable -eq 2) {
		light-normal
	} else {
	}
	return " "
}
#echo "Prompt Setting Complited"

#设置环境变量
#C
$MINGW_HOME = "D:\Tools\WorkTool\C\MinGW64\bin"
$env:Path += ";" + $MINGW_HOME + ";"
#Rust
$env:CARGO_HOME = "D:\Tools\WorkTool\Rust\Rust_gnu_1.79"
$env:RUSTUP_HOME = "D:\Tools\WorkTool\Rust\Rust_gnu_1.79"
$env:RUST_SRC_PATH = "D:\Tools\WorkTool\Rust\Rust_gnu_1.79\toolchains\stable-x86_64-pc-windows-gnu\lib\rustlib\src\rust\src"
$env:RUSTUP_DIST_SERVER = "https://rsproxy.cn"
$env:RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"
$BINARYEN_HOME = "D:\Tools\WorkTool\Rust\binaryen"
$env:Path += $env:CARGO_HOME + "\bin;" + $BINARYEN_HOME + "\bin;"
#Golang
$env:GO111MODULE = "on"
$env:GOROOT = "D:\Tools\WorkTool\Go\go1.22.5.windows-amd64"
$env:GOPATH = "D:\Tools\WorkTool\Go\go_global"
$env:Path += $env:GOROOT + "\bin;" + $env:GOPATH + "\bin;"
#Java
$env:JAVA_HOME = "D:\Tools\WorkTool\Java\jdk-21.0.3+9"
$env:Path += $env:JAVA_HOME + "\bin;"
# $ANT_HOME = "D:\Tools\WorkTool\Java\apache-ant-1.10.13"
# $env:Path += ";" + $ANT_HOME + "\bin"
$env:MAVEN_HOME = "D:\Tools\WorkTool\Java\apache-maven-3.9.7"
$env:Path += $env:MAVEN_HOME + "\bin;"
#Python
$PYTHON_HOME = "D:\Tools\WorkTool\Python\Python312"
$env:Path += $PYTHON_HOME + ";" + $PYTHON_HOME + "\Scripts;"
#Zig
$ZIG_HOME = "D:\Tools\WorkTool\Zig\zig-windows-x86_64-0.13.0"
$env:Path += $ZIG_HOME + ";"
#Kotlin
$env:KOTLIN_HOME = "D:\Tools\WorkTool\Kotlin\kotlin-compiler-1.9.10"
$env:Path += $env:KOTLIN_HOME + "\bin;"
#NodeJs
$NODEJS_HOME = "D:\Tools\WorkTool\Web\node22"
$env:Path += $NODEJS_HOME + ";"
$NODEJS_GLOBAL_HOME = $NODEJS_HOME + "\node_global"
$env:Path += $NODEJS_GLOBAL_HOME + ";"
#BunJs
$BUNJS_HOME = "D:\Tools\WorkTool\Web\bun-windows-x64"
$env:Path += $BUNJS_HOME + ";"
#Deno
$DENO_HOME = "D:\Tools\WorkTool\Web\deno"
$env:Path += $DENO_HOME + ";"
#Git
$GIT_HOME = "D:\Tools\WorkTool\Team\Git\cmd"
$env:Path += $GIT_HOME + ";"
$GITUI_HOME = "D:\Tools\WorkTool\Team\gitui-win"
$env:Path += $GITUI_HOME + ";"
$LAZYGIT_HOME = "D:\Tools\WorkTool\Team\Lazygit"
$env:Path += $LAZYGIT_HOME + ";"
#Search
$RIPGREP_HOME = "D:\Tools\WorkTool\Search\ripgrep\bin"
$env:Path += $RIPGREP_HOME + ";"
$FZF_HOME = "D:\Tools\WorkTool\Search\fzf\bin"
$env:Path += $FZF_HOME + ";"
$BAT_HOME = "D:\Tools\WorkTool\Search\bat\bin"
$env:Path += $BAT_HOME + ";"
#VSCode
$VSCODE_HOME = "D:\Tools\WorkTool\Text\VSCode-win32-x64"
$env:Path += $VSCODE_HOME + ";"
#NeoVim
# $GVIM_HOME = "D:\Tools\WorkTool\Text\vim90"
# $env:Path += ";" + $GVIM_HOME
$NVIM_HOME = "D:\Tools\WorkTool\Text\nvim-win64\bin"
$env:Path += $NVIM_HOME + ";"
#BuildTool
$BUF_HOME = "D:\Tools\WorkTool\Build\buf"
$env:Path += $BUF_HOME + ";"
$NINJA_HOME = "D:\Tools\WorkTool\Build\ninja-win"
$env:Path += $NINJA_HOME + ";"
#gRPC
$PROTOC_HOME = "D:\Tools\WorkTool\Build\protoc-win64"
$env:Path += $PROTOC_HOME + "\bin;"
#Editor
$HELIX_HOME = "D:\Tools\WorkTool\Text\helix"
$env:Path += $HELIX_HOME + ";"
#WezTerm
$WEZTERM_HOME = "D:\Tools\WorkTool\Linux\WezTerm"
$env:Path += $WEZTERM_HOME + ";"
#Sqlite
$SQLITE3_HOME = "D:\Tools\WorkTool\DB\Sqlite3"
$env:Path += $SQLITE3_HOME + ";"
#Gobang
$GOBANG_HOME = "D:\Tools\WorkTool\DB\Gobang"
$env:Path += $GOBANG_HOME + ";"
#Redis
$REDIS_HOME = "D:\Tools\WorkTool\DB\Redis-x64-5.0.14.1"
$env:Path += $REDIS_HOME + ";"
#Etcd
$env:ETCDCTL_API = 3
$env:ENDPOINTS = "localhost:2379"
$ETCD_HOME = "D:\Tools\WorkTool\DB\etcd-v3.5.15-windows-amd64"
$env:Path += $ETCD_HOME + ";"
#7-Zip
$ZIP7_HOME = "C:\Program Files\7-Zip"
$env:Path += $ZIP7_HOME + ";"
#Docker
# $DOCKER_HOME = "D:\Tools\WorkTool\Container\docker"
# $env:Path += $DOCKER_HOME + ";"
# $env:DOCKER_HOST = "tcp://localhost:3101"
#Lua
$LUA_HOME = "D:\Tools\WorkTool\Lua"
$env:Path += $LUA_HOME + ";"
#echo "Environment Variable Setting Complited"

Clear-Variable -Name MINGW_HOME
Clear-Variable -Name BINARYEN_HOME
Clear-Variable -Name PYTHON_HOME
Clear-Variable -Name ZIG_HOME
Clear-Variable -Name NODEJS_HOME
Clear-Variable -Name NODEJS_GLOBAL_HOME
Clear-Variable -Name BUNJS_HOME
Clear-Variable -Name DENO_HOME
Clear-Variable -Name GIT_HOME
Clear-Variable -Name GITUI_HOME
Clear-Variable -Name LAZYGIT_HOME
Clear-Variable -Name RIPGREP_HOME
Clear-Variable -Name FZF_HOME
Clear-Variable -Name BAT_HOME
Clear-Variable -Name VSCODE_HOME
#Clear-Variable -Name GVIM_HOME
Clear-Variable -Name NVIM_HOME
Clear-Variable -Name BUF_HOME
Clear-Variable -Name NINJA_HOME
Clear-Variable -Name PROTOC_HOME
Clear-Variable -Name HELIX_HOME
Clear-Variable -Name WEZTERM_HOME
Clear-Variable -Name SQLITE3_HOME
Clear-Variable -Name GOBANG_HOME
Clear-Variable -Name REDIS_HOME
Clear-Variable -Name ETCD_HOME
Clear-Variable -Name ZIP7_HOME
#Clear-Variable -Name DOCKER_HOME
Clear-Variable -Name LUA_HOME

#设置常用路径
$personal_workspace="D:\WorkSpace"
$personal_log="D:\WorkSpace\log"

#设置别名
#Remove-Module PSReadLine
#doskey /exename=powershell.exe ll=Get-ChildItem $*
#ls默认支持，可使用Get-Alias命令查看
Set-Alias -Name ll -Value Get-ChildItem
function llt {
	Get-ChildItem | Sort-Object -Property LastWriteTime
}
function lla {
	Get-ChildItem -Force
}
function env {
	Get-ChildItem env:* | Format-List
}
function which($appsName) {
	gcm $appsName
}
#cat默认支持，可使用Get-Alias命令查看
#rm默认支持，可使用Get-Alias命令查看
#mv默认支持，可使用Get-Alias命令查看
#cp默认支持，可使用Get-Alias命令查看
function touch($filename) {
	New-Item -Name $filename -ItemType File
}
#cd默认支持，可使用Get-Alias命令查看
#pwd默认支持，可使用Get-Alias命令查看
#mkdir默认支持，可使用	命令查看
#ps默认支持，可使用Get-Alias命令查看
function traceroute($ip) {
	tracert $ip
}
function tracepath($ip) {
	pathping $ip
}
Set-Alias -Name ifconfig -Value ipconfig
#clear默认支持，可使用Get-Alias命令查看
Set-Alias -Name clearb -Value Clear-Host
Set-Alias -Name shell -Value PowerShell
function history {
	cat (Get-PSReadLineOption).HistorySavePath
}
#alias默认支持，可使用Get-Alias命令查看
function cdw {
	cd $personal_workspace
}
function cdl {
	cd $personal_log
}
Set-Alias -Name lg -Value lazygit
#Set-Alias -Name gu -Value gitui
function vimf($param) {
	vim $param --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
}
function vimc($param) {
	vim $param --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
}
function vimv($param) {
	vim $param --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
}
function gvimf($param) {
	gvim $param --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
}
function gvimc($param) {
	gvim $param --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
}
function gvimv($param) {
	gvim $param --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
}
function nvimf($param) {
	nvim $param --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
}
function nvimc($param) {
	nvim $param --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
}
function nvimv($param) {
	nvim $param --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
}
#echo "Alias Setting Complited"

#其他设定
# 设置 Tab 键补全
Set-PSReadlineKeyHandler -Key Tab -Function Complete
# 设置 Ctrl+d 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Ctrl+d" -Function MenuComplete
# 设置 Ctrl+z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo
# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key UpArrow -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchBackward()
	[Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}
# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key DownArrow -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchForward()
	[Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}
