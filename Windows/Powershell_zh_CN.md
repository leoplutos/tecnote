# Powershell命令

## ps1 文件
ps1 文件类似 linux 的 ``~/.profile`` 文件，在 shell 初始化时会预先执行。在 Powershell 中， ps1 文件的路径保存在 ``$Profile`` 变量中，输入
```
echo $Profile
```
命令能看到它的绝对路径，没有需要新建  
修改好内容后，可以用点命令载入
```
. $Profile
```



## 提示 无法加载文件 xxx.ps1，因为在此系统上禁止运行脚本。

解决办法：  
1.``win+X`` 键，使用管理员身份运行power shell  
2.输入命令 ``set-ExecutionPolicy RemoteSigned`` ，选y即可

## 关于转义字符
以下转义字符为 PowerShell 6.0 中新加的，旧版不可用
```
`e
`u{x}
```
