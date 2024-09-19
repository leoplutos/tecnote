#!/usr/bin/python3
# -*- coding: utf-8 -*-

from typing import List
from typing import Any
from backendsanic.db.db import Pydblite


# 清单服务
class TodoService:

    # 依赖注入Pydblite
    def __init__(self, db_conn: Pydblite) -> None:
        self.db_conn = db_conn

    # 取得所有Todo
    async def get_all_todo(self) -> List[Any]:
        todo_list = self.db_conn.query_todo()
        # 查询数据
        # todo_list: list[Any] = db.query('SELECT * from todo')
        # 制作返回内容 元组 -> 词典
        result_list: List[Any] = []
        for element in todo_list:
            dict = {
                'todoId': element['todoid'],  # type: ignore
                'todoName': element['todoname'],  # type: ignore
                'image': element['image'],  # type: ignore
                'studied': element['studied'],  # type: ignore
            }
            result_list.append(dict)
        # db.close()
        return result_list
