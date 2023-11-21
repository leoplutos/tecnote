# Linux Mint安装记录

## 关于Linux Mint
Linux Mint 是基于 ``Ubuntu`` 改进的开源免费桌面 Linux 系统，运行速度快、系统稳定、使用简便。无疑是 最适合初学者的 Linux 发行版之一。尤其是对于刚刚迈向 Linux 世界的 Windows 用户来说，更是如此。  

它包含了3个桌面环境
 - Cinnamon 桌面
 - MATE 桌面
 - Xfce 桌面

``Cinnamon`` 是具有现代感的传统桌面。它是由 Linux Mint 团队开发的，显然它是 Linux Mint 的主力版本。如果你不知道该选什么，就选这个默认的。

``MATE`` 类似 GNOME 2 时代的传统外观桌面。

``Xfce`` 追求快速、轻量级和易于使用，所以老旧电脑就选这个即可。

## 下载安装
 - [Linux Mint 官网](https://linuxmint.com/)

因为笔者是在一台赛扬CPU + 4G内存的老电脑上使用，所以选择的 ``Xfce``，安装版本为 ``21.2``

## 安装步骤

1. 使用 ``Ventoy`` 对U盘处理以后，将下载系统镜像 iso 文件直接拷贝到U盘。重启用U盘启动，几秒钟就可进入 Mint 桌面。  
关于 ``Ventoy`` 更多请看 [这里](../Other/Usbboot_zh_CN.md)

2. 点击桌面的 ``Install Linux Mint`` 启动安装向导  
  **NOTE**：**安装过程中不要联网**  
  依次如下选择
    - 键盘布局：Chinese
    - 安装多媒体编码译码器：选中
    - 安装类型：清除整个磁盘并安装 Linux Mint
    - 设置时区：Shanghai
    - 创建用户账户：根据需要填写

3. 安装之后会提示需要重启，选择 ``现在重启``

4. 重启后会提示你 ``拔出U盘后，按回车`` ，操作即可

5. 重启完成后，就可以用先前设置好的用户名和密码登录到 Linux Mint 21 桌面了

### 关于磁盘分区
因为笔者不装双系统，所以直接选择的 ``清除整个磁盘并安装 Linux Mint``  
有分区需求可以参照 [这个文章](https://blog.csdn.net/m0_47670683/article/details/111569309)

## 安装后的设置

因为Mint安装好后没有 ``Vim``，只有 ``nano``。在这里记录一下nano的快捷键  
- CTRL+o 然后回车 → 保存
- CTRL+x → 退出
- SHIFT+方向 → 选择
- ALT+6 → 复制
- CTRL+u → 粘贴

### 更新源
第一次启动系统会收到提示先选择本地软件源，没注意到提示的可以自行点 ``系统设置 → 软件源``  
笔者选择的是 ``TUNA`` 清华大学源  
修改之后还需要修改一下源文件  
``Linux Mint`` 的镜像源配置文件和 ``Debian``/``Ubuntu`` 稍稍有些不同，是在 ``/etc/apt/sources.list.d`` 目录下，而不是 ``/etc/apt/sources.list`` 文件

```
ll /etc/apt/sources.list.d/
cat /etc/apt/sources.list.d/official-package-repositories.list
sudo cp -afp /etc/apt/sources.list.d/official-package-repositories.list /etc/apt/sources.list.d/official-package-repositories.list_bak20231101
sudo nano /etc/apt/sources.list.d/official-package-repositories.list
```
修改为如下内容
```
deb https://mirrors.tuna.tsinghua.edu.cn/linuxmint victoria main upstream import backport

deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu jammy main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu jammy-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu jammy-backports main restricted universe multiverse

#deb http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu jammy-security main restricted universe multiverse
```
更多看 [清华大学Linux Mint 软件仓库帮助](https://mirror.tuna.tsinghua.edu.cn/help/linuxmint/)

修改为国内源后，**连接网络**，运行一次升级
```
#更新缓存
sudo apt update
#更新软件
sudo apt upgrade
#发行版本更新
sudo apt dist-upgrade
#自动移除不再使用的依赖程序包
sudo apt autoremove --purge
#删除已下载的旧包文件
sudo apt autoclean
```

### 语言与输入法

#### 安装语言包
```
sudo apt install language-pack-zh-hans language-pack-gnome-zh-hans language-pack-zh-hans-base language-pack-gnome-zh-hans-base
```
#### 解决字体发虚
```
sudo apt install language-selector-*
```

#### 安装拼音输入法引擎fcitx5

开始菜单 → 语言支持 → 点击``安装`` → 点击``应用到整个系统``  
点击``地区格式``标题栏 → 点击``应用到整个系统``  
然后终端运行命令
```
sudo apt install fcitx5*
```

（选装）如果想用谷歌拼音
```
sudo apt install fcitx-googlepinyin
```

接下来重启系统  
重启后就可以使用拼音输入法了

### 安装iptux(信使)
iptux是一个国人开发的开源Linux版飞鸽传书，其中文名为：信使。基于GTK+2，兼容“飞鸽传书”协议的LAN通信、文档传递软件
```
sudo apt install iptux
#sudo apt install libcanberra-gtk-module
sudo ln -s /usr/bin/iptux ~/桌面/iptux.ln
#iptux
```
双击桌面的链接启动即可

### 字体设置

#### 创建临时文件夹
```
mkdir -p ~/work/lch/tmp/cust_fonts
sudo mkdir -p /usr/share/fonts/cust_fonts
```

#### 复制 Windows字体
路径为
```
%windir%\fonts
```
直接复制出来即可，注意字体文件后缀是 ``ttf`` 格式  
复制到 ``~/work/lch/tmp/cust_fonts``

#### 复制 更纱黑体NerdFonts(Sarasa Gothic Nerd Fonts)
- sarasa-mono-sc-regular.ttf（中文开发）
- sarasa-mono-sc-light.ttf（中文开发）
- sarasa-mono-j-regular.ttf（日文开发）
- sarasa-mono-j-light.ttf（日文开发）

复制到 ``~/work/lch/tmp/cust_fonts``  

#### 拷贝字体到安装路径下
```
sudo cp ~/work/lch/tmp/cust_fonts/* /usr/share/fonts/cust_fonts
```

#### 修改权限
```
sudo chmod 644 /usr/share/fonts/cust_fonts/*
sudo chown root:root /usr/share/fonts/cust_fonts/*
ls -al /usr/share/fonts/cust_fonts
```

#### 生成字体的索引信息
```
#sudo apt install ttf-mscorefonts-installer
#sudo apt install fontconfig
cd /usr/share/fonts/cust_fonts
sudo mkfontscale
sudo mkfontdir
```

#### 更新字体缓存
```
sudo fc-cache -fv
```

#### 确认
```
fc-list
```

### 安装neofetch显示系统信息
```
sudo apt install neofetch
```

### 安装Chromium浏览器
```
#sudo apt install chromium-browser chromium-browser-l10n
sudo apt install chromium-browser
sudo ln -s /usr/bin/chromium ~/桌面/chromium.ln
#chromium
```

### 安装VSCode
访问VSCode官网，直接下载deb，下载后将deb文件放到 ``~/work/lch/tmp``  
然后运行命令
```
cd ~/work/lch/tmp
sudo apt install -y ./code_1.84.1-1699275408_amd64.deb
```

### 安装Wezterm
笔者安装这个非常慢，感觉是显卡驱动的问题，所以用的 ``Alacritty``
```
cd ~/work/lch/tmp
curl -LO https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
sudo apt install -y ./wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
```

### 安装Alacritty
```
sudo add-apt-repository ppa:aslatter/ppa
cd /etc/apt/sources.list.d
ls
sudo vim aslatter-ppa-jammy.list
```
将文件中 https://ppa.launchpadcontent.net 替换为 https://launchpad.proxy.ustclug.org
```
sudo apt update
sudo apt install alacritty
```

### 开发环境构建
看 [Linux环境设置总结](./Linux-env_zh_CN.md) 即可
