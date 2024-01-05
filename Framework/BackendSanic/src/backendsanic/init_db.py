#!/usr/bin/python3
# -*- coding: utf-8 -*-
from db import SqliteDb


# 初始化内存数据库内容
def init_db() -> None:
    # 数据库连接
    db = SqliteDb()

    # 创建表login
    db.execute('DROP TABLE IF EXISTS login;')
    create_tabl_sql = '''
            CREATE TABLE IF NOT EXISTS login(
                userid TEXT PRIMARY KEY NOT NULL,
                password TEXT NOT NULL
            );'''
    db.execute(create_tabl_sql)
    # 插入数据
    db.execute('INSERT INTO login(userid, password) VALUES(?, ?);', ('admin', '123'))

    # 查询数据
    # print(db.queryone('SELECT * from login'))
    db.commit()

    # 创建表todo
    db.execute('DROP TABLE IF EXISTS todo;')
    create_tabl_sql = '''
            CREATE TABLE IF NOT EXISTS todo(
                todoid INT PRIMARY KEY NOT NULL,
                todoname TEXT,
                image TEXT,
                studied BOOLEAN
            );'''
    db.execute(create_tabl_sql)
    # 插入数据
    db.execute(
        'INSERT INTO todo(todoid, todoname, image, studied) VALUES(?, ?, ?, ?);',
        (1, 'Vue', './img/vue.png', False),
    )
    db.execute(
        'INSERT INTO todo(todoid, todoname, image, studied) VALUES(?, ?, ?, ?);',
        (2, '数据库', './img/database.png', False),
    )
    db.execute(
        'INSERT INTO todo(todoid, todoname, image, studied) VALUES(?, ?, ?, ?);',
        (3, 'Python', './img/python.png', False),
    )
    db.execute(
        'INSERT INTO todo(todoid, todoname, image, studied) VALUES(?, ?, ?, ?);',
        (4, 'Golang', './img/go.png', False),
    )

    # 查询数据
    # print(db.query('SELECT * from todo'))
    # 提交改动
    db.commit()

    # 关闭连接
    db.close()
