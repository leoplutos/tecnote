#!/usr/bin/python3
# -*- coding: utf-8 -*-

from typing import Any
from backendsanic.db.db import Pydblite


# 登录服务
class LoginService:

    # 依赖注入Pydblite
    def __init__(self, db_conn: Pydblite) -> None:
        self.db_conn = db_conn

    # 验证登录
    async def login(self, user_id: str, password: str) -> Any:
        # 查询数据
        user_info_list = self.db_conn.query_login(user_id, password)
        # 验证用户信息
        # param = (user_id, password)
        # user_info: tuple = db.queryone(
        #    'SELECT * FROM login WHERE userid = ? AND password = ?', param
        # )
        # print(user_info)
        # db.close()
        return user_info_list
