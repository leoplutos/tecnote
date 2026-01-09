# PythonNormal

### 环境

- Python 3.8

### 本地安装依赖
```bash
# 安装新的依赖到libs目录
pip install faker --target ./libs

# 安装requirements.txt中的依赖到libs目录
pip install -r requirements.txt --target ./libs
```

### 部署方式
将 ``app`` , ``libs`` 和 ``start.bat`` 部署到服务器，运行 ``start.bat`` 即可

### 目录构成
```
PythonNormal/
│
├─ app/
│   ├─ __main__.py         # python -m app 入口
│   ├─ main.py             # 主处理
│   └─ ...                 # 其他
│
├─ libs/                   # 依赖包
│
├─ requirements.txt        # 依赖管理
│
└─ start.bat               # 启动脚本
```
