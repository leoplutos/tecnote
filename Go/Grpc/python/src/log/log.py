#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys
from loguru import logger
import json


# 初始化日志
async def init_logger_async() -> None:

    # 获取 PYTHON_ENVIRONMENT 环境变量的值
    env = os.getenv("PYTHON_ENVIRONMENT", "development")
    if env == "docker":
        # Docker环境，采用json结构打印
        await json_console()
    else:
        # 其他，采用漂亮打印
        await pretty_console()


# 采用漂亮打印
async def pretty_console() -> None:
    # 移除默认的日志处理器
    logger.remove()
    # 添加一个自定义的日志处理器，漂亮打印
    logger.add(
        sys.stdout,
        colorize=True,
        format="<green>{time:YYYY-MM-DD HH:mm:ss.SSS}</green> | {level} | {thread} | <cyan>{name}</cyan>:<cyan>{function}</cyan>:<cyan>{line}</cyan> - {message}",
        level="INFO",
        enqueue=True,
        backtrace=True,
        diagnose=True,
    )


# 采用Json日志
async def json_console() -> None:
    # 移除默认的日志处理器
    logger.remove()
    # 添加一个自定义的日志处理器，输出 JSON 格式的日志
    logger.add(
        sink=sink_serializer,
        level="INFO",
        serialize=True,
        enqueue=True,
        backtrace=True,
        diagnose=True,
    )


# 添加一个自定义的日志处理器，输出带有更多字段的 JSON 格式日志
def sink_serializer(message):
    # 将日志消息转换为字典
    message_dict = message.record
    # 序列化为 JSON 字符串
    simplified = {
        "time": message_dict["time"].timestamp(),
        "level": message_dict["level"].name,
        "message": message_dict["message"],
        "exception": message_dict["exception"],
        "file": message_dict["file"].name,
        "function": message_dict["function"],
        "line": message_dict["line"],
        "thread": message_dict["thread"].id,
        # 添加自定义字段
        "service_name": "PythonGrpcService",
    }
    json_message = json.dumps(simplified, default=str, ensure_ascii=False)
    print(json_message, file=sys.stdout, flush=True)
