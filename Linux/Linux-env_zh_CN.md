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
│          ├─snippets
│          └─vimrc
│      ├─workspace
│          ├─c
│          ├─java
│          ├─python
│          ├─rust
│          └─go
│      ├─tool
│          ├─coc_extension_data
│          ├─go_global
│          └─lsp
│      ├─tmp
└      └─log
```
- rc文件夹：放各个软件的配置文件，例子见这里 [rc](./linux_rc/)
- workspace文件夹：放各个语言的开发项目

创建目录命令
```
mkdir -p ~/work/lch/rc/bashrc
mkdir -p ~/work/lch/rc/gdbrc
mkdir -p ~/work/lch/rc/inputrc
mkdir -p ~/work/lch/rc/nvimrc
mkdir -p ~/work/lch/rc/tmuxrc
mkdir -p ~/work/lch/rc/snippets
mkdir -p ~/work/lch/rc/vimrc
mkdir -p ~/work/lch/workspace/c
mkdir -p ~/work/lch/workspace/java
mkdir -p ~/work/lch/workspace/python
mkdir -p ~/work/lch/workspace/rust
mkdir -p ~/work/lch/workspace/go
mkdir -p ~/work/lch/tool/coc_extension_data
mkdir -p ~/work/lch/tool/go_global
mkdir -p ~/work/lch/tool/lsp
mkdir -p ~/work/lch/tmp
mkdir -p ~/work/lch/log
```

### 没有用apt安装的软件
统一放在
```
/usr/local/${App名}
```
可执行文件统一软链接到
```
/usr/local/bin
```

## 关于Linux下的安装程序
- 只是需要一个程序，不关心版本号：用 apt 装
- 只是需要一个程序，需要的版本 apt 里就有：用 apt 装
- 只是需要一个程序，需要的版本 apt 没有提供，但有官方源：添加对应的官方源，再用 apt 装
- 只是需要一个程序，需要的版本 apt 没有提供，但 PPA 里有：添加对应的 PPA，再用 apt 装
- 只是需要一个程序，需要的版本 apt 没有提供，PPA 里也没有：从源码自行编译安装

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

### 添加Clang的官方源
出自：https://apt.llvm.org/  
首先获取签名
```
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
```
然后编辑 ``/etc/apt/sources.list``，在最下面添加如下内容
```
# 16
deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main
deb-src http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main
```
添加后
```
sudo apt update
```

## 开启SSH
先将自带的删除后重新安装
```
sudo apt remove --autoremove openssh-server
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
重启或开启服务
```
sudo service ssh restart
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
在Windows下使用ssh命令登录确认
```
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -t username@ipaddress -p 8122
```
使用 ``WezTerm ssh``
```
wezterm ssh -- username@ipaddress:8122
```
## 开发工具安装

### 关于PPA
PPA 是 (P)ersonal (P)ackage (A)rchive的简写
即个人包存档。PPA 允许应用程序开发人员和 Linux 用户创建自己的存储库来分发软件。使用 PPA，您可以轻松获得软件的最新版本，而无需经过官方源

### 安装最新版的 Vim/NeoVim(PPA安装)

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
sudo apt remove --autoremove vim
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

#### 解决添加PPA速度过慢
发生这种原因是因为两种原因导致：
 1. CA证书损坏
 2. 没有绕过代理  

先重装一遍CA证书
```
sudo apt-get install --reinstall ca-certificates
```
如果还不行，我们就绕过代理，加一个 ``-E``
```
sudo -E add-apt-repository --update ppa:neovim-ppa/unstable
```

#### 给PPA替换为中科大源
PPA添加成功过后，会在 ``/etc/apt/sources.list.d`` 下生成一个文件
```
cd /etc/apt/sources.list.d
ls
```
将文件中 ``https://ppa.launchpadcontent.net`` 替换为 ``https://launchpad.proxy.ustclug.org``
```
sudo vim neovim-ppa-ubuntu-unstable-jammy.list
```
```
deb https://launchpad.proxy.ustclug.org/neovim-ppa/unstable/ubuntu/ jammy main
#deb https://ppa.launchpadcontent.net/neovim-ppa/unstable/ubuntu/ jammy main
```

### 安装其他开发工具

#### 通用
```
#自带git
git --version
sudo apt install ripgrep
sudo npm install -g --save-dev --save-exact prettier
sudo npm install -g sql-formatter

#gitui
sudo mkdir -p /usr/local/gitui
cd /usr/local/gitui
sudo tar -zxvf ~/work/lch/tmp/gitui-linux-musl.tar.gz -C /usr/local/gitui
sudo chown root:root *
sudo chmod u=rwx,g=rx,o=rx gitui
sudo ln -s /usr/local/gitui/gitui /usr/local/bin/
gitui --version
mkdir -p $HOME/.config/gitui
touch $HOME/.config/gitui/key_bindings.ron
touch $HOME/.config/gitui/theme.ron
nvimf $HOME/.config/gitui/key_bindings.ron
nvimf $HOME/.config/gitui/theme.ron

#lazygit
sudo mkdir -p /usr/local/lazygit
cd /usr/local/lazygit
sudo tar -zxvf ~/work/lch/tmp/lazygit_0.40.2_Linux_x86_64.tar.gz -C /usr/local/lazygit
sudo chown root:root *
sudo chmod u=rwx,g=rx,o=rx lazygit
sudo ln -s /usr/local/lazygit/lazygit /usr/local/bin/
lazygit --version
mkdir -p ~/.config/lazygit/
touch ~/.config/lazygit/config.yml
nvimf ~/.config/lazygit/config.yml
```

#### C
```
sudo apt install gcc
sudo apt install gdb
sudo apt install universal-ctags
#需要加上clang的官方源
sudo apt install clangd-16
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-16 100
#需要加上clang的官方源
sudo apt install clang-format-16
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-16 100
sudo apt install ninja-build
```
不要忘记重新生成索引
```
ninja -t compdb > compile_commands.json
```

#### Python
```
#python3自带
python3 --version
sudo apt install python3-pip
pip3 --version
pip3 install black -i https://pypi.tuna.tsinghua.edu.cn/simple
pip3 show black
sudo pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pynvim

#安装Node.js18（从nodesource安装，因为要用pyright）
sudo apt install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install nodejs -y
node --version
npm --version
#sudo mkdir -p /usr/local/node/node_global
#sudo mkdir -p /usr/local/node/node_cache
#npm config set prefix "/usr/local/node/node_global"
#npm config set cache "/usr/local/node/node_cache"
sudo npm config set registry https://npmreg.proxy.ustclug.org/ -g
npm config ls -ls
sudo npm install -g pyright
pyright-langserver
```

#### Java
```
sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo apt install openjdk-17-jdk
#sudo apt install openjdk-21-jdk
#sudo apt remove openjdk-17-jdk --purge
#sudo update-alternatives --config java

#maven
sudo apt -y install maven
#sudo mkdir -p /usr/local/maven
#cd /usr/local/maven
#sudo tar -zxvf ~/work/lch/tmp/apache-maven-3.9.4-bin.tar.gz -C /usr/local/maven
#sudo ln -s /usr/local/maven/apache-maven-3.9.4/bin/mvn /usr/local/bin/
mvn --version
#修改maven仓库源
mkdir -p ~/.m2/repo/
touch ~/.m2/settings.xml
vim ~/.m2/settings.xml
#sudo cp -afp /usr/local/maven/apache-maven-3.9.4/conf/settings.xml /usr/local/maven/apache-maven-3.9.4/conf/settings.xml_bak20231024
#sudo vim /usr/local/maven/apache-maven-3.9.4/conf/settings.xml

#ant
sudo mkdir -p /usr/local/ant
cd /usr/local/ant
sudo tar -zxvf ~/work/lch/tmp/apache-ant-1.10.13-bin.tar.gz -C /usr/local/ant
sudo ln -s /usr/local/ant/apache-ant-1.10.13/bin/ant /usr/local/bin/
ant -version
#lsp(jdtls)
mkdir -p ~/work/lch/tool/lsp/jdtls
cd ~/work/lch/tool/lsp/jdtls
tar -zxvf ~/work/lch/tmp/jdt-language-server-1.26.0-202307271613.tar.gz -C ~/work/lch/tool/lsp/jdtls
```

#### Rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
ll $HOME/.cargo/bin
#重启WSL
cargo --version
rustc --version
rustfmt --version
rustup --version
rustup component add rust-analyzer
rust-analyzer --version
```

#### Golang
```
sudo rm -rf /usr/local/go
sudo tar -zxvf ~/work/lch/tmp/go1.21.0.linux-amd64.tar.gz -C /usr/local
ll /usr/local/go
go version
gofmt -r
mkdir -p ~/work/lch/tool/go_global
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
go env
go install golang.org/x/tools/gopls@latest
gopls version
```

#### Vue
```
sudo npm install -g @vue/language-server
sudo npm install -g typescript
vue-language-server --version

cd ~/work/lch/workspace/vue
npm create vue@latest
cd VueTestProject
npm install
npm run dev
```

#### Cobol
```
#lsp(che-che4z-lsp-for-cobol)
#手动上传cobol-language-support-1.2.1
ll ~/work/lch/tool/lsp/cobol-language-support-1.2.1
```

#### Kotlin
```
sudo mkdir -p /usr/local/kotlin
sudo unzip ~/work/lch/tmp/kotlin-compiler-1.9.10.zip -d /usr/local/kotlin
ll /usr/local/kotlin
kotlin -version
kotlinc -version

#lsp(kotlin-language-server)
#手动上传kotlin-language-server
ll ~/work/lch/tool/lsp/kotlin-language-server
cd ~/work/lch/tool/lsp/kotlin-language-server/bin
chmod u+r+x kotlin-language-server
ll
```

#### Lua-language-server
```
sudo mkdir -p /usr/local/lua-language-server
sudo tar -zxvf ~/work/lch/tmp/lua-language-server-3.7.0-linux-x64.tar.gz -C /usr/local/lua-language-server
sudo mkdir - p /usr/local/lua-language-server/log
sudo chmod -R 777 /usr/local/lua-language-server/log
sudo ln -s /usr/local/lua-language-server/bin/lua-language-server /usr/local/bin/
lua-language-server --version
```

#### FishShell
```
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
```
**查看Fish shell设定**
```bash
cat ~/.config/fish/config.fish
```

## 关于WSL下的下划波浪线显示
测试当前终端是否会显示
```
printf "\x1b[58:2::255:0:0m\x1b[4:1m  single  \x1b[4:2m  double  \x1b[4:3m  curly  \x1b[4:4m  dotted  \x1b[4:5m  dashe  d\x1b[0m\n"
```
如果你能看到下划线，那么代表现在你的终端是支持的

### 重要
在 Windows 上，``ConPTY 图层会去除下划线转义序列``。如果 WSL 实例中缺少此功能，则需要使用 wezterm ssh 或多路复用来绕过 ConPTY  
所以在控制台使用
```
wsl -d Ubuntu-22.04
```
进入的终端是走的 ConPTY 图层，不会显示 ``下划线波浪线``  

### 解决方案
直接走 ``ssh`` 协议连接，不经过Windows的控制台（ConPTY）  
比如使用 ``WezTerm ssh``
```
wezterm ssh -- username@ipaddress:8122
```

### 如果使用Neovim的话，还需要做如下设定
1. 在 ``~/.terminfo`` 目录中安装一个 terminfo 文件
```
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile
```
2. 使用如下命令启动NeoVim  
意思就是临时用环境变量``TERM=wezterm``来启动NeoVim
```
env TERM=wezterm nvim
env TERM=wezterm nvim -u ~/work/lch/rc/nvimrc/init.lua
```

### 其他
确认是否支持下划线
```
infocmp | grep Smulx
infocmp -1 -x vte | grep Smulx
```

### Linux下自动安装Vim/NeoVim设定
笔者的脚本：
 - [install_linux_vim_setting.sh](./install_linux_vim_setting.sh)
