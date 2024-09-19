#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logging
import asyncio
from faker import Faker


# 异步函数
async def sub_fun1_async() -> int:
    fake = Faker('zh-CN')
    logging.info("使用fake生成一组虚假消息")
    # logging.info(fake.profile())
    job = fake.profile()['job']
    logging.info(f"fake job: {job}")
    # 异步睡眠2秒
    await asyncio.sleep(2)
    return 0
