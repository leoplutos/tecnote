# Gvim

## 下载
gvim是vim的图形前端。  
下载地址：
* 安装版  
https://www.vim.org/download.php

* 绿色版  
https://ftp.nluug.nl/pub/vim/pc/  
绿色版需要下载2个zip文件，然后解压缩到一个路径下即可。  
基础运行时：vim90rt.zip  
和右边其中任意一个：gvim90.zip or gvim90ole.zip


## gvimrc的加载顺序
gvim优先加载\~/.vimrc，然后加载\~/.gvimrc，所以只需要在~下放入2个文件即可

## gvim快捷键
shift + ins     粘贴

## gvim主题
下载主题文件（比如：Tomorrow-Night.vim）到vim安装路径的colors文件夹下。  
然后rc文件中加入
```
colorscheme Tomorrow-Night
```
即可

## 笔者的gvimrc
* [Vim-conf](Vim-conf)

## 关于设定字体
guifont的参数说明（使用:分割）  
hXX – 文字高  
wXX – 文字宽  
WXX – Window尺寸  
b   – wild (设定700等同粗体)  
i   – 斜体字  
u   – 下划线  
s   – 取消线  
cXX – 文字码 XX。有效的文字为：ANSI, ARABIC, BALTIC, CHINESEBIG5, DEFAULT, EASTEUROPE, GB2312, GREEK, HANGEUL,HEBREW, JOHAB, MAC, OEM, RUSSIAN, SHIFTJIS, SYMBOL, THAI, TURKISH, VIETNAMESE。通常用“cDEFAULT”  
qXX – 品质 XX。有效的品质为：PROOF, DRAFT, ANTIALIASED, NONANTIALIASED, CLEARTYPE, DEFAULT。通常用“qDEFAULT”

## 使用Gvim快速打开文件夹
如果gvim在环境变量里面的话，使用如下命令即可打开当前文件夹
```
gvim .
```
如果gvim没有在环境变量里面（比如免安装版）的话，新建cmd文件
```
start /b D:\Tool\vim90\gvim D:\path\to\YourProject
```
双击cmd文件即可快速打开文件夹（工程）  
注：前面加上 start /b 为不打开控制台  
笔者更喜欢这种方式，只要将所有项目的cmd文件统一放到一起即可快速的打开任意工程

## 将Gvim添加到Windows的发送到

1. 开始->运行，输入sendto
2. 在弹出的窗口中，单击右键，选择新建快捷方式
3. 在需要填入项目位置处（即gvim.exe的路径，以及执行参数），输入
```
"C:\Vim\vim72\gvim.exe" -p --remote-tab-silent "%*"
```
注意：需要在路径上加上引号，如默认的安装路径就是在C:\Program Files下，那么需要在路径上加上引号，即
```
"C:\Program FilesVim\vim72\gvim.exe" -p --remote-tab-silent "%*"
```
4. 输入名字，Vim标签页
5. 同时选中两个文件，然后右键查看发送到，点击Vim标签页

## 在Gvim中使用Python

#### 检查gvim的版本
在Gvim中输入
```
:version
```
主要查看是32bit还是64位，还有就是编译的时候是否带了python
```
MS-Windows 32-bit GUI version with OLE support  
+python/dyn +python3/dyn
```
得知是32bit的版本，并且支持python和python3。

#### vimrc设定
在 vimrc 中加入
```
let &pythonthreedll = 'D:\Tool\python-3.8.10-embed-win32\python38.dll'
```
**注意：dll也一定要是32bit的，如果你的gvim是64bit的话就用64bit的dll**

#### 确认
使用下面的命令，查看Vim内置的Python版本，成功显示即可
```
:python3 import sys; print(sys.version)
```
如果发生

#### 使用内置Python运行程序
打开一个python文件，如下运行即可
```
:!python %
```

#### 将GUI配色转化为终端配色的VIM插件–gui2term.py
这款插件实现了将gvim的配色转化成终端配色的解决方案  
地址：  
[vim官网](https://www.vim.org/scripts/script.php?script_id=2778)  
[github](https://github.com/lilydjwg/winterpy/blob/master/pyexe/gui2term.py)  
主要命令
```
python3 gui2term.py sourcefile newfile
```
用法：  
我们拿著名的desert配色来测试一下：  
1. 把 ``desert.vim`` 改成 ``test.vim``,和 ``gui2term.py`` 放到同一目录。打开 ``test.vim`` ，将 ``let g:colors_name="desert"`` 改为 ``let g:colors_name="test"`` ，并删除掉它的终端配色。
2. 将 ``vim`` 根目录下的 ``rgb.txt`` 放到和 ``gui2term.py`` 同一目录。
3. 执行 ``python3 gui2term.py test.vim test2.vim``
4. 打开 ``test2.vim`` ，将会发现终端配色代码已经生成  

注：``rgb.txt``在vim9开始不存在，要去老版本找  
注2：``gui2term.py`` 默认是不支持utf8的，把所有 ``open(`` 的地方后面加上 ``, encoding='utf-8')`` 即可

## 关于 Windows7 下使用 Gvim
在 Windows7 使用 gvim，默认是无法使用内置终端的，需要一个叫做 winpty 的中间件

#### Winpty下载地址
* [winpty github主页](https://github.com/rprichard/winpty)
* [winpty-0.4.3-msvc2015.zip下载](https://github.com/rprichard/winpty/releases/download/0.4.3/winpty-0.4.3-msvc2015.zip)  

下载好 ``winpty-0.4.3-msvc2015.zip`` 之后，解压缩，在 ``ia32\bin`` 路径下找到这2个文件
 - winpty.dll
 - winpty-agent.exe
将这2个文件复制到gvim根路径下即可。

#### 原理说明
gvim 会在 ``$PATH`` 中寻找 winpty.dll ，可以在 gvim 中使用如下命令确认
```
:echo $PATH
:set winptydll?
```



