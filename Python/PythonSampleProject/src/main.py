#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os, sys
import traceback

# 因为嵌入版python无法载入PYTHONPATH环境变量，所以用代码动态载入
sys.path.extend(os.getenv("PYTHONPATH").split(os.pathsep))

# 想要在VSCode右上角“Run Python File”运行的话，需要在settings.json里面的"terminal.integrated.env.windows"中设定对PYTHONPATH
# 想要在VSCode右上角“Debug Python File”调试的话，需要在.env里面设定对PYTHONPATH
# import sub_mod1
# import sub_mod2
from sub_mod1 import sub_fun1
from sub_mod2 import sub_fun2


def main():
    str_msg = """
o0O 8g&@ == != ilI|
ABCDEFGHIHJLNMOPQRSTUVWXYZ
abcdefghihjlnmopqrstuvwxyz
1234567890 !@#$%^&*()__+
Hello!こんにちは!你好!안녕하세요!
这是一段中文
これは日本語テストです。
    """
    print(f"str_msg:{str_msg}")
    print("sub_fun1开始。")
    i_retCode = sub_fun1()
    print(f"sub_fun1结束。结果i_retCode：{i_retCode}")
    print("sub_fun2开始。")
    i_retCode = sub_fun2()
    print(f"sub_fun2结束。结果i_retCode：{i_retCode}")


if __name__ == "__main__":
    main()
