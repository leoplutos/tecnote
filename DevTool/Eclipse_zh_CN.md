# Eclipse


## Eclipse的Vim插件
需要安装 ``vrapper`` 插件
#### 手动安装（推荐）
下载  
https://github.com/vrapper/vrapper/releases/download/0.74.0/vrapper_0.74.0_20181124.zip  
后参考 ``Eclipse-PyDev`` 的手动安装步骤  
安装成功后，``Eclipse`` 的左上角就会多出一个类似 ``vim`` 的图标。点击图标即可使用 ``vim`` 操作编辑文档。

#### 参考
http://vrapper.sourceforge.net/update-site/stable  
https://vrapper.sourceforge.net/home/  
https://github.com/vrapper/vrapper  


## Eclipse下开发C/C++
直接使用 ``Eclipse IDE for C/C++ Developers`` 即可  
下载地址：  
https://www.eclipse.org/downloads/packages/release/2023-09/r/eclipse-ide-cc-developers  

创建工程以后  
```
工程处右键 → Properties
```
然后选择
```
C/C++ Build → Environment
```
在 ``PATH`` 最右面加上 ``gcc.exe``的路径即可


## Eclipse下开发Python
需要安装 ``PyDev`` 插件  
``PyDev`` 需要 Java11（或更高），Eclipse 4.6 (Neon) （或更高），Python 2.6 （或更高）  
首先安装一个 ``Eclipse``，选择最基础的 ``Eclipse IDE for Java Developers``  
https://www.eclipse.org/downloads/packages/release/2023-09/r/eclipse-ide-java-developers

#### 市场安装（github访问不了的话会失败）
```
Help → Eclipse Marketplace..
```
在 ``Search`` 输入 ``Pydev``，回车  
找到之后一路全选加确定

#### 手动安装（推荐）
下载  
https://github.com/fabioz/Pydev/releases/download/pydev_10_2_1/PyDev.10.2.1.zip  
后解压缩，放到 eclipse/dropins 文件夹，类似这样  
```
eclipse/
    dropins/
        PyDev.10.2.1/
            features/
            plugins/
```
重启Eclipse，确认
```
Window → Preferences
```
查看是否有 ``PyDev``，如果没有用如下命令重新启动
```
eclise -clean
```

#### 配置解释器
```
Window → Preferences → Pydev → Interpreters → Python Interpreters → New...按钮 → Browse for python/pypy exe
```
选择 ``python.exe`` 的解释器路径即可

#### 创建python工程
```
New → Other → Pydev → Pydev Project
```

#### 参考
https://marketplace.eclipse.org/content/pydev-python-ide-eclipse  
https://www.pydev.org/manual_101_install.html  
https://github.com/fabioz/Pydev  
