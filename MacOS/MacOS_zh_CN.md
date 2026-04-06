# Mac相关

## 快捷键

### 切换输入法
按下 ``地球仪键``  
或者  
``Control + 空格键`` 在不同的输入法之间切换

### 画面最大化
- 按住 ``Option 键`` 点击 ``绿色按钮``，窗口会变成 ``填满整个屏幕但不进入全屏模式``
- ``Control + Command (⌘) + F`` 窗口进入 ``全屏模式``

### 截图
- ``Command + Control + Shift + 4``  选区截图复制
- ``Command + Control + Shift + 3``  整屏截图复制

然后你可以直接粘贴到聊天窗口、文档、图像编辑器中

如果需要2次编辑，打开 ``Preview`` App ，按下 ``Command (⌘) + N``，即可编辑图片内容

### 显示桌面
``Fn + F11``  所有窗口会滑到两侧，露出桌面，再按一次恢复原状

### 锁屏
``Control + Command + Q``

### 外接显示器投屏
``Command + F1``

### 只看当前这个App的窗口
``Control + ↓（向下箭头）``
或者
``系统设置`` → ``触控板`` → ``更多手势`` → ``开启 App Exposé`` → 选择 ``四指下滑``

### 三指拖动窗口
``系统设置`` → ``辅助功能`` → ``指针控制`` → ``触控板设置`` → 勾选 ``用触控板拖移`` → 选择 ``三指拖移``

开启后当鼠标指针在标题栏时使用三指拖动即可拖动窗口

### 强制退出软件
- ``Command + Option + ESC``  类似 Windows 任务管理器

### 移动文件

Windows 是 ``Ctrl + X`` 剪切，但 Mac 上这样是没反应的

正确方式是

1. 先用 ``Command + C`` 复制文件
2. 然后在新位置按 ``Command + Option + V`` 移动文件

### 文件快速全屏预览
- ``空格`` : 预览文件
- ``Option + 空格`` : 全屏预览

### 彻底删除文件
- ``Command + Delete`` : 把文件丢进废纸篓
- ``Command + Option + Delete`` : 直接彻底删除

## 常用设置

### 总是在Tab打开新文件
``系统设置`` → ``桌面与Dock`` → ``窗口`` → ``将文稿打开为标签页``　设置为　``始终``

### 固定桌面空间顺序
``系统设置`` → ``桌面与Dock`` → ``Mission Control`` → 取消勾选 ``根据最近使用的情况自动重新排列空间``

### Finder中显示／隐藏隐藏文件
``Command + Shift + .（句号）``  显示／隐藏隐藏文件

### Finder显示所有文件的扩展名
``Finder`` → ``设置`` → ``高级`` → ``显示所有文件名扩展名``

### Finder所有文件夹自动排列
``Finder`` → ``Command (⌘) + J`` → ``表示順序`` → ``名前``

然后点击最下面的 ``作为默认使用`` 按钮

### Finder文件夹排在顶部
``Finder`` → ``设置`` → ``高级`` → ``文件夹排在顶部：在名称排序时（Keep folders on top when sorting by name）``

### 更改音量时播放声音反馈
``系统设置`` → ``声音`` → ``在更改音量时播放声音反馈（Play feedback on volume change）``

### 更改显示设置
``系统设置`` → ``显示器`` → ``True Tone`` → 关闭
``系统设置`` → ``显示器`` → ``Night Shift`` → 关闭

### 在右上角控制中心显示 VPN 的方法
``系统设置`` → ``控制中心与菜单栏`` → 找到 VPN → 选择 ``在控制中心显示``

### MacOS显示节假日

打开``日历`` → ``文件`` → ``新建日历订阅`` → 输入下面的 ``URL``

#### 中国大陆节假日
```
https://calendars.icloud.com/holidays/cn_zh.ics
```

#### 日本の祝日
```
https://calendars.icloud.com/holidays/jp_ja.ics
```

## 常用软件

### Homebrew

``Homebrew`` 是一款 ``Mac OS`` 平台下的软件包管理工具, 拥有安装、卸载、更新、查看、搜索等很多实用的功能

https://brew.sh/

#### 国内安装Homebrew

安装脚本
```bash
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
```

卸载脚本
```bash
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/HomebrewUninstall.sh)"
```

### 菜单栏隐藏

#### Ice（推荐）
- [官网](https://icemenubar.app/)
- [Github](https://github.com/jordanbaird/Ice)

```bash
brew install --cask jordanbaird-ice
```

#### Hidden Bar
- [MacAppStore](https://apps.apple.com/us/app/hidden-bar/id1452453066)
- [Github](https://github.com/dwarvesf/hidden)

```bash
brew install --cask hiddenbar
```

### 解压缩 - Keka
- [官网](https://www.keka.io/)
- [MacAppStore](https://apps.apple.com/us/app/keka/id470158793)
- [Github](https://github.com/aonez/Keka)

```bash
brew install --cask keka
```

#### 安装选择
下载 DMG 安装或者通过 brew 安装即可，Keka 开发者表示

> App Store 版本是用来支持开发的。如果你喜欢 Keka，可以通过购买 App Store 版本来支持我。功能上完全一样。

#### 设置自动排除 ``.DS_Store`` 和 ``__MACOSX`` 文件
1. 第一次启动后会弹出一个小菜单，选中 ``不包含Mac资源（例：.DS_Store）``
2. 别关闭这个小菜单，点击菜单栏上面的 ``Keka`` → ``设定`` → ``压缩``Tab → 选中 ``不包含Mac资源（例：.DS_Store）``

#### 使用方法
在 ``Finder`` 中选择你要压缩的文件夹 → ``鼠标右键`` → ``服务`` → ``使用Keka压缩``

### 其他解压缩
- [The Unarchiver](https://apps.apple.com/cn/app/the-unarchiver/id425424353?ign-mpt=uo%3D2&mt=12&v0=WWW-NAUS-ITUHOME-NEWAPPLICATIONS)
- [解压-RAR ZIP 7Z解压助手纯净版](https://apps.apple.com/cn/app/%E8%A7%A3%E5%8E%8B-rar-zip-7z%E8%A7%A3%E5%8E%8B%E5%8A%A9%E6%89%8B%E7%BA%AF%E5%87%80%E7%89%88/id1537056818)

### 文本编辑器 - CotEditor
- [官网](https://coteditor.com/)
- [Github](https://github.com/coteditor/CotEditor)

```bash
brew install --cask coteditor
```

#### CotEditor主题文件
- [lch.cottheme](../DevTool/coteditor_conf/lch.cottheme)

### 大文件查看 - Klogg
- [官网](https://klogg.filimonov.dev/)
- [Github](https://github.com/variar/klogg)

```bash
brew install --cask klogg
```

### 字体 Font
- [SFMono-Nerd-Font-Ligaturized](https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized)

```bash
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
brew install --cask font-sf-mono-nerd-font-ligaturized
```

### 展示设备状态 - Stats
Stats 可以在状态栏展示设备 CPU、内存、网络、磁盘、电源灯信息
- [官网](https://mac-stats.com/)
- [Github](https://github.com/exelban/stats)

```bash
brew install stats
```

### 终端

#### Ghostty（推荐）
- [官网](https://ghostty.org/)
- [Github](https://github.com/ghostty-org/ghostty)

```bash
brew install --cask ghostty
```

默认设定文件目录
```
$HOME/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty
```

笔者的设定文件
- [config.ghostty](../DevTool/Ghostty-conf/config.ghostty)

#### iTerms2
- [官网](https://iterm2.com/)

```bash
brew install --cask iterm2
```

**iTerms2的Profile文件**  
- [lch.json](../DevTool/iterm2_conf/lch.json)

**iTerms2右键粘贴剪切板内容**

``iTerms2`` → ``Settings`` → ``Pointer`` → ``Bindings``  
- Paste from Clipboard : Righbutton single clike
- Open Context Menu : Middle single clike

**iTerms2快速连接服务器**
1. ``iTerms2`` → ``Settings`` → ``Profiles`` → 复制一份
2. 选中复制出的 Profile 按下 ``Command + Option + F`` 打开 Password Manager
    - 按下左下角的的 ``+`` 新建密码管理
        - ``Account`` : 账号名，例：ZeroPrj-IT
        - ``User name`` : 登录服务器用户名
        - ``Password`` : 登录服务器密码
    - 建立好之后关闭即可
3. 选中复制出的 Profile 按如下设定
    - ``General``标签页
        - ``Name`` : Profile名，例：ZeroPrj-IT
        - ``Shortcut Key`` : 设定快捷键
        - ``Tags`` : 分组用，设定项目名即可，例：ZeroPrj
        - ``Badge`` : 在终端背景上面显示的标识，提示当前是哪个环境，例：    ZeroPrj-IT
        - ``Command`` : 选择 ``Command``，后面的命令填写连接服务器的命令，例：``ssh lch@localhost -p 2222``
    - ``Adavanced``标签页
        - 点击 ``Triggers`` 右侧的 ``Edit`` 按钮
            - ``Regular Expression`` : 如果登录服务器时提示的内容为 ``lch@localhost 's password: `` 的话，可以设定为 ``password:``
            - ``Action`` : Open Password Manager...
            - ``Parameters`` : 选中在第2步设置好密码
            - ``Instant`` : 选中

做好了 Profile 后，按下设定的快捷键，即可连接目标服务器

#### WezTerm
- [官网](https://wezterm.org/index.html)

#### 默认终端 Terminal.app

**Terminal.app主题文件**  
- [lch.terminal](../DevTool/terminal.app_conf/lch.terminal)

### 鼠标和触控板分别设置滚动方向

#### MacMouseFix（推荐）

Mac Mouse Fix可以将苹果触控板拥有的所有功能（甚至更多）赋予给你那只精准且符合人体工学设计的第三方鼠标

- [官网](https://macmousefix.com/zh-Hans/)
- [Github](https://github.com/noah-nuebling/mac-mouse-fix)

```bash
brew install mac-mouse-fix
```

#### MOS
- [官网](https://mos.caldis.me/)
- [Github](https://github.com/Caldis/Mos)

```bash
brew install --cask mos
```

默认设定即可

#### Scroll Reverser
- [官网](https://pilotmoon.com/scrollreverser/)

```bash
brew install scroll-reverser
```

#### Scroll Reverser设定
- ``系统设置`` → ``鼠标`` → ``自然滚动`` → 开启
- ``Scroll Reverser``
    - 勾选上面 ``启用 Scroll Reverser``
    - 勾选左侧 滚动方向中的 ``翻转垂直滚动（纵方向）``
    - 勾选右侧 输入设备中的 ``翻转鼠标``

其他均不选即可

### 窗口管理工具‌ Rectangle
- [官网](https://rectangleapp.com/)
- [Github](https://github.com/rxhanson/Rectangle)

```bash
brew install --cask rectangle
```

``Control + Option + 回车`` : 窗口最大化

### 应用卸载以及垃圾清理 腾讯柠檬
- [官网](https://lemon.qq.com/)
- [Github](https://github.com/Tencent/lemon-cleaner)

```bash
brew install --cask tencent-lemon
```

### 启动器

#### 选项1：Raycast（推荐）
- [Raycast](https://www.raycast.com/)

#### 选项2：Wox
- [Wox](https://github.com/Wox-launcher/Wox)

### 剪切板管理工具 Maccy
- [官网](https://maccy.app/)
- [Github](https://github.com/p0deje/Maccy)

```bash
brew install maccy
```

### 局域网文件传输 LocalSend

LocalSend 是一个自由、开源的应用程序，允许你在本地网络上安全地与附近设备分享文件和消息，无需互联网连接。

- [官网](https://localsend.org/zh-CN)
- [Github](https://github.com/localsend/localsend)
- [网页版](https://web.localsend.org/zh-CN)

```bash
brew install --cask localsend
```

### Finder在终端和文本编辑器中打开当前目录 OpenInTerminal
- [Github](https://github.com/Ji4n1ng/OpenInTerminal)
- [完全版中文说明](https://github.com/Ji4n1ng/OpenInTerminal/blob/master/Resources/README-zh.md)
- [Lite版中文说明](https://github.com/Ji4n1ng/OpenInTerminal/blob/master/Resources/README-Lite-zh.md)

```bash
brew install --cask openinterminal-lite
# 或者
brew install --cask openineditor-lite
```

当设置了默认终端之后，选择框将不会再出现。如果想要重新设置默认终端，请在终端中输入以下命令。然后重新运行应用。

```bash
# 对于 OpenInTerminal-Lite:
defaults remove wang.jianing.app.OpenInTerminal-Lite LiteDefaultTerminal
# 对于 OpenInEditor-Lite:
defaults remove wang.jianing.app.OpenInEditor-Lite LiteDefaultEditor
```

### Finder右键新建文件
- [MacNewFile](https://github.com/GarfieldFluffJr/MacNewFile)
- [iRightMenu](https://apps.apple.com/us/app/irightmenu/id1542347829?mt=12)

### Docker

#### 选项1：OrbStack（推荐）
- [官网](https://orbstack.dev/)
- [Github](https://github.com/orbstack/orbstack)

```bash
# 安装
brew install orbstack
# 运行容器
docker run -p 80:80 docker/getting-started
```

#### 选项2：Colima
- [Github](https://github.com/abiosoft/colima)

```bash
# 安装
brew install colima docker
# 启动 Colima 指定 runtime 为 docker
colima start --runtime docker
# 运行容器
docker run hello-world
```

如果之后运行 docker 命令出了问题可以尝试以下命令
```bash
# 检查状态
colima status
# 停止 Colima
colima stop
# 删除 Colima
colima delete
# 重新启动 Colima 指定 runtime 为 docker
colima start --runtime docker
```

#### 选项3：Podman
- [官网](https://podman.io/docs/installation)

```bash
brew install podman
podman machine init
podman machine start
podman info
podman run -d -p 8000:80 nginx
podman ps
curl localhost:8000
```

### 截图贴图工具
使用系统自带的截屏（``Command + Shift + 5``） 可以满足基本需求，下面的按需选择
- [Snipaste](https://www.snipaste.com/)
```bash
brew install snipaste --cask
```
- [shottr](https://shottr.cc/)
- [iShot](https://apps.apple.com/cn/app/ishot-%E4%BC%98%E7%A7%80%E7%9A%84%E6%88%AA%E5%9B%BE%E8%B4%B4%E5%9B%BE%E5%BD%95%E5%B1%8F%E5%BD%95%E9%9F%B3ocr%E7%BF%BB%E8%AF%91%E5%8F%96%E8%89%B2%E6%A0%87%E6%B3%A8%E5%B7%A5%E5%85%B7/id1485844094)

### WinSCP替代

#### FileZilla（推荐）
- [FileZilla](https://filezilla-project.org/)

#### Commander One
- [Commander One](https://mac.eltima.com/file-manager.html)
```bash
brew install --cask commander-one
```

### WinMerge替代

#### FileMerge（推荐）
FileMerge 是 Mac 自带的文件比较工具。它是 Xcode 开发工具包的一部分，可以轻松地比较文件差异并合并文件。

``Xcode`` → ``Open Developer Tool`` → ``FileMerge``

#### P4Merge
- [P4Merge](https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge)
```bash
brew install --cask p4v
```

#### DiffMerge
有乱码问题，推荐使用 ``P4Merge``
- [DiffMerge](https://www.sourcegear.com/diffmerge/)

```bash
brew install --cask diffmerge
```

### 视频播放器 - IINA
- [官网](https://iina.io/)
- [Github](https://github.com/iina/iina)

```bash
brew install --cask iina
```

### 录屏

#### 选项1：OBS（推荐）
- [官网](https://obsproject.com/)
- [Github](https://github.com/obsproject/obs-studio)

#### 选项2：QuickRecorder
- [官网](https://lihaoyun6.github.io/quickrecorder/)
- [Github](https://github.com/lihaoyun6/QuickRecorder)

```bash
brew install lihaoyun6/tap/quickrecorder
```

#### 选项3：Kap
- [官网](https://getkap.co/)
- [Github](https://github.com/wulkano/Kap)

### DB客户端

#### 选项1：``SQL Workbench/J``
- [官网](https://www.sql-workbench.eu/index.html)

在 ``下载页面`` 直接下载 MacOS 版本即可 ``Download package for MacOS``

#### 选项2：DBeaver
- [官网](https://dbeaver.io/)

```bash
brew install --cask dbeaver-community
```

#### 选项3：``Beekeeper Studio``
- [官网](https://www.beekeeperstudio.io/)
- [Github](https://github.com/beekeeper-studio/beekeeper-studio)

#### 选项4：HeidiSQL
- [官网](https://www.heidisql.com/)
- [Github](https://github.com/HeidiSQL/HeidiSQL)

#### 选项5：TablePlus
- [官网](https://tableplus.com/)

是一个收费的商用软件，但是 ``free trial`` 其实没有时间限制，只是功能限制（2个 tab / 2个窗口等）

#### 选项6：``TablePro``

TablePlus 的开源平替版本

- [官网](https://tablepro.app/)
- [Github](https://github.com/TableProApp/TablePro)

### 中低分辨率显示器开启 HiDPI 选项
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/xzhih/one-key-hidpi/master/hidpi.sh)"
```

- [one-key-hidpi](https://github.com/xzhih/one-key-hidpi)
- [BetterDisplay](https://github.com/waydabber/BetterDisplay)

## Zsh
从 MacOS Catalina 开始 默认Shell 修改为了 Zsh  
下面是笔者的 zshrc 配置文件  
- [.zshrc](./mac_rc/zshrc/.zshrc)

## awesome-mac
- [Github](https://github.com/jaywcjlove/awesome-mac)

## 黑苹果
https://dortania.github.io/OpenCore-Install-Guide/  
https://rufus.ie/zh/  
https://github.com/daliansky/Hackintosh  

