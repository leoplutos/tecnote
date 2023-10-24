# Linux环境设置总结

## 笔者使用的版本
WSL2 : Ubuntu-22.04 LTS

## 个人设定的文件结构
笔者的文件结构如下
```
~（HOME路径）
├─work
│  └─lch
│      ├─rc
│          ├─bashrc
│          ├─gdbrc
│          ├─inputrc
│          ├─nvimrc
│          ├─tmuxrc
│          └─vimrc
│      └─workspace
│          ├─c
│          ├─java
│          ├─python
│          └─rust
│      └─tool
│          └─lsp
└      └─log
```
- rc文件夹：放各个软件的配置文件，例子见这里 [rc](./linux_rc/)
- workspace文件夹：放各个语言的开发项目
- tool文件夹：放一些开发工具

创建目录命令
```
mkdir -p ~/work/lch/rc/bashrc
mkdir -p ~/work/lch/rc/gdbrc
mkdir -p ~/work/lch/rc/inputrc
mkdir -p ~/work/lch/rc/nvimrc
mkdir -p ~/work/lch/rc/tmuxrc
mkdir -p ~/work/lch/rc/vimrc
mkdir -p ~/work/lch/workspace/c
mkdir -p ~/work/lch/workspace/java
mkdir -p ~/work/lch/workspace/python
mkdir -p ~/work/lch/workspace/rust
mkdir -p ~/work/lch/tool/lsp
mkdir -p ~/work/lch/log
```

## 更换国内源
### archive源 和 ports源的区别
``archive``源 和 ``ports``源 是根本完全不一样的，其涉及到处理器的架构。如果两个源混用的话，会造成一些不可描述的错误和BUG
- archive源 ： 收录的架构为 AMD64 (x86_64) 和 Intel x86
- ports源 ：收录的架构为 ARM(arm64, armhf)、PowerPC(ppc64el)、RISC-V(riscv64) 和 S390x

如果使用x86架构的电脑开启WSL2，则选用 ``archive源``  
如果使用ARM架构的手机使用Termux，则选用 ``ports源``  

### 清华源
- archive源：https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/  
- ports源：https://mirror.tuna.tsinghua.edu.cn/help/ubuntu-ports/  

按照页面的提示如下选择即可
```
是否使用 HTTPS ：是
是否使用 sudo ：是
Ubuntu 版本： 22.04 LTS
使用官方安全更新软件源： 是
启用 proposed： 否
启用源码镜像： 是
```

### 更换源
```
sudo cp -afp /etc/apt/sources.list /etc/apt/sources.list_bak20231024
sudo vim /etc/apt/sources.list
```
然后将网页的内容替换即可  
替换后更新包
```
sudo apt update
sudo apt upgrade
```

## 开启SSH
先将自带的删除后重新按照
```
sudo apt remove openssh-server
sudo apt install openssh-server
```
修改配置信息
```
sudo cp -afp /etc/ssh/sshd_config /etc/ssh/sshd_config_bak20231024
sudo vim /etc/ssh/sshd_config
```
只需要修改如下选项即可
```
Port 8122
ListenAddress 0.0.0.0

PasswordAuthentication yes

PermitRootLogin yes
```
开启服务
```
sudo service ssh start
```
查看IP地址
```
ifconfig
netstat -ant
```
如果这2个命令无法运行，安装net-tools
```
sudo apt install net-tools
```
ssh登录确认
```
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -t user@ipaddress -p 8122
```

## 开发工具安装

### 关于PPA
PPA 是 (P)ersonal (P)ackage (A)rchive的简写
即个人包存档。PPA 允许应用程序开发人员和 Linux 用户创建自己的存储库来分发软件。使用 PPA，您可以轻松获得软件的最新版本，而无需经过官方源

### 安装最新版的 Vim/NeoVim

#### 安装最新版NeoVim
添加NeoVim的PPA源并安装
```
sudo apt install software-properties-common
#稳定版
#sudo add-apt-repository ppa:neovim-ppa/stable
#开发版
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
nvim --version
```
#### 安装最新版Vim
添加Vim的PPA源并安装
```
sudo apt remove vim
sudo apt update
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
vim --version
```

#### 安装后卸载PPA源
```
# 确认列表
sudo add-apt-repository --list
# 删除私人源
sudo add-apt-repository -r ppa:neovim-ppa/unstable
sudo add-apt-repository -r ppa:jonathonf/vim
```

### 安装其他开发工具
```

```
