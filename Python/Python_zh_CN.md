# Python相关

## 学习Python
* [Python - 100天从新手到大师](https://github.com/jackfrued/Python-100-Days)  
* [Redis教程](https://github.com/jackfrued/Python-100-Days/blob/master/Day36-40/NoSQL%E6%95%B0%E6%8D%AE%E5%BA%93%E5%85%A5%E9%97%A8.md)  
* [Selenium教程](https://github.com/jackfrued/Python-100-Days/blob/master/Day61-65/64.%E4%BD%BF%E7%94%A8Selenium%E6%8A%93%E5%8F%96%E7%BD%91%E9%A1%B5%E5%8A%A8%E6%80%81%E5%86%85%E5%AE%B9.md)  
* [Python CHEATSHEET (中文速查表)](https://github.com/skywind3000/awesome-cheatsheets/blob/master/languages/python.md)

## pip使用清华源

### 临时使用
```
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
```
注意，simple 不能少, 是 https 而不是 http

### 设为默认
升级 pip 到最新的版本 (>=10.0.0) 后进行配置：
```
python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```
更多：  
https://mirrors.tuna.tsinghua.edu.cn/help/pypi/

除了清华源，还可以使用阿里源  
https://mirrors.aliyun.com/pypi/simple

## 关于Python的父目录子目录

### 引用子目录下的内容
需要在子目录下新建 ``__init__.py`` ，将子目录升级为 ``模块``，``__init__.py`` 内容可以为空  
引入方式为
```
from {子目录名} import {子目录下的py文件名}
```

### 引用父目录下的内容
需要将该父目录添加到当前文件的 ``sys.path`` 中
```
import sys
sys.path.append("..") #相对路径或绝对路径
```

### 引用同级目录下的内容
直接 import 即可
```
import b
```
或者
```
from b import *
```

## Python自带的编辑器 ``IDLE``
安装 ``Python`` 之后，在如下路径可以找到 ``idle.bat``
```
{Python安装路径}\Lib\idlelib
```
双击即可启动


## 查看第三方库的路径
```
python -m site
```
```
python -c "import sysconfig; print(sysconfig.get_path('purelib'))"
```
#### 添加其他第三方库路径的方法
在 ``{PythonHome}\Lib\site-packages`` 路径下新建 ``app.pth``  
``app.pth`` 里面记载第三方库路径即可，比如
```
C:\Users\Leo-G5000\Python3rdLib
```
然后确认
```
python -m site
```

## Windows下运行python.exe失效的办法
在 cmd 中运行 ``where python``，如果像下面一样出现了2个可执行文件
```
# where python

C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps\python.exe
D:\Tools\WorkTool\Python\Python312\python.exe
```
那么可以如下设定  
打开 ``设置`` → 在搜索处输入 ``alias`` → 选择 ``管理应用执行别名``  
将 ``python.exe`` 全部关闭  
再次运行 ``where python``，发现只剩下我们安装的了

## 检查文件扩展名的例子
[getFileExtension.py](getFileExtension.py)

这是一个python的脚本，用来列出一个路径下文件的所有扩展名
- 目标1：出力每个文件的路径，名称，扩展名
- 目标2：统计所有扩展名，出力
- 目标3：check所有文件的换行符，出力(这个例子统计有换行符为CRLF的文件)

## 复原Sakura Editor的grep替换操作
[sakuraSkroldReset.py](sakuraSkroldReset.py)

这是一个python的脚本，用来复原Sakura Editor的grep替换操作  
在Sakura Editor中，如果使用了grep替换操作后，会生成一个扩展名为.skrold的文件  
这个脚本的目的就是找到所有扩展名为.skrold的文件并且复原到源文件  
比如：a.txt.skrold的内容 复制到 a.txt

## 工程打包分发
https://github.com/skywind3000/PyStand

## 网页自动化工具DrissionPage
 - [官网](https://www.drissionpage.cn/)
 - [Github](https://github.com/g1879/DrissionPage)

