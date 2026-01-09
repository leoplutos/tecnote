# app/main.py
import sys
import os

# -----------------------------------------------------------
# 路径设置开始
# -----------------------------------------------------------
# 1. 获取当前文件 (__main__.py) 所在的目录 -> .../ims_migration_batch/app
current_dir = os.path.dirname(os.path.abspath(__file__))
# 2. 获取项目的根目录 (app 的父目录) -> .../ims_migration_batch
project_root = os.path.dirname(current_dir)
# 3. 生成 libs 目录的绝对路径 -> .../ims_migration_batch/libs
libs_path = os.path.join(project_root, 'libs')
# 4. 将 libs 的路径插入到系统搜索路径的开头
# 使用 insert(0, ...) 而不是 append，以确保优先加载附带的包
sys.path.insert(0, libs_path)

# -----------------------------------------------------------
# 路径设置结束 (在此之后导入第三方库)
# -----------------------------------------------------------
import pandas as pd

def run():
    # 创建一个简单的 DataFrame
    df = pd.DataFrame({
        "name": ["Alice", "Bob", "吉利大亨"],
        "age": [25, 30, 35]
    })

    print("Pandas DataFrame 内容：")
    print(df)
