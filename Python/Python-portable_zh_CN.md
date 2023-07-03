# 制作python绿色版

## 下载嵌入版本
在python官网：  
https://www.python.org/downloads/windows/  
找到最新稳定版本的 “Download Windows x86-64 embeddable zip file”，即可下载。

## 解压
解压至自定义位置，内容很简洁，一些自带库应该在python38.zip中。

## 安装pip
在官方文档  
https://pypi.org/project/pip/#description  
中，提供了3种方法，这里介绍其中的2种方法


### 安装pip方法1：采用get-pip.py

#### 下载get-pip.py
右键点击  
https://bootstrap.pypa.io/get-pip.py  
链接另存为，下载 get-pip.py 至 python 根目录下

#### 修改 ._pth 文件
在 python 根目录下修改 python38._pth 文件，  
去掉 #import site 前的 #号，即放开 import site；若不放开将会pip无法正确安装。
```
python38.zip
.
import site
```

#### 运行get-pip.py
打开cmd，路径转换到python根目录下，输入
```
python get-pip.py
```
会自动安装 pip，setuptools，wheel 等几个工具。  
Lib/site-packages下为第三方库，Scripts下安装有pip。

#### 修改pip.exe
pip安装是绝对路径，移动 python 文件夹后 pip 又会无法使用，需要进一步修改pip.exe文件。  
进入Scripts文件夹，可删除pip.exe以外的pip(比如：pip3.exe，pip3.8.exe)文件，其实一模一样。  
用 winhex 或者 VSCode的[Hex Editor]插件 打开pip.exe，查找 python 关键字，可以看到用的是绝对路径，修改为相对路径。  
修改步骤：  

1. 拉到exe文件的最下面，将 ``python.exe`` 从绝对路径修改成相对路径 
``#!../python.exe``
2. 在 ``#!../python.exe`` 后面加上 ``0D 0A``
3. 一般修改之后后面会有一些残留，可以添加 ``20`` 补位

注：
| 符号  | 16进制 |
|-------|--------|
| LF    | 0A     |
| CR LF | 0D 0A  |
| CR    | 0D     |
| #     | 23     |
| 空格  | 20     |


### 安装pip方法2：采用独立的pip.pyz程序

pip.pyz应用程序目前处于试验阶段。只适合临时使用，不建议在生产环境中使用。  
pip.pyz应用程序可以在任何受支持的 Python 版本运行

#### 下载pip.pyz

可以从这里下载：  
https://bootstrap.pypa.io/pip/pip.pyz  
将下载的 pip.pyz 放在 python 根目录下

#### 使用pip.pyz的运行方法
```
python pip.pyz --help
python pip.pyz install pandas
```

## 一些错误的解决

#### proxy代理错误
很多时候在公司内网里，需要 proxy 代理设定才可以使用pip。  
进入cmd，在运行 pip 之前运行下面命令即可
```
set HTTPS_PROXY=http://your.network.com:8080
```

#### SSL: CERTIFICATE_VERIFY_FAILED错误
在使用pip的时候，有时会发生SSL证明书错误，使用 trusted-host 参数即可。
```
pip --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org install pandas
```
或者
```
python pip.pyz --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org install pandas
```
