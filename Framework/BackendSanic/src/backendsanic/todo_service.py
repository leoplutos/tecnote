#!/usr/bin/python3
# -*- coding: utf-8 -*-

# from db import SqliteDb
from db import Pydblite
from typing import Any


def get_all_todo() -> "list[Any]":
    # 数据库连接
    # db = SqliteDb()
    todo_list = Pydblite.query_todo_info()
    # 查询数据
    # todo_list: list[Any] = db.query('SELECT * from todo')
    # 制作返回内容 元组 -> 词典
    result_list: list[Any] = []
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
