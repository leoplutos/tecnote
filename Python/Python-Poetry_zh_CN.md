# Poetry相关

## 简介
Poetry 是一个包管理和打包的工具。  
Poetry 使用 pyproject.toml 和 poetry.lock 文件来管理依赖，类似于 JavaScript/Node.js 的 Npm 和 Rust 的 Cargo


## 官网
 - [官网](https://python-poetry.org/)
 - [Github](https://github.com/python-poetry/poetry)

## 安装
```
pip install poetry

poetry --version
```

## 使用方法

### 修改虚拟环境创建配置
选项 ``virtualenvs.in-project`` 如果未明确设置，poetry 默认会在 ``{cache-dir}/virtualenvs`` 下创建一个虚拟环境  
如果设置为 ``true``，则将在项目根目录中名为 ``.venv`` 的文件夹中创建虚拟环境  
为了对编辑器友好，我们全局设定为``true``
```
poetry config virtualenvs.in-project true
poetry config --list
```

### 自动创建虚拟环境配置
选项 ``virtualenvs.create=true`` 用来自动创建虚拟环境
```
poetry config virtualenvs.create true --local
poetry config --list
```
当参数 ``virtualenvs.create=true`` 时，执行 ``poetry install/add/remove`` 时会检测当前项目是否有虚拟环境，没有就自动创建

### 创建工程
Poetry 会为你生成工程文件夹，所以直接在父目录运行即可
```
cd D:\WorkSpace\Python
poetry new my-package
```
默认的目录结构如下
```
my-package
├── pyproject.toml
├── README.md
├── my_package
│   └── __init__.py
└── tests
    └── __init__.py
```
如果你习惯和 ``Maven`` 类似的结构可以用下面的命令
```
poetry new --src --name main.python my-package
```

### 配置说明
根路径下的 ``pyproject.toml`` 文件，该文件的主要用途是依赖管理、构建、打包、发布
 - tool.poetry.dependencies：项目需要的所有依赖包
 - tool.poetry.dev-dependencies：仅用于开发的依赖包
 - tool.poetry.source：指定项目的安装源
 - tool.poetry.scripts：设定运行脚本（类似Node.js）

#### 配置示例
``pyproject.toml``
```
[tool.poetry.dependencies]
python = "^3.8"
faker = "^21.0.0"

[[tool.poetry.source]]
name = "aliyun"
url = "https://mirrors.aliyun.com/pypi/simple/"
#name = "tsinghua"
#url = "https://pypi.tuna.tsinghua.edu.cn/simple"
priority = "default"
```

#### 虚拟环境下运行python命令
执行app.py文件
```
poetry run python app.py
```
显式的激活虚拟环境
```
poetry shell
```
查看虚拟环境信息
```
poetry env info
poetry env list
```
删除虚拟环境
```
poetry env remove python
或者
poetry env remove python3
```

### 安装依赖
可以使用install命令直接解析并安装pyproject.toml的依赖包
```
poetry install
```
也可以可以使用add命令来安装Python工具包
```
poetry add Faker
```
查看依赖包
```
poetry show
```

### 打包与发布
构建可安装的 ``*.whl`` 和 ``tar.gz`` 文件
```
poetry build
```

## 使用案例

### 新建工程
```
cd D:\WorkSpace\Python
poetry new --src PoetryTest
```

### 创建文件
依次创建\/修改下面的文件

``pyproject.toml``
```
[tool.poetry]
name = "poetrytest"
version = "0.1.0"
description = ""
authors = ["chunhao.liang <chunhao.liang@yidatec.com>"]
readme = "README.md"
packages = [
  {include = "poetrytest", from = "src"},
  {include = "sub_module", from = "src/poetrytest" },
]

[tool.poetry.dependencies]
python = "^3.8"
faker = "^21.0.0"
pytest = "^7.4.3"

[[tool.poetry.source]]
name = "aliyun"
url = "https://mirrors.aliyun.com/pypi/simple/"
#name = "tsinghua"
#url = "https://pypi.tuna.tsinghua.edu.cn/simple"
priority = "default"

[tool.poetry.scripts]
pyrun="poetrytest.app:main"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

``src/poetrytest/app.py``
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

``tests/test_app.py``
```
import pytest

from app import main


class Test_App:
    def test_main(self):
        print("测试已经执行")
        main()
```

``src/poetrytest/sub_module/__init__.py``(空文件)


``src/poetrytest/sub_module/sub_mod1.py``
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

``src/poetrytest/sub_module/sub_mod2.py``
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
cd D:\WorkSpace\Python\PoetryTest
poetry install
```

运行主程序（脚本在``pyproject.toml``中定义）
```
poetry run pyrun
```

运行测试
```
poetry run pytest

#这个可以看控制台输出
poetry run pytest -s --log-level=INFO --log-cli-level=INFO
```

### 示例源码
 - [PoetryTest](./PoetryTest)
