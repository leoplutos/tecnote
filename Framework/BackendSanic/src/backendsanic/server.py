#!/usr/bin/python3
# -*- coding: utf-8 -*-

from sanic import Sanic
from login_blueprint import login_bp
from todo_blueprint import todo_bp
import init_db as db

# 创建Sanic实例
app = Sanic("BackendSanic")
# 跨域设置
# app.config.CORS_ORIGINS = "*"
# Extend(app)
app.extend(config={"cors_origins": "http://localhost:9500"})
app.config.SECRET = "KEEP_IT_SECRET_KEEP_IT_SAFE"
# 添加login子路由
app.blueprint(login_bp)
# 添加todo子路由
app.blueprint(todo_bp)


if __name__ == "__main__":
    # 初始化内存数据库内容
    db.init_db()
    # 启动Web服务
    # app.run(host="localhost", port=9501)
    app.run(host='0.0.0.0', port=9501)
    # app.run(port=9501)
