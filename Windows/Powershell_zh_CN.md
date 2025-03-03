# PowerShell命令

## ps1 文件
ps1 文件类似 linux 的 ``~/.profile`` 文件，在 shell 初始化时会预先执行。在 PowerShell 中， ps1 文件的路径保存在 ``$Profile`` 变量中，输入
```bash
echo $Profile
```
能看到它的绝对路径，文件不存在则需要新建  
修改好内容保存后，每次启动PowerShell它都会自动载入。  
想手动载入可以使用点命令
```bash
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
```bash
powershell -ExecutionPolicy RemoteSigned
```
或直接启动时跟上设定文件
```bash
powershell -ExecutionPolicy RemoteSigned -File "C:\Script\Test.ps1"
```

#### 解决办法2：使用命令 ``-Scope`` 参数  
启动PowerShell后
```bash
Set-ExecutionPolicy RemoteSigned -Scope Process -Force
```
指定范围时Process时，只有当前的session生效。

#### 解决办法3：全局修改，需要管理员权限（不推荐）  
1. ``Win + X`` 键，使用管理员身份运行power shell  
2. 修改当前用户
```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
确认
```bash
Get-ExecutionPolicy -List
```
删除当前用户
```bash
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
```

## 提示 无法加载文件 xxx.ps1，未对文件 xxx.ps1 进行数字签名。无法在当前系统上运行该脚本
右键需要运行的 ps1脚本文件 → 属性 → 选择 ``解除锁定`` 后即可

## 在PowerShell测试TCP网络端口

比如想测试 IP ``172.30.8.172`` 的TCP端口 ``9500`` 是否可用

### 方法1（推荐）
```bash
(New-Object System.Net.Sockets.TcpClient).ConnectAsync("172.30.8.172", 9500).Wait(100)
```

### 方法2
```bash
Test-NetConnection -ComputerName 172.30.8.172 -Port 9500
```

## 关于转义字符
以下转义字符为 PowerShell 6.0 中新加的，旧版不可用
```bash
`e
`u{x}
```

## 在PowerShell使用doskey
doskey是一个主要设计用于cmd.exe的程序，而不是 PowerShell。PowerShell 以别名和函数的形式内置了更好的功能，在 Windows 10 中，您甚至必须停用 PowerShell 自己的命令行编辑才能开始让doskey工作
```bash
Remove-Module PSReadLine
doskey /exename=powershell.exe ll=ls $*
```
但是这样的坏处是显式卸载了PSReadLine，这意味着将失去它的所有好处。
所以更好的办法是使用 ``Set-Alias`` 函数或者直接写函数。详见笔者的 ``默认ps1文件``

## 其他

### PowerShell的输出内容颜色
使用以下代码可以输出颜色
```bash
$colors = @'
Black DarkBlue DarkGreen DarkCyan DarkRed DarkMagenta DarkYellow Gray
DarkGray Blue Green Cyan Red Magenta Yellow White
'@ -split "\s"

foreach ($color in $colors) {
    Write-Host $color -ForegroundColor $color
}
```

### 使用 PowerShell 修改文件名

安装文件创建日期重命名文件

```bash
cd D:\pathto

Get-ChildItem |Foreach-Object { Rename-Item $_ -NewName ("{0}{1}" -f $_.CreationTime.ToString('yyyy-MM-dd-HH-mm-ss'),$_.Extension)  }

# Get-ChildItem |Foreach-Object { Rename-Item $_ -NewName ("{0}-{1}{2}" -f $_.BaseName,$_.LastWriteTime.ToString('yyyyMMdd'),$_.Extension)  }
```

- ``Get-ChildItem`` ：获取目录中的所有项, 可以添加 ``-Recurse`` 来从子目录获取文件
- ``Foreach-Object`` ：对每个文件运行以下代码块
- ``$_`` ：当前迭代的文件作为对象
- ``$_.BaseName`` ：不带扩展名的文件名
- ``$_.CreationTime`` ：文件的创建时间
- ``$_.LastWriteTime`` ：文件的修改时间
- 方法 ``.ToString()`` ：根据需要进行格式设置
- ``$_.Extension`` ：文件的扩展名
