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

### 下载 Linux 内核更新包
下载WSL Kernel Update包，并手动安装（双击以运行 - 系统将提示你提供提升的权限，选择“是”以批准此安装。）  
[wsl_update_x64.msi](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

### 将 WSL2 设置为默认版本
以管理员身份打开 PowerShell 并运行：
```
wsl --set-default-version 2
```

### 查看Linux发行版并且安装Linux
查看发行版
```
wsl --list --online
```
安装制定发行版。比如Ubuntu
```
wsl --install -d Ubuntu
wsl --install -d Ubuntu-22.04
```
查看已安装的Linux子系统
```
wsl --list -v
```
安装完成后，在Windows开始页面也会出现小图标

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

### 第一次进入WSL
第一次进入时会提示正在安装系统  
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

## WSL输入reboot命令报错
在WSL终端中，无法使用reboot命令来重启，使用重启命令将会显示如下的错误信息：
```
System has not been booted with systemd as init system (PID 1). Can't operate.
Failed to talk to init daemon.
```
这是因为WSL是Windows的一个子服务，终端中无法操作宿主机的服务。解决方法如下：

- 方法一： 在Windows的服务中找到LxssManager 这个服务，右键，重启服务即可，注意此时WSL将会关闭！

- 方法二： 管理员身份打开PowerShell，使用命令 对服务 LxssManager 进行重启
```
# 停止
net stop LxssManager
# 启动
net start LxssManager
```

## WSL无法启动
使用WSL过程中可能会因为一些问题导致WSL无法启动  
使用管理员模式运行Power Shell或CMD并输入
```
netsh winsock reset
```
执行后重启电脑解决
