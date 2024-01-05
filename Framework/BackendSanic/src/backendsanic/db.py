#!/usr/bin/python3
# -*- coding: utf-8 -*-

import sqlite3
from typing import Any


class SqliteDb:
    def __init__(self, databaseuri: str = "file:mem1?mode=memory&cache=shared"):
        self.__databaseuri = databaseuri
        self.__db = sqlite3.connect(self.__databaseuri)

    def close(self):
        self.__db.cursor().close()
        self.__db.close()

    def execute(self, sql: str, param: Any = None) -> int:
        cursor = self.__db.cursor()
        try:
            if param is None:
                cursor.execute(sql)
            else:
                if type(param) is list:
                    cursor.executemany(sql, param)
                else:
                    cursor.execute(sql, param)
            count = self.__db.total_changes
            return count
        except Exception as e:
            print(e)
            return -1
        finally:
            pass

    def query(self, sql: str, param: Any = None) -> "list[Any]":
        cursor = self.__db.cursor()
        if param is None:
            cursor.execute(sql)
        else:
            cursor.execute(sql, param)
        return cursor.fetchall()

    def queryone(self, sql: str, param: Any = None) -> Any:
        cursor = self.__db.cursor()
        if param is None:
            cursor.execute(sql)
        else:
            cursor.execute(sql, param)
        return cursor.fetchone()

    def commit(self):
        self.__db.commit()

    def rollback(self):
        self.__db.rollback()
