# UV相关（推荐使用UV）
``uv`` 是一个非常快速的 Python 依赖安装程序和分解器，使用 Rust 编写，旨在替代 pip 和pip-tools 工作流，速度比他们快 8～10 倍，当前可用于替代 pip, pip-tools, virtualenv，根据路线图，它会向着 “Cargo for Python” 方向前行 —— 一个极其快速、可靠且易于使用的综合项目和包管理器

## 官网
 - [官网](https://docs.astral.sh/uv/)
 - [Github](https://github.com/astral-sh/uv)

## 安装
```bash
pip install uv

uv --version
```

## 使用方法

创建工程
```bash
cd D:\WorkSpace\Python
uv init PythonGrpc
```
会生成如下结构的目录
```text
.
├── .python-version
├── README.md
├── hello.py
└── pyproject.toml
```
运行
```bash
# 在 .venv 文件夹创建虚拟环境
uv venv
# 运行 hello.py
uv run hello.py
```

## 常用命令
环境管理
```bash
# 显式创建项目环境并安装依赖包
uv sync
```

依赖管理
```bash
# 添加依赖
uv add faker
uv add 'requests==2.31.0'
# 删除依赖
uv remove faker
# 查看依赖数
uv tree
# 锁定依赖项
uv pip compile pyproject.toml -o requirements.txt
# 从 pyproject.toml 文件安装依赖
uv pip install -r pyproject.toml
# 从 requirements.txt 文件安装依赖
uv pip install -r requirements.txt
```
工具管理
```bash
# 命令行工具(如Ruff)安装到本地
# uv tool install ruff -i https://mirrors.aliyun.com/pypi/simple/
# 临时运行工具（不需要安装）
uvx ruff --version
```

# Poetry相关（不推荐使用）

## 简介
Poetry 是一个包管理和打包的工具。  
Poetry 使用 pyproject.toml 和 poetry.lock 文件来管理依赖，类似于 JavaScript/Node.js 的 Npm 和 Rust 的 Cargo

## 官网
 - [官网](https://python-poetry.org/)
 - [Github](https://github.com/python-poetry/poetry)

## 安装
```bash
pip install poetry

poetry --version
```

## 使用方法

### 修改虚拟环境创建配置
选项 ``virtualenvs.in-project`` 如果未明确设置，poetry 默认会在 ``{cache-dir}/virtualenvs`` 下创建一个虚拟环境  
如果设置为 ``true``，则将在项目根目录中名为 ``.venv`` 的文件夹中创建虚拟环境  
为了对编辑器友好，我们全局设定为``true``
```bash
poetry config virtualenvs.in-project true
poetry config --list
```

### 自动创建虚拟环境配置
选项 ``virtualenvs.create=true`` 用来自动创建虚拟环境
```bash
poetry config virtualenvs.create true --local
poetry config --list
```
当参数 ``virtualenvs.create=true`` 时，执行 ``poetry install/add/remove`` 时会检测当前项目是否有虚拟环境，没有就自动创建

### 创建工程
Poetry 会为你生成工程文件夹，所以直接在父目录运行即可
```bash
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
```bash
poetry new --src --name main.python my-package
```
或
```bash
poetry new --src my-package
```

### 配置说明
根路径下的 ``pyproject.toml`` 文件，该文件的主要用途是依赖管理、构建、打包、发布
 - ``tool.poetry.dependencies``：项目需要的所有依赖包
 - ``tool.poetry.dev-dependencies``：仅用于开发的依赖包
 - ``tool.poetry.source``：指定项目的安装源
 - ``tool.poetry.scripts``：设定运行脚本（类似Node.js）

#### 配置示例
``pyproject.toml``
```toml
[tool.poetry.dependencies]
python = "^3.8"
faker = "^21.0.0"

[[tool.poetry.source]]
name = "aliyun"
url = "https://mirrors.aliyun.com/pypi/simple/"
#name = "tsinghua"
#url = "https://pypi.tuna.tsinghua.edu.cn/simple"
#priority = "default"
priority = "primary"
```

#### 虚拟环境下运行python命令
执行app.py文件
```bash
poetry run python app.py
```
显式的激活虚拟环境
```bash
poetry shell
```
查看虚拟环境信息
```bash
poetry env info
poetry env list
```
删除虚拟环境
```bash
poetry env remove python
或者
poetry env remove python3
```

### 安装依赖
可以使用install命令直接解析并安装pyproject.toml的依赖包
```bash
poetry install
```
也可以可以使用add命令来安装Python工具包
```bash
poetry add Faker
```
查看依赖包
```bash
poetry show
```
删除依赖包
```bash
poetry remove Faker
```
更新权限（在某些情况下，删除依赖项也可能影响其他依赖项。为了确保您的项目保持稳定，最好更新您的依赖项）
```bash
poetry update
```

### 打包与发布
构建可安装的 ``*.whl`` 和 ``tar.gz`` 文件
```bash
poetry build
```

## 使用案例

### 新建工程
```bash
cd D:\WorkSpace\Python
poetry new --src PoetryTest
```

### 示例源码
 - [PoetryTest](./PoetryTest)

### 运行
安装依赖库
```bash
cd D:\WorkSpace\Python\PoetryTest
poetry install
```

运行主程序
```bash
poetry run python src\poetrytest\app.py
```

运行测试
```bash
poetry run pytest

#这个可以看控制台输出
poetry run pytest -s --log-level=INFO --log-cli-level=INFO
```

## 开发工具支持
 - VSCode：VSCode默认支持Poetry，不需要更多设置
 - Vim-pyright：参考示例源码的 [pyproject.toml](./PoetryTest/pyproject.toml) 设定内容为
```
[tool.pyright]
venvPath = "."
venv = ".venv"
```
设定参考 [这里](https://github.com/microsoft/pyright/blob/main/docs/import-resolution.md#configuring-your-python-environment) 和 [这里](https://github.com/Microsoft/pyright/issues/30)
