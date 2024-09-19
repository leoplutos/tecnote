import logging
from config.config import Config


def init_log():

    # 读取设定文件
    config = Config()

    # logging节点
    log_min_level = config.get_str_value("logging", "min_level")
    log_output = config.get_str_value("logging", "output")
    log_filename = config.get_str_value("logging", "filename")

    # 日志级别
    switcher = {
        "debug": logging.DEBUG,
        "info": logging.INFO,
        "warn": logging.WARN,
        "error": logging.ERROR,
        "fatal": logging.FATAL,
        "critical": logging.CRITICAL,
        "notset": logging.NOTSET,
    }
    min_level = switcher.get(log_min_level, logging.INFO)

    # 输出类型
    if log_output == "file":
        # 文件
        logging.basicConfig(
            handlers=[
                logging.FileHandler(filename=log_filename, encoding='utf-8', mode='a+')
            ],
            level=min_level,
            format='[%(asctime)s] %(levelname)s [%(thread)s][%(filename)s:%(lineno)d] - %(message)s',
        )
    else:
        # 控制台
        logging.basicConfig(
            level=min_level,
            format="[%(asctime)s] %(levelname)s [%(thread)s][%(filename)s:%(lineno)d] - %(message)s",
        )
