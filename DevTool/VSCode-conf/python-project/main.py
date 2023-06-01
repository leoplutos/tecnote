#!/usr/bin/env python
# coding: utf-8
import os, sys

# 当使用嵌入版的时候打开下面这句注释，因为嵌入版python无法载入PYTHONPATH环境变量，所以用代码动态载入
# sys.path.extend(os.getenv("PYTHONPATH").split(os.pathsep))

import sub1
import sub2

# from package1 import sub1
# from package2 import sub2

def main():
    # 调用sub1函数
    sub1.sub1()

    # 调用sub2函数
    sub2.sub2()

    print("This is main.  Hello World!!!  ")

if __name__ == "__main__":
    main()
