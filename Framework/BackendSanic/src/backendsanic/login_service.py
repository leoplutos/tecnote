#!/usr/bin/python3
# -*- coding: utf-8 -*-

# from db import SqliteDb
from db import Pydblite
from typing import Any


def login(user_id: str, password: str) -> Any:
    # 数据库连接
    user_info_list = Pydblite.query_login_info(user_id, password)
    # 验证用户信息
    # param = (user_id, password)
    # user_info: tuple = db.queryone(
    #    'SELECT * FROM login WHERE userid = ? AND password = ?', param
    # )
    # print(user_info)
    # db.close()
    return user_info_list
