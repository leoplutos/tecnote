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

4. 重启后会提示你拔出U盘后，按回车。操作即可

5. 重启完成后，就可以用先前设置好的用户名和密码登录到 Linux Mint 21 桌面了

### 关于磁盘分区
因为笔者不装双系统，所以直接选择的 ``清除整个磁盘并安装 Linux Mint``  
有分区需求可以参照 [这个文章](https://blog.csdn.net/m0_47670683/article/details/111569309)

## 安装后的设置

因为Mint安装好后没有 ``Vim``，只有 ``nano``。在这里记录一下nano的快捷键  
- CTRL+o 回车 保存
- CTRL+x 退出
- SHIFT+方向 选择
- ALT+6 复制
- CTRL+u 粘贴

### 更新源
会收到提示先选择本地软件源，没注意到提示的可以自行点 ``系统设置-软件源``  
笔者选择的是 ``TUNA`` 清华大学源  
根据 [Linux环境设置总结](./Linux-env_zh_CN.md) 里面的 ``更换国内源`` 部分直接修改文件即可（使用nano直接修改）

### 语言与输入法

### 字体设置

### 开发环境构建
看 [Linux环境设置总结](./Linux-env_zh_CN.md) 即可
