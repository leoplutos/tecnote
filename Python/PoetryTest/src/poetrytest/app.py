#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logging
import asyncio
from config.config import Config
from log.log import init_log
from sub_module.sub_mod1 import sub_fun1_async
from sub_module import sub_mod2


# 程序主入口
async def main() -> None:

    # 日志初始化
    init_log()

    # 从config.ini读取内容
    config = Config()
    logging.info("读取config和环境变量开始")
    # database节点
    database_server = config.get_str_value("database", "server")
    logging.info(f"database_server: {database_server}")
    database_port = config.get_int_value("database", "port")
    logging.info(f"database_port: {database_port}")
    # test.column节点
    hacker = config.get_boolean_value("test.column", "hacker", default_value=False)
    logging.info(f"hacker: {hacker}")
    name = config.get_str_value("test.column", "name")
    logging.info(f"name: {name}")
    age = config.get_int_value("test.column", "age")
    logging.info(f"age: {age}")
    weight = config.get_float_value("test.column", "weight")
    logging.info(f"weight: {weight}")
    # 从环境变量读取内容
    python_home = config.get_str_value("ENV", "PYTHON_HOME")
    logging.info(f"PYTHON_HOME: {python_home}")
    logging.info("读取config和环境变量结束")

    # 异步调用
    ret1 = await sub_fun1_async()
    logging.info(f"调用sub1的返回值为: {ret1}")
    ret2, ret3 = sub_mod2.sub_fun2(age)
    logging.info(f"调用sub2的返回值为: {ret2}, {ret3}")


if __name__ == "__main__":
    # asyncio是Python 3.4版本引入的标准库，直接内置了对异步IO的支持
    asyncio.run(main())
