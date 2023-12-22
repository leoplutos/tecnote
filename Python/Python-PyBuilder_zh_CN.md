# PyBuilder相关

## 简介
PyBuilder 是一个 100% 纯 Python 编写的软件构建工具，主要针对 Python 应用程序。  
PyBuilder 基于依赖编程的概念，但它也带有强大的插件机制，允许构建类似于其他著名（Java）构建工具的构建生命周期。

## 官网
 - [官网](https://pybuilder.io/)
 - [Github](https://github.com/pybuilder/pybuilder)

## 安装
```
# 生产版本
pip install pybuilder

# 开发版本
pip install --pre pybuilder

pyb --version
```

## 使用方法

### 创建工程
``PyBuilder`` 不会生成工程文件夹，新建一个空文件夹后运行
```
pyb --start-project
```
回答一些问题后就会自动创建所需的目录和文件
```
Project name (default: 'PybTest') :
Source directory (default: 'src/main/python') :
Docs directory (default: 'docs') :
Unittest directory (default: 'src/unittest/python') :
Scripts directory (default: 'src/main/scripts') :
Use plugin python.flake8 (Y/n)? (default: 'y') : n
Use plugin python.coverage (Y/n)? (default: 'y') : n
Use plugin python.distutils (Y/n)? (default: 'y') : n

Created 'setup.py'.

Created 'pyproject.toml'.
```
默认的目录结构如下
```
.
├── build.py
├── docs
├── pyproject.toml
├── setup.py
└── src
    ├── main
    │   ├── python
    │   └── scripts
    └── unittest
        └── python
```
可以看出和 ``Maven`` 的结构非常类似

### 基本命令
```
cd D:\WorkSpace\Python\PybTest

# 运行默认任务并且打开详细输出
pyb -v

# 插件任务列表
pyb -t

# 清空编译内容
pyb clean
```

## 使用案例

### 新建工程
```
cd D:\WorkSpace\Python\PybTest
pyb --start-project
```

### 创建文件
依次创建\/修改下面的文件

``build.py``
```
#   -*- coding: utf-8 -*-
from pybuilder.core import use_plugin, init

use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.install_dependencies")

name = "PybTest"
default_task = "publish"


@init
def initialize(project):
    # 使用第三方库mockito
    project.build_depends_on("mockito")
    # 使用第三方库Faker
    project.build_depends_on("Faker")


@init
def set_properties(project):
    pass
```

``src/main/python/app.py``
```
import logging
from sub_module import sub_mod1
from sub_module import sub_mod2


def main():
    logging.basicConfig(
        level=logging.DEBUG,
        format="%(asctime)s %(levelname)s [%(process)s] %(filename)s:%(lineno)d - %(message)s",
    )
    print("这是一个main函数")
    sub_mod1.sub_fun1()
    sub_mod2.sub_fun2()


if __name__ == "__main__":
    main()
```

``src/unittest/python/app_tests.py``
```
from mockito import mock, verify
import unittest

from app import main


class AppTest(unittest.TestCase):
    def test_main(self):
        # out = mock()
        main()
        # verify(out).write("app\n")
```

``src/main/python/sub_module/__init__.py``(空文件)


``src/main/python/sub_module/sub_mod1.py``
```
#!/usr/bin/python3
# -*- coding: utf-8 -*-

import logging
from faker import Faker


def sub_fun1():
    fake = Faker('zh-CN')
    logging.debug("sub1 function is run.")
    # 使用fake生成一组虚假消息
    logging.info(fake.profile())
    return 1
```

``src/main/python/sub_module/sub_mod2.py``
```
#!/usr/bin/python3
# -*- coding: utf-8 -*-

import logging


def sub_fun2():
    logging.debug("sub2 function is run.")
    data = [
        ('Apple', 'Fruit'),
        ('Beetroot', 'Vegetable'),
        ('Carrot', 'Vegetable'),
        ('Date', 'Fruit'),
        ('Eggplant', 'Vegetable'),
        ('Fig', 'Fruit'),
    ]
    logging.info(f"sub2 data:{data}")
    return 2
```

### 运行
安装依赖库
```
pyb install_dependencies
```

运行unittest启动主函数
```
pyb -v
```
