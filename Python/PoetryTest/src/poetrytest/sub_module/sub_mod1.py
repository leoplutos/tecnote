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