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
```bash
winver
```

如果 Windows10 的版本过低，可以使用 [Windows 10 更新助手](https://www.microsoft.com/zh-cn/software-download/windows10) 来更新到最新版本

### 启用 WSL
需要先启用“适用于 Linux 的 Windows 子系统”可选功能，然后才能在 Windows 上安装 Linux 分发。  
以管理员身份打开 PowerShell（“开始”菜单 >“PowerShell” >单击右键 >“以管理员身份运行”），然后输入以下命令：
```bash
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

### 启用虚拟机功能
安装 WSL2 之前，必须启用“虚拟机平台”可选功能  
以管理员身份打开 PowerShell 并运行：
```bash
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

### 重启
启用上面两项设定后，重启计算机

### 下载 Linux 内核更新包（不需要）
~~下载WSL Kernel Update包，并手动安装（双击以运行 - 系统将提示你提供提升的权限，选择“是”以批准此安装。）~~  
~~[wsl_update_x64.msi](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)~~

### 将 WSL2 设置为默认版本
以管理员身份打开 PowerShell 并运行：
```bash
wsl --set-default-version 2
```

### 更新 WSL 内核

#### 从 Microsoft Store 获取最新版本
```bash
wsl --update
```
这个命令最好多执行几次，直到显示当前已是最新，比如
```bash
$ wsl --update
正在检查更新。
已安装最新版本的适用于 Linux 的 Windows 子系统。
```

#### 从 GitHub 获取最新版本
```bash
wsl --update --web-download
```

### 查看Linux发行版并且安装Linux
查看发行版
```bash
wsl --list --online
```
如果报错可以用这个url  
https://raw.bgithub.xyz/microsoft/WSL/master/distributions/DistributionInfo.json

查看已安装的Linux子系统
```bash
wsl --list -v
```

安装制定发行版
```bash
# 安装 Ubuntu-22.04
wsl --install -d Ubuntu-22.04
# 安装 Debian
wsl --install -d Debian
```

卸载命令为
```bash
wsl --uninstall Ubuntu-22.04
wsl --unregister Ubuntu-22.04
```

### 第一次进入WSL
运行安装命令后会提示正在安装系统  
安装完毕会提示设定用户名和密码，设定好后即可进入子系统  
另外，不要忘记设定root的密码
```bash
sudo passwd root
```
设定好后
```bash
su
```
当看到 ``$`` 变为 ``#`` 说明用户切换成功  
安装完成后，在Windows开始页面也会出现小图标

### 启用 systemd

确认 systemd 是否启用
```bash
cat /etc/wsl.conf
```
内容如下
```text
[boot]
systemd=true
```
如果没有这个文件，需要新建
```bash
# 使用普通用户运行
sudo tee /etc/wsl.conf << 'EOF'
[boot]
systemd=true
EOF
```

然后重启一次 WSL 实例
```bash
wsl --shutdown
wsl
```

进入 WSL 实例后运行
```bash
sudo systemctl list-unit-files --type=service
```
确认 systemd 是否可用


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
    ```bash
    wsl -d Ubuntu-22.04
    ```

WSL2启动之后，如果开启了SSH服务，那么从宿主机可以直接用 ``127.0.0.1`` 访问

## 让WSL开机启动，后台运行，以减少唤醒时间
WSL2 会默认关闭不使用的实例，当你关闭了 WSL 的 Console 后，实例会自动关闭。
如果你的计算机资源比较充足，那么是可以在开机时通过 VBS 脚本启动一个 WSL 实例，让它挂起在那里不要休眠。

**方法如下**：

``Win + r`` 运行 ``shell:startup`` 打开启动目录  
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

更多看 [这里](https://learn.microsoft.com/zh-cn/windows/wsl/wsl-config)

## WSL2下Ubuntu-22.04的初始配置
```bash
# 备份apt源
mkdir -p $HOME/config_bak
sudo cp -afp /etc/apt/sources.list $HOME/config_bak/sources.list
set -eux
# 修改apt为阿里云源
sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list

sudo apt update
sudo apt upgrade

# 安装所需软件
sudo apt install openssh-server zip unzip xsel xclip ripgrep fd-find -y
sudo ln -s $(which fdfind) /usr/bin/fd

# 配置 SSH 服务器
sudo cp -afp /etc/ssh/sshd_config $HOME/config_bak/sshd_config
sudo sed -i 's/#Port 22/Port 8122/g' /etc/ssh/sshd_config
sudo sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# 重启ssh
sudo service ssh restart
sudo service ssh status

# neovim配置一键安装
export GITHUB_RAW_URL=https://raw.bgithub.xyz
curl -fsSL ${GITHUB_RAW_URL}/leoplutos/tecnote/refs/heads/master/Linux/lazy_nvim_setting.sh | bash

# 安装neovim
export GITHUB_URL=https://bgithub.xyz
curl -Lo nvim-linux64.tar.gz "${GITHUB_URL}/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz"
tar xzvf nvim-linux64.tar.gz
sudo mv nvim-linux64 /usr/local/nvim
sudo chown -R root:root /usr/local/nvim
rm nvim-linux64.tar.gz
sudo ln -s /usr/local/nvim/bin/nvim /usr/bin/nvim
```

## WSL2下Debian的初始配置
```bash
# 备份apt源
mkdir -p $HOME/config_bak
sudo cp -afp /etc/apt/sources.list $HOME/config_bak/sources.list
set -eux
# 修改apt为阿里云源
sudo sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list

sudo apt update
sudo apt upgrade

# 安装所需软件
sudo apt install git curl openssh-server zip unzip xsel xclip ripgrep fd-find -y
sudo ln -s $(which fdfind) /usr/bin/fd

# 配置 SSH 服务器
sudo cp -afp /etc/ssh/sshd_config $HOME/config_bak/sshd_config
sudo sed -i 's/#Port 22/Port 8122/g' /etc/ssh/sshd_config
sudo sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# 重启ssh
sudo service ssh restart
sudo service ssh status

# neovim配置一键安装
export GITHUB_RAW_URL=https://raw.bgithub.xyz
curl -fsSL ${GITHUB_RAW_URL}/leoplutos/tecnote/refs/heads/master/Linux/lazy_nvim_setting.sh | bash

# 安装neovim
export GITHUB_URL=https://bgithub.xyz
curl -Lo nvim-linux64.tar.gz "${GITHUB_URL}/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz"
tar xzvf nvim-linux64.tar.gz
sudo mv nvim-linux64 /usr/local/nvim
sudo chown -R root:root /usr/local/nvim
rm nvim-linux64.tar.gz
sudo ln -s /usr/local/nvim/bin/nvim /usr/bin/nvim

# debian默认没有安装vim，制作neovim的别名为vim
sudo tee /usr/local/bin/vim << 'EOF'
#!/bin/bash
/usr/bin/nvim $@
EOF
# 修改权限
sudo chmod +x /usr/local/bin/vim
# 确认
vim -V1 -v
```

## WSL2的一些常用命令
查看帮助
```bash
wsl --help
```
检查版本
```bash
wsl --version
```
装载外部磁盘（比如块本地设备、网络块设备等）
```bash
wsl --mount <Disk>
```
关闭WSL
```bash
wsl --shutdown
```

## WSL2重启
```bash
wsl -l -v
wsl --terminate Ubuntu-22.04
```

## 如何将WSL下的服务公开到内网
在 [issues 4150](https://github.com/microsoft/WSL/issues/4150) 有相关讨论

### WSL2 下 Debian 实例的 ``ip -4 addr show | grep eth0`` 结果

在 ``Debian`` 运行命令
```text
eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    inet 172.30.8.xxx/20 brd 172.30.15.255 scope global eth0
```

这里的 ``172.30.8.xxx`` 即为 WSL2 实例的 IP 地址，比如要开启端口 ``9500`` 的转发

### Windows开启端口转发

在 ``Windows`` 运行命令

```bash
netsh interface portproxy add v4tov4 listenport=9500 listenaddress=0.0.0.0 connectport=9500 connectaddress=172.30.8.xxx
```

查看转发内容
```bash
netsh interface portproxy show all
# 或者
netsh interface portproxy show v4tov4
```

### 防火墙设定
接下来，允许防火墙中端口 9500 端口上的访问

``Windows + R``，输入 ``control`` 回车  
然后 ``系统和安全`` → ``Windows Defender 防火墙`` → ``高级设置``

#### 入站规则
点击左侧的 ``入站规则`` → ``新建规则`` → ``端口`` → ``TCP`` → ``特定本地端口`` 输入 ``9500`` → ``允许连接`` → ``域/专用/公用`` 都选择 → 输入一个规则名，比如 ``9500端口公开``

### 注意事项
Windows 重启以后 WSL2 实例的 IP 地址可能会变更，记得使用命令删除转发
```bash
netsh interface portproxy delete v4tov4 listenport=9500 listenaddress=0.0.0.0"
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
```bash
netsh winsock reset
```
执行后重启电脑解决

