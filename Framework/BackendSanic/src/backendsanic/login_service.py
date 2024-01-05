#!/usr/bin/python3
# -*- coding: utf-8 -*-
from db import SqliteDb
from typing import Any


def login(user_id: str, password: str) -> tuple:
    # 数据库连接
    db = SqliteDb()
    # 验证用户信息
    param = (user_id, password)
    user_info: tuple = db.queryone(
        'SELECT * FROM login WHERE userid = ? AND password = ?', param
    )
    # print(user_info)
    db.close()
    return user_info
