#!/usr/bin/python3
# -*- coding: utf-8 -*-

from pydblite.pydblite import Base


class Pydblite:

    def __init__(self):
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
            todo.insert(todoid=1, todoname='Vue', image='./img/vue.png', studied=False)
            todo.insert(
                todoid=2, todoname='数据库', image='./img/database.png', studied=False
            )
            todo.insert(
                todoid=3, todoname='Python', image='./img/python.png', studied=False
            )
            todo.insert(
                todoid=4, todoname='Golang', image='./img/go.png', studied=False
            )
            self.__todo = todo
        except Exception as e:
            print(e)
        finally:
            pass

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
