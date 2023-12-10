# Git-bash安装pacman

## 前言
git的windows版本默认是不带pacman包管理器的，这里记录下安装方法。

## 1.下载git-sdk-64
git-sdk是开发版本，可以在官网下载，也可以在github下载。

* 方法1：去github的web页面下载  
https://github.com/git-for-windows/git-sdk-64
* 方法2：用git命令
```git
git clone --depth=1 https://github.com/git-for-windows/git-sdk-64.git /d/Tools/WorkTool/Team/git-sdk-64
```
* 方法3：下载笔者整理好的zip(42.5M，整理于2023-05-29)  
[git-bash-pacman.zip](git-bash-pacman.zip)  
下载地址
```
https://raw.githubusercontent.com/leoplutos/tecnote/master/Git/git-bash-pacman.zip
https://raw.njuu.cf/leoplutos/tecnote/master/Git/git-bash-pacman.zip
```

## 2.复制所需文件
cmd运行
```
SET DOWNLOAD_REPO_PATH=D:\WorkSpace\Git\tecnote
7z x %DOWNLOAD_REPO_PATH%\Git\git-bash-pacman.zip -o%DOWNLOAD_REPO_PATH%\Git\git-bash-pacman
```

git-bash中运行
```
export DOWNLOAD_REPO_PATH="/d/WorkSpace/Git/tecnote/Git/git-bash-pacman"
cp $DOWNLOAD_REPO_PATH/usr/bin/pacman* /usr/bin/
ll /usr/bin/ | grep pacman
cp -a $DOWNLOAD_REPO_PATH/etc/pacman.* /etc/
ll /etc/ | grep pacman
mkdir -p /var/lib/
cp -a $DOWNLOAD_REPO_PATH/var/lib/pacman /var/lib/
ll /var/lib/pacman
mkdir -p /usr/share/makepkg/
cp -a $DOWNLOAD_REPO_PATH/usr/share/makepkg/util* /usr/share/makepkg/
ll /usr/share/makepkg/
```

## 3.运作pacman确认
```bash
pacman --version
```

## 4.添加清华源和中科大源
git_home/etc/pacman.d 目录下有三个文件（修改前记得备份）
* [mirrorlist.msys](mirrorlist.msys)
* [mirrorlist.mingw64](mirrorlist.mingw64)
* [mirrorlist.mingw32](mirrorlist.mingw32)

首先是 **mirrorlist.msys**，将以下2行加到Primary的最上面（第1行和第2行）
```
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch/
Server = https://mirrors.ustc.edu.cn/msys2/msys/$arch/
Server = https://mirror.msys2.org/msys/$arch/
```

**mirrorlist.mingw64**，将以下2行加到Primary的最上面（第1行和第2行）
```
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64/
Server = https://mirrors.ustc.edu.cn/msys2/mingw/x86_64/
Server = https://mirror.msys2.org/mingw/x86_64/
```

**mirrorlist.mingw32**，将以下2行加到Primary的最上面（第1行和第2行）
```
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686/
Server = https://mirrors.ustc.edu.cn/msys2/mingw/i686/
Server = https://mirror.msys2.org/mingw/i686/
```

**运作pacman确认**
```bash
pacman -Sy
```
这句命令的意思是同步本地软件数据库,如果看到了以下几句，说明没有问题
```
:: Synchronizing package databases...
 clangarm64 is up to date
 git-for-windows is up to date
 git-for-windows-mingw32 is up to date
 mingw32 is up to date
 mingw64 is up to date
 ucrt64 is up to date
 clang32 is up to date
 clang64 is up to date
 msys is up to date
```
**覆盖安装\/更新vim**
```
pacman -S --overwrite="*" vim
vim --version
```
**安装tmux**
```bash
pacman -S tmux
```
**安装Fish shell**
```bash
pacman -S fish
pacman -S pcre2
pacman -S libpcre2_16
#pacman -S mingw-w64-x86_64-pcre2
# 同步安装所有工具，慎用
# pacman -Syu
pacman -S gcc
fish
```
**查看Fish shell设定**
```bash
cat ~/.config/fish/config.fish
```
**笔者的设定例子**  
[config.fish](../Linux/linux_rc/fishrc/config.fish)

## 5.pacman命令

#### 常用命令
pacman命令较多，作为新手，将个人最常用的命令总结如下：

升级系统及所有已经安装的软件
```bash
pacman -Syu
```
安装软件。也可以同时安装多个包，只需以空格分隔包名即可
```bash
pacman -S 软件名
```
删除软件，同时删除本机上只有该软件依赖的软件
```bash
pacman -Rs 软件名
```
删除软件，同时删除不再被任何软件所需要的依赖
```bash
pacman -Ru 软件名
```
在仓库中搜索含关键字的软件包，并用简洁方式显示
```bash
pacman -Ssq 关键字
```
搜索已安装的软件包
```bash
pacman -Qs 关键字
```
查看某个软件包信息，显示软件简介,构架,依赖,大小等详细信息
```bash
pacman -Qi 软件名
```
列出软件仓库上所有的软件包组。
```bash
pacman -Sg
```
查看某软件包组所包含的所有软件包。
```bash
pacman -Sg 软件包组
```
清理未安装的包文件，包文件位于 /var/cache/pacman/pkg/ 目录。
```bash
pacman -Sc
```
清理所有的缓存文件。
```bash
pacman -Scc
```

#### 安装软件
pacman -S 软件名: 安装软件。也可以同时安装多个包，只需以空格分隔包名即可。  
pacman -S --needed 软件名1 软件名2: 安装软件，但不重新安装已经是最新的软件。  
pacman -Sy 软件名：安装软件前，先从远程仓库下载软件包数据库(数据库即所有软件列表)。  
pacman -Sv 软件名：在显示一些操作信息后执行安装。  
pacman -Sw 软件名: 只下载软件包，不安装。  
pacman -U 软件名.pkg.tar.gz：安装本地软件包。  
pacman -U http://www.example.com/repo/example.pkg.tar.xz: 安装一个远程包（不在 pacman 配置的源里面）。

#### 更新系统
pacman -Sy: 从服务器下载新的软件包数据库（实际上就是下载远程仓库最新软件列表到本地）。  
pacman -Su: 升级所有已安装的软件包。

#### 卸载软件
pacman -R 软件名: 该命令将只删除包，保留其全部已经安装的依赖关系  
pacman -Rv 软件名: 删除软件，并显示详细的信息  
pacman -Rs 软件名: 删除软件，同时删除本机上只有该软件依赖的软件。  
pacman -Rsc 软件名: 删除软件，并删除所有依赖这个软件的程序，**慎用**  
pacman -Ru 软件名: 删除软件,同时删除不再被任何软件所需要的依赖  

#### 搜索软件
pacman -Ss 关键字: 在仓库中搜索含关键字的软件包（本地已安装的会标记）  
pacman -Sl :
显示软件仓库中所有软件的列表
可以省略，通常这样用:pacman -Sl | 关键字  
pacman -Qs 关键字: 搜索已安装的软件包  
pacman -Qu: 列出所有可升级的软件包  
pacman -Qt: 列出不被任何软件要求的软件包
参数加q可以简洁方式显示结果，比如pacman -Ssq gcc会比pacman -Ss gcc显示的好看一些。  
pacman -Sl | gcc跟pacman -Ssq gcc很接近，但是会少一些和gcc有关但软件名不包含gcc的包。

#### 查询软件信息
pacman -Q 软件名: 查看软件包是否已安装，已安装则显示软件包名称和版本  
pacman -Qi 软件名: 查看某个软件包信息，显示较为详细的信息，包括描述、构架、依赖、大小等等  
pacman -Ql 软件名: 列出软件包内所有文件，包括软件安装的每个文件、文件夹的名称和路径
软件包组  
pacman -Sg: 列出软件仓库上所有的软件包组  
pacman -Qg: 列出本地已经安装的软件包组和子包  
pacman -Sg 软件包组: 查看某软件包组所包含的所有软件包  
pacman -Qg 软件包组: 和pacman -Sg 软件包组完全一样  
很多人建议通过安装软件组来安装工具链，例如：
```bash
pacman -S mingw-w64-x86_64-toolchain
pacman -S mingw-w64-i686-toolchain
pacman -S mingw-w64-x86_64-qt5
pacman -S base-devel
```
但是这样比较浪费空间。实际上如果把gcc, qt, clang等安装上，msys2就要占掉超过10G的硬盘空间，所以个人很少直接安装软件组。

#### 清理缓存
pacman -Sc：清理未安装的包文件，包文件位于 /var/cache/pacman/pkg/ 目录。  
pacman -Scc：清理所有的缓存文件。  
