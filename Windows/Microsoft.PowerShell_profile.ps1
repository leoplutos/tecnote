#设置utf-8
#chcp 65001

#设置命令提示符
function prompt {
	#计算器名-深水色
	Write-Host ($env:COMPUTERNAME) -NoNewline -ForegroundColor DarkCyan
	#:-白色
	Write-Host (":") -NoNewline -ForegroundColor White
	#当前路径-黄色
	Write-Host ($(Get-Location)) -NoNewline -ForegroundColor Yellow
	##-紫红色
	Write-Host ("#") -NoNewline -ForegroundColor Magenta
	return " "
}

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
