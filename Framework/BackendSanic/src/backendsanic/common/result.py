#!/usr/bin/python3
# -*- coding: utf-8 -*-

from typing import Any


# 统一封装类
class Result:
    # 允许绑定的对象，只有3个属性 __code 、 __message 、 __data
    __slots__ = ('__code', '__message', '__data')

    # 构造函数
    def __init__(self, code: int, message: str, data: Any) -> None:
        '''用双下划线开头的变量，表示私有变量，外部程序不可直接访问'''
        self.__code = code
        self.__message = message
        self.__data = data

    # 类函数(@classmethod):即类方法, 更关注于从类中调用方法, 而不是在实例中调用方法, 如构造重载
    @classmethod
    def success(cls, message: str = "success", data: Any = None):
        return cls(200, message, data)

    @classmethod
    def fail(cls, code: int = 500, message: str = "fail", data: Any = None):
        return cls(code, message, data)

    # getter
    @property
    def code(self) -> int:
        return self.__code

    # settter
    @code.setter
    def code(self, code: int) -> None:
        self.__code = code

    # getter
    @property
    def message(self) -> str:
        return self.__message

    @message.setter
    def message(self, message: str) -> None:
        self.__message = message

    # getter
    @property
    def data(self) -> Any:
        return self.__data

    @data.setter
    def data(self, data: Any) -> None:
        self.__data = data

    # 相当于java的toString方法
    def __str__(self):
        return "code:%s   message:%s   data:%s" % (
            self.__code,
            self.__message,
            self.__data,
        )

    # 相当于java的toString方法
    def __repr__(self):
        # return "code:%s   message:%s   data:%s" % (self.__code, self.__message, self.__data)
        return self.__str__()

    # 相当于java的equals方法
    def __eq__(self, other):
        if self.__code == other.code:
            return True
        else:
            return False

    def to_dict(self) -> dict:
        rs_dict = {'code': self.__code, 'message': self.__message, 'data': self.__data}
        return rs_dict
