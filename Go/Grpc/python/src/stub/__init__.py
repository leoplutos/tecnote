import sys
import os

# 解决 ModuleNotFoundError: No module named 'ProductInfo_pb2 错误
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
