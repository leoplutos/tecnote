## WSL

WSL 的全称是 ``Windows Subsystem for Linux``，也就是 Windows 的 Linux 子系统，它是由微软与Canonical公司合作开发的，从 ``Win10`` 开始支持  
现在最新版本为 ``WSL2``，相比于 WSL1 ，``WSL2`` 使用的是全新的体系结构，能够通过子系统方式运行真正的 Linux 内核。它能够无需重新打包或翻译，直接运行 ELF64 Linux 二进制文件。

## 安装

### 前提条件
安装 WSL2 需要满足以下条件：
1. Windows 11 或 Windows 10  版本1903，内部版本18362.1049 或更高版本
2. 64 位版本的 Windows
3. 启用了虚拟化功能  

可以使用如下命令确认版本
```
winver
```

如果 Windows10 的版本过低，可以使用 [Windows 10 更新助手](https://www.microsoft.com/zh-cn/software-download/windows10) 来更新到最新版本

### 启用 WSL
需要先启用“适用于 Linux 的 Windows 子系统”可选功能，然后才能在 Windows 上安装 Linux 分发。  
以管理员身份打开 PowerShell（“开始”菜单 >“PowerShell” >单击右键 >“以管理员身份运行”），然后输入以下命令：
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

### 启用虚拟机功能
安装 WSL2 之前，必须启用“虚拟机平台”可选功能  
以管理员身份打开 PowerShell 并运行：
```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

### 重启
启用上面两项设定后，重启计算机

### 下载 Linux 内核更新包（不需要）
~~下载WSL Kernel Update包，并手动安装（双击以运行 - 系统将提示你提供提升的权限，选择“是”以批准此安装。）~~  
~~[wsl_update_x64.msi](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)~~

### 将 WSL2 设置为默认版本
以管理员身份打开 PowerShell 并运行：
```
wsl --set-default-version 2
```

### 更新 WSL 内核
```
wsl --update
或者
wsl --update --web-download
```

### 查看Linux发行版并且安装Linux
查看发行版
```
wsl --list --online
```
如果报错可以用这个url  
https://raw.bgithub.xyz/microsoft/WSL/master/distributions/DistributionInfo.json  

安装制定发行版，比如Ubuntu
```
wsl --install -d Ubuntu-22.04
或者
wsl --install -d Debian
```

### 第一次进入WSL
运行安装命令后会提示正在安装系统  
安装完毕会提示设定用户名和密码，设定好后即可进入子系统  
另外，不要忘记设定root的密码
```
sudo passwd root
```
设定好后
```
su
```
当看到 ``$`` 变为 ``#`` 说明用户切换成功  
安装完成后，在Windows开始页面也会出现小图标


### 查看安装的WSL
查看已安装的Linux子系统
```
wsl --list -v
```

### 使用WSL

有3种进入方式

1. 直接点击开始页面的小图标

2. Windows Terminal会自动出现安装的子系统，点击即可打开  

    如果没有出现图标，可以如下登录  
    名称：``WSL-Ubuntu2204``  
    命令行：``wsl -d Ubuntu-22.04``  
    启动目录：``~``  
    图标：``https://assets.ubuntu.com/v1/49a1a858-favicon-32x32.png``  

3. 打开命令行输入
    ```
    wsl -d Ubuntu-22.04
    ```

WSL2启动之后，如果开启了SSH服务，那么从宿主机可以直接用 ``127.0.0.1`` 访问

## 让WSL开机启动，后台运行，以减少唤醒时间
WSL2 会默认关闭不使用的实例，当你关闭了 WSL 的 Console 后，实例会自动关闭。
如果你的计算机资源比较充足，那么是可以在开机时通过 VBS 脚本启动一个 WSL 实例，让它挂起在那里不要休眠。

**方法如下**：

WIN+R 运行 ``shell:startup`` 打开启动目录  
在此目录中创建文件 ``wsl-startup.vbs`` 内容如下
```vb
set ws=wscript.CreateObject("wscript.shell")
ws.run "wsl -d Ubuntu-22.04", 0
```
``Ubuntu-22.04`` 需替换为你使用的发行版名称

这样当你系统启动，登录系统后，Windows会开启 WSL 实例，它会永久等待输入，不会关闭。所以当你下次再使用WSL命令时，就不会遇到需要重新唤醒 WSL 的耗时

如果你担心后台挂着WSL对系统资源占用过高，可以通过配置 ``.wslconfig`` 文件来限制 WSL 的资源占用。 WSL 会默认占用50%内存，最大8GB。使用所有CPU线程。我一般会限制到4GB,2线程

文件：``%USERPROFILE%\.wslconfig``
内容如下
```
[wsl2]
memory=4GB 
processors=2
```


## WSL2的一些常用命令
查看帮助
```
wsl --help
```
检查版本
```
wsl --version
```
装载外部磁盘（比如块本地设备、网络块设备等）
```
wsl --mount <Disk>
```
关闭WSL
```
wsl --shutdown
```

## WSL2重启
```
wsl -l -v
wsl --terminate Ubuntu-22.04
```

## Windows与WSL之间的文件访问

### Windows访问Linux文件
在资源管理器的地址栏输入
```
\\wsl$
```

### Linux访问Windows文件
```
/mnt/{Windows盘符}
```

### 一个从Windows复制Vim/NeoVim设定文件到WSL的脚本
- [install_wsl_vim_setting.cmd](./install_wsl_vim_setting.cmd)


## WSL无法启动
使用WSL过程中可能会因为一些问题导致WSL无法启动  
使用管理员模式运行Power Shell或CMD并输入
```
netsh winsock reset
```
执行后重启电脑解决
