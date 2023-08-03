#设置utf-8
#chcp 65001

#设置命令提示符
function prompt {
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
echo "Prompt Setting Complited"

#设置环境变量
$MINGW_HOME="D:\Tools\WorkTool\C\codeblocks-20.03mingw-nosetup\MinGW\bin"
$env:Path += ';' + $MINGW_HOME
$GIT_HOME="D:\Tools\WorkTool\Team\Git\cmd"
$env:Path += ';' + $GIT_HOME
$JAVA_HOME="D:\Tools\WorkTool\Java\jdk17.0.6"
$env:JAVA_HOME = $JAVA_HOME
$env:Path += ';' + $JAVA_HOME + "\bin"
$PYTHON_HOME="D:\Tools\WorkTool\Python\Python38-32"
$env:Path += ';' + $PYTHON_HOME
$VSCODE_HOME="D:\Tools\WorkTool\Text\VSCode-win32-x64-1.78.2"
$env:Path += ';' + $VSCODE_HOME
$NINJA_HOME="D:\Tools\WorkTool\C\ninja-win"
$env:Path += ';' + $NINJA_HOME
$GVIM_HOME="D:\Tools\WorkTool\Text\vim90"
$env:Path += ';' + $GVIM_HOME
$ANT_HOME="D:\Tools\WorkTool\Java\apache-ant-1.10.13"
$env:Path += ';' + $ANT_HOME + "\bin"
echo "Environment Variable Setting Complited"

Clear-Variable -Name MINGW_HOME
Clear-Variable -Name GIT_HOME
Clear-Variable -Name JAVA_HOME
Clear-Variable -Name PYTHON_HOME
Clear-Variable -Name VSCODE_HOME
Clear-Variable -Name NINJA_HOME
Clear-Variable -Name GVIM_HOME
Clear-Variable -Name ANT_HOME

#设置常用路径
$app="D:\WorkSpace\C\CSampleProject"
$bin=""
$log=""

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
#cd默认支持，可使用Get-Alias命令查看
#pwd默认支持，可使用Get-Alias命令查看
#mkdir默认支持，可使用Get-Alias命令查看
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
function cda {
	cd $app
}
function cdb {
	cd $bin
}
function cdl {
	cd $log
}
echo "Alias Setting Complited"

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
