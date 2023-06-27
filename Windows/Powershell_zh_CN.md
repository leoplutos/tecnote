# PowerShell命令

## ps1 文件
ps1 文件类似 linux 的 ``~/.profile`` 文件，在 shell 初始化时会预先执行。在 PowerShell 中， ps1 文件的路径保存在 ``$Profile`` 变量中，输入
```
echo $Profile
```
能看到它的绝对路径，文件不存在则需要新建  
修改好内容保存后，每次启动PowerShell它都会自动载入。  
想手动载入可以使用点命令
```
. $Profile
```
#### 笔者的默认ps1文件
* [Microsoft.PowerShell_profile.ps1](Microsoft.PowerShell_profile.ps1)


## 提示 无法加载文件 xxx.ps1，因为在此系统上禁止运行脚本。

在Windows10上，默认的执行策略是 **Restricted**，所以无法载入ps1配置文件。详见官方文档  
[PowerShell 执行策略（官方文档）](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3)

有以下几种解决办法：  

#### 解决办法1：运行时加上参数 ``-ExecutionPolicy``（推荐）  
启动PowerShell时跟上参数，命令为
```
powershell -ExecutionPolicy RemoteSigned
```
或直接启动时跟上设定文件
```
powershell -ExecutionPolicy RemoteSigned -File "C:\Script\Test.ps1"
```

#### 解决办法2：使用命令 ``-Scope`` 参数  
启动PowerShell后
```
Set-ExecutionPolicy RemoteSigned -Scope Process -Force
```
指定范围时Process时，只有当前的session生效。

#### 解决办法3：全局修改，需要管理员权限（不推荐）  
1. ``Win + X`` 键，使用管理员身份运行power shell  
2. 输入命令 ``set-ExecutionPolicy RemoteSigned`` ，选 ``y`` 即可

## 关于转义字符
以下转义字符为 PowerShell 6.0 中新加的，旧版不可用
```
`e
`u{x}
```

## 在PowerShell使用doskey
doskey是一个主要设计用于cmd.exe的程序，而不是 PowerShell。PowerShell 以别名和函数的形式内置了更好的功能，在 Windows 10 中，您甚至必须停用 PowerShell 自己的命令行编辑才能开始让doskey工作
```
Remove-Module PSReadLine
doskey /exename=powershell.exe ll=ls $*
```
但是这样的坏处是显式卸载了PSReadLine，这意味着将失去它的所有好处。
所以更好的办法是使用 ``Set-Alias`` 函数或者直接写函数。详见笔者的 ``默认ps1文件``

## PowerShell的输出内容颜色
使用以下代码可以输出颜色
```
$colors = @'
Black DarkBlue DarkGreen DarkCyan DarkRed DarkMagenta DarkYellow Gray
DarkGray Blue Green Cyan Red Magenta Yellow White
'@ -split "\s"

foreach ($color in $colors) {
    Write-Host $color -ForegroundColor $color
}
```
