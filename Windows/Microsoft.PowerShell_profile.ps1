#设置utf-8
#chcp 65001

#设置命令提示符
function prompt {
	#设定win_icon=NerdFont的Windows图标，最后面加了一个无法看见的空格（No-Break SpaceU+00A0）占位，实际字符：{e70f}{00A0}
	#取得字符码[convert]::ToInt32("e70f",16)  -->  59151
	$win_icon=[char]59151
	#取得字符码[convert]::ToInt32("00A0",16)  -->  160
	$no_break_space=[char]160
	#Windows图标-红色
	Write-Host "$win_icon$no_break_space" -NoNewLine -ForegroundColor Red
	$localIpAddresses =(Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4'} | Where-Object {$_.PrefixOrigin -eq 'Dhcp'}).IPAddress
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
	return " "
}
#echo "Prompt Setting Complited"

#设置环境变量
$MINGW_HOME="D:\Tools\WorkTool\C\MinGW64\bin"
$env:Path += ";" + $MINGW_HOME
$env:CARGO_HOME="D:\Tools\WorkTool\Rust\Rust_gnu_1.70"
$env:RUSTUP_HOME="D:\Tools\WorkTool\Rust\Rust_gnu_1.70"
$env:RUST_SRC_PATH="D:\Tools\WorkTool\Rust\Rust_gnu_1.70\toolchains\stable-x86_64-pc-windows-gnu\lib\rustlib\src\rust\src"
$env:GO111MODULE="on"
$env:DOCKER_HOST="tcp://localhost:3101"
$env:Path += ";" + $CARGO_HOME + "\bin"
$GIT_HOME="D:\Tools\WorkTool\Team\Git\cmd"
$env:Path += ";" + $GIT_HOME
$GITUI_HOME="D:\Tools\WorkTool\Team\gitui-win"
$env:Path += ";" + $GITUI_HOME
$LAZYGIT_HOME="D:\Tools\WorkTool\Team\Lazygit"
$env:Path += ";" + $LAZYGIT_HOME
$JAVA_HOME="D:\Tools\WorkTool\Java\jdk17.0.6"
$env:JAVA_HOME = $JAVA_HOME
$env:Path += ";" + $JAVA_HOME + "\bin"
$env:KOTLIN_HOME = "D:\Tools\WorkTool\Kotlin\kotlin-compiler-1.9.10"
$env:Path += ";" + $env:KOTLIN_HOME + "\bin"
$PYTHON_HOME="D:\Tools\WorkTool\Python\Python38-32"
$env:Path += ";" + $PYTHON_HOME
$VSCODE_HOME="D:\Tools\WorkTool\Text\VSCode-win32-x64"
$env:Path += ";" + $VSCODE_HOME
$NINJA_HOME="D:\Tools\WorkTool\C\ninja-win"
$env:Path += ";" + $NINJA_HOME
$GVIM_HOME="D:\Tools\WorkTool\Text\vim90"
$env:Path += ";" + $GVIM_HOME
$NVIM_HOME="D:\Tools\WorkTool\Text\nvim-win64\bin"
$env:Path += ";" + $NVIM_HOME
$ANT_HOME="D:\Tools\WorkTool\Java\apache-ant-1.10.13"
$env:Path += ";" + $ANT_HOME + "\bin"
$MAVEN_HOME="D:\Tools\WorkTool\Java\apache-maven-3.9.4"
$env:Path += ";" + $MAVEN_HOME + "\bin"
$NODEJS_HOME="D:\Tools\WorkTool\NodeJs\node-v18.17.1-win-x64"
$env:Path += ";" + $NODEJS_HOME
$NODEJS_GLOBAL_HOME="D:\Tools\WorkTool\NodeJs\node-v18.17.1-win-x64\node_global"
$env:Path += ";" + $NODEJS_GLOBAL_HOME
$env:GOROOT="D:\Tools\WorkTool\Go\go1.21.1.windows-amd64"
$env:GOPATH="D:\Tools\WorkTool\Go\go_global"
$env:Path += ";" + $env:GOROOT + "\bin;" + $env:GOPATH + "\bin"
$WEZTERM_HOME="D:\Tools\WorkTool\Linux\WezTerm"
$env:Path += ";" + $WEZTERM_HOME + "\bin"
$DOCKER_HOME="D:\Tools\WorkTool\Container\docker"
$env:Path += ";" + $DOCKER_HOME
#echo "Environment Variable Setting Complited"

Clear-Variable -Name MINGW_HOME
Clear-Variable -Name GIT_HOME
Clear-Variable -Name GITUI_HOME
Clear-Variable -Name LAZYGIT_HOME
Clear-Variable -Name JAVA_HOME
Clear-Variable -Name PYTHON_HOME
Clear-Variable -Name VSCODE_HOME
Clear-Variable -Name NINJA_HOME
Clear-Variable -Name GVIM_HOME
Clear-Variable -Name NVIM_HOME
Clear-Variable -Name ANT_HOME
Clear-Variable -Name MAVEN_HOME
Clear-Variable -Name NODEJS_HOME
Clear-Variable -Name NODEJS_GLOBAL_HOME
Clear-Variable -Name WEZTERM_HOME
Clear-Variable -Name DOCKER_HOME

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
