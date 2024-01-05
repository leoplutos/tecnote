#!/usr/bin/python3
# -*- coding: utf-8 -*-
from db import SqliteDb
from typing import Any


def get_all_todo() -> "list[Any]":
    # 数据库连接
    db = SqliteDb()
    # 查询数据
    todo_list: list[Any] = db.query('SELECT * from todo')
    # 制作返回内容 元组 -> 词典
    result_list: list[Any] = []
    for element in todo_list:
        dict = {
            'todoId': element[0],
            'todoName': element[1],
            'image': element[2],
            'studied': element[3],
        }
        result_list.append(dict)
    db.close()
    return result_list
