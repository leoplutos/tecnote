# 废旧手机安装Linux
手机需要需要 Android 7.0 及以上版本。

## 1.Termux安装
Termux 是 Android 平台上的一个终端模拟器，它将众多 Linux 上运行的软件和工具近乎完美的移植到了手机端。 无需任何复杂的安装和配置过程，软件装好以后即会自动配置一个基本的运行环境，用以执行一些常见的 Linux 命令。 最为关键的是，它还内置了功能健全的包管理工具，可以使用类似于 Ubuntu 系统的 apt （或 pkg）命令安装额外的软件包，完美支持 Python、 PHP、 Ruby、 Nodejs、MySQL等。

**下载APK**  
https://f-droid.org/packages/com.termux/  
笔者测试的版本为 0.118.0 (118) 更新于 2022-01-1

## 2.Termux操作(手机端操作)
打开Termux

#### 2-1.申请读写权限
```bash
termux-setup-storage
```
手机端 会弹出权限提示，选择允许读写即可。

#### 2-2.开启ssh服务
因为手机操作屏幕比较小，输入内容也不方便。笔者这里开启ssh服务，用电脑操作。  
安装openssh
```bash
apt install openssh
```
安装openssl（**非必须**，如果提示ssl.so找不到安装这个）
```bash
apt install openssl
```
开启ssh服务
```bash
sshd
```
如果报错“sshd: no hostkeys available”，运行下面的命令重新启动一次即可
```bash
ssh-keygen -A
```

#### 2-3.确认ssh端口
ssh服务启动后输入以下命令确认端口
```bash
netstat -anp | grep sshd
```
得知ssh端口为8022


#### 2-4.重置当前手机用户密码
```bash
whoami
```
得知是一个u0_a123的一个临时账号。  
使用命令修改密码
```bash
passwd
```
将该用户的密码重置为123456，这样我们就可以通过ssh到手机了

## 3.ssh操作(电脑端操作)
打开支持ssh连接的终端，连接到手机。
```bash
ssh -p 8022 u0_a123@192.168.xx.xx
```

#### 3-1.更换镜像
默认镜像在国外访问很慢还需要翻墙，所以修改为清华源。  
操作参照下面两个网页：  
https://wiki.termux.com/wiki/PRoot#Installing_Linux_distributions  
https://mirrors.tuna.tsinghua.edu.cn/help/termux/  

具体操作步骤为：  

**3-1-1.使用图形界面（TUI）替换 Termux 镜像**  
在较新版的 Termux 中，官方提供了图形界面（TUI）来半自动替换镜像，推荐使用该种方式以规避其他风险。 在 Termux 中执行如下命令
```bash
termux-change-repo
```
在图形界面引导下，使用自带方向键可上下移动。
第一步使用空格选择需要更换的仓库，之后在第二步选择 TUNA/BFSU 镜像源。确认无误后回车，镜像源会自动完成更换。  
警告  
镜像仅适用于 Android 7.0 (API 24) 及以上版本，旧版本系统使用本镜像可能导致程序错误。

**3-1-2.手动修改sources.list文件**  
请使用内置或安装在 Termux 里的文本编辑器，例如 vi / vim / nano 等，不要使用 RE 管理器等其他具有 ROOT 权限的外部 APP 来修改 Termux 的文件  
* 编辑 $PREFIX/etc/apt/sources.list 修改为如下内容
```bash
nano -l $PREFIX/etc/apt/sources.list
```
```bash
deb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main
```

* 编辑 $PREFIX/etc/apt/sources.list.d/science.list 修改为如下内容
```bash
mkdir $PREFIX/etc/apt/sources.list.d
touch $PREFIX/etc/apt/sources.list.d/science.list
nano -l $PREFIX/etc/apt/sources.list.d/science.list
```
```bash
deb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-science science stable
```

* 编辑 $PREFIX/etc/apt/sources.list.d/game.list 修改为如下内容
```bash
touch $PREFIX/etc/apt/sources.list.d/game.list
nano -l $PREFIX/etc/apt/sources.list.d/game.list
```
```
deb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-games games stable
```

#### 3-2.运行update
换好源后，记得update，但是不需要upgrade：
```bash
apt update
```

#### 3-3.安装基础件proot-distro
```bash
pkg install proot-distro
```

#### 3-4.查看可安装Linux
```bash
proot-distro list
```

#### 3-4.curl确认
笔者在进行到这里的时候，发现curl命令无法使用，提示没有ssl.so，用以下方式解决。  
确认curl
```bash
curl --version
```
如果可以运行跳过3-4，如果不可运行执行下面的命令。
```bash
pkg search openssl1.1
pkg install openssl1.1-tool
pwd
find /data/data/com.termux/files -name 'libssl.so*'
echo "export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib/openssl-1.1" >> ~/.bashrc
export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib/openssl-1.1
echo $LD_LIBRARY_PATH
curl --version
```

#### 3-5.安装Linux
安装命令为
```bash
proot-distro install <alias> 
```
比如，我要安装ubuntu，命令为
```bash
proot-distro install ubuntu
```

#### 3-6.进入Linux
安装完成后，进入 Linux发行版环境的命令为
```bash
proot-distro login <alias> 
```
比如我安装的ubuntu，命令为：
```bash
proot-distro login ubuntu
```

#### 3-7.退出Linux
```bash
exit
```

## 4.Ubuntu 初始化

#### 4-1.换源
换成清华镜像源：  
https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu-ports/
```bash
cp -afp /etc/apt/sources.list /etc/apt/sources.list_bak20230419
nano -l /etc/apt/sources.list
```
将文件内容修改为网页内容。

#### 4-2.运行update
换好源后，记得update
```bash
apt update && apt upgrade
```

#### 4-3.安装vim
```bash
apt install vim
vim --version
```

#### 4-4.安装中文
安装中文支持包language-pack-zh-hans
```bash
apt-get install language-pack-zh-hans
```
修改/etc/environment文件
```bash
vim /etc/environment
```
在文件的末尾追加
```
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh:en_US:en"
```

再修改/var/lib/locales/supported.d/local文件(没有这个文件就新建)
```bash
touch /var/lib/locales/supported.d/local
vim /var/lib/locales/supported.d/local
```
在文件的末尾追加
```
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
zh_CN.GBK GBK
zh_CN GB2312
```

最后，执行命令：
```bash
locale-gen
```

对于中文乱码是空格的情况，安装中文字体解决:
```bash
apt-get install fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming
```

#### 4-5.安装openssh-server
```bash
apt install openssh-server
```
修改配置文件:
```bash
vim /etc/ssh/sshd_config
```
**修改端口**  
查找：
```
#Port 22
```
修改为: 
```
Port 8122
```
注意： 端口最好是4位数即以上的端口号，否则容易造成ssh启动失败，这儿Termux上Linux存在的问题。

**支持root用户**  
查找：
```
#PermitRootLogin prohibit-password
或者
#PermitRootLogin yes
```
修改为:
```
PermitRootLogin yes
```
**支持密码认证**  
查找：
```
#PasswordAuthentication yes
```
修改为:
```
PasswordAuthentication yes
```

**启动ssh**  
```bash
service ssh start
```
或者:
```bash
/usr/sbin/sshd
```
ssh服务可用下面的命令
```
service ssh start | stop | restart | status
```

通过命令查看ssh是否启动成功:
```bash
ps -e | grep ssh
netstat -anp | grep sshd
```

#### 4-5.安装开发工具
**安装curl**
```bash
apt install curl
```

**安装gcc**
```bash
apt install build-essential
```
或者
```bash
apt install gcc
apt install make
apt install gdb
```
确认
```bash
gcc --version
make --version
gdb --version
```

**安装rust**
```bash
apt install cargo
```
由于 cargo 包含 rustc，所以笔者建议安装它，以便一次性安装所有必需的软件包。
当然，你可以自由使用 apt install rustc，只安装 Rust。这取决于你的选择。

确认
```bash
cargo --version
rustc --version
```