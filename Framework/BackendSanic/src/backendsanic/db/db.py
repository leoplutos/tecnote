#!/usr/bin/python3
# -*- coding: utf-8 -*-

from sanic.log import logger
from pydblite.pydblite import Base


# 单例内存数据库
class Pydblite:

    # 单例
    __instance = None
    # 初始化标记
    __initialized = False

    # __new__是一个静态方法，用于创建类的新实例
    def __new__(cls, *args, **kwargs):
        if not cls.__instance:
            cls.__instance = super(Pydblite, cls).__new__(cls, *args, **kwargs)
            # 标记实例尚未初始化
            cls.__instance.__initialized = False
        return cls.__instance

    def __init__(self):
        if not self.__initialized:
            # 标记实例已初始化
            self.__initialized = True

            logger.info("内存数据库初始化开始")

            try:
                # 创建表login
                login = Base('login', save_to_file=False)
                # 字段
                login.create('userid', 'password')
                # 插入数据
                login.insert(userid='admin', password='123')
                self.__login = login

                # 创建表todo
                todo = Base('todo', save_to_file=False)
                # 字段
                todo.create('todoid', 'todoname', 'image', 'studied')
                # 插入数据
                todo.insert(
                    todoid=1, todoname='Vue', image='./img/vue.png', studied=False
                )
                todo.insert(
                    todoid=2,
                    todoname='数据库',
                    image='./img/database.png',
                    studied=False,
                )
                todo.insert(
                    todoid=3, todoname='Python', image='./img/python.png', studied=False
                )
                todo.insert(
                    todoid=4, todoname='Golang', image='./img/go.png', studied=False
                )
                self.__todo = todo
            except Exception as e:
                logger.error(e)
            finally:
                logger.info("内存数据库初始化结束")

    def query_login(self, user_id, password):
        return self.__login(userid=user_id, password=password)

    def query_todo(self):
        return self.__todo()

    @classmethod
    def query_login_info(cls, user_id, password):
        return cls().query_login(user_id, password)

    @classmethod
    def query_todo_info(cls):
        return cls().query_todo()
