#!/usr/bin/python3
# -*- coding: utf-8 -*-

from sanic.log import logger
from abc import ABC, abstractmethod

# from pydblite.pydblite import Base


# 单例内存数据库
# pydblite 已经不维护了，换一个实现方式
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
                db = Database()
                # 创建表login
                db.create_table("login")
                login: Table = db.get_table("login")
                login.add_column(StringColumn("userid", required=True))
                login.add_column(StringColumn("password", required=True))
                login.insert_record({"userid": "admin", "password": "123"})
                # login = Base('login', save_to_file=False)
                # login.create('userid', 'password')
                # login.insert(userid='admin', password='123')
                self.__login = login

                # 创建表todo
                db.create_table("todo")
                todo: Table = db.get_table("todo")
                todo.add_column(IntColumn("todoid", required=True))
                todo.add_column(StringColumn("todoname", required=True))
                todo.add_column(StringColumn("image", required=True))
                todo.add_column(BoolColumn("studied", required=True))
                todo.insert_record(
                    {
                        "todoid": 1,
                        "todoname": "Vue",
                        "image": "./img/vue.png",
                        "studied": False,
                    }
                )
                todo.insert_record(
                    {
                        "todoid": 2,
                        "todoname": "数据库",
                        "image": "./img/database.png",
                        "studied": False,
                    }
                )
                todo.insert_record(
                    {
                        "todoid": 3,
                        "todoname": "Python",
                        "image": "./img/python.png",
                        "studied": False,
                    }
                )
                todo.insert_record(
                    {
                        "todoid": 4,
                        "todoname": "Golang",
                        "image": "./img/go.png",
                        "studied": False,
                    }
                )
                # todo = Base('todo', save_to_file=False)
                # todo.create('todoid', 'todoname', 'image', 'studied')
                # todo.insert(
                #    todoid=1, todoname='Vue', image='./img/vue.png', studied=False
                # )
                # todo.insert(
                #    todoid=2,
                #    todoname='数据库',
                #    image='./img/database.png',
                #    studied=False,
                # )
                # todo.insert(
                #    todoid=3, todoname='Python', image='./img/python.png', studied=False
                # )
                # todo.insert(
                #    todoid=4, todoname='Golang', image='./img/go.png', studied=False
                # )
                self.__todo = todo
            except Exception as e:
                logger.error(e)
            finally:
                logger.info("内存数据库初始化结束")

    def query_login(self, user_id):
        # return self.__login(userid=user_id, password=password)
        filtered_records = self.__login.filter_records("userid", user_id)
        return filtered_records

    def query_todo(self):
        # return self.__todo()
        return self.__todo.filter_all()


# 实现内存数据库


class ColumnType:
    STRING = "string"
    INT = "int"
    BOOL = "bool"


class Column(ABC):
    def __init__(self, name, column_type, required=False):
        self.name = name
        self.column_type = column_type
        self.required = required

    @abstractmethod
    def validate(self, value) -> bool:
        pass


class StringColumn(Column):
    MAX_LENGTH = 20

    def __init__(self, name, required=False):
        super().__init__(name, ColumnType.STRING, required)

    def validate(self, value) -> bool:
        if not isinstance(value, str):
            return False
        if len(value) > self.MAX_LENGTH:
            print("Max length exceeeded !!")
            return False
        return True


class IntColumn(Column):
    MAX_LENGTH = 1024
    MIN_LENGTH = -1024

    def __init__(self, name, required=False):
        super().__init__(name, ColumnType.INT, required)

    def validate(self, value) -> bool:
        if not isinstance(value, int):
            return False
        if len(str(value)) < self.MIN_LENGTH or len(str(value)) > self.MAX_LENGTH:
            print("Min or Max length exceeeded !!")
            return False
        return True


class BoolColumn(Column):

    def __init__(self, name, required=False):
        super().__init__(name, ColumnType.BOOL, required)

    def validate(self, value) -> bool:
        if not isinstance(value, bool):
            return False
        return True


class Record:
    def __init__(self, values):
        self.values = values


class Table:
    def __init__(self, name):
        self.name = name
        self.columns = {}
        self.records = []

    def add_column(self, column):
        self.columns[column.name] = column

    def insert_record(self, values):
        record = Record(values)
        for column_name, column_obj in self.columns.items():
            if column_obj.required and column_name not in values:
                raise Exception(f"Missing required column '{column_name}' in record.")
        self.records.append(record)

    def print_records(self):
        for record in self.records:
            print(record.values)

    def filter_records(self, column_name, value):
        filtered_records = []
        for record in self.records:
            if column_name in record.values and record.values[column_name] == value:
                filtered_records.append(record.values)
        return filtered_records

    def filter_all(self):
        filtered_records = []
        for record in self.records:
            filtered_records.append(record.values)
        return filtered_records


class Database:
    def __init__(self):
        self.tables = {}

    def create_table(self, table_name):
        if table_name in self.tables:
            raise Exception(f"table {table_name} already exists !!")
        self.tables[table_name] = Table(table_name)

    def delete_table(self, table_name):
        if table_name not in self.tables:
            raise Exception(f"table {table_name} does not exist !!")
        del self.tables[table_name]

    def get_table(self, table_name):
        if table_name not in self.tables:
            raise Exception(f"table {table_name} does not  exists !!")
        return self.tables[table_name]


if __name__ == "__main__":
    pydblite = Pydblite()
    print(pydblite.query_login(user_id='admin1'))
    print(pydblite.query_todo())
