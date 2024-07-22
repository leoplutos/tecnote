#!/usr/bin/python3
# -*- coding: utf-8 -*-

from sanic import Sanic
from login_blueprint import login_bp
from todo_blueprint import todo_bp

# from sanic_ext import Extend
from sanic_cors import CORS, cross_origin
from db import Pydblite

# 创建Sanic实例
app = Sanic("BackendSanic")
# 跨域设置
# 是否启用CORS保护
# app.config.CORS = False
# app.config.CORS_ORIGINS = "*"
# app.config.CORS_ORIGINS = "http://localhost:9500,http://172.30.8.172:9500"
# app.extend(config={"cors": False, "cors_origins": "*"})
app.config.SECRET = "KEEP_IT_SECRET_KEEP_IT_SAFE"

# 添加login子路由
app.blueprint(login_bp)
# 添加todo子路由
app.blueprint(todo_bp)
# Extend(app)
# 使用sanic_cors进行跨域
CORS(app)

if __name__ == "__main__":
    # 初始化内存数据库内容
    db = Pydblite()
    # 启动Web服务
    # app.run(host="localhost", port=9501)
    app.run(host='0.0.0.0', port=9501)
    # app.run(port=9501)
