#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
from sanic import Sanic
from sanic.log import logger, LOGGING_CONFIG_DEFAULTS
from backendsanic.config.config_dev import ConfigDev
from backendsanic.config.config_prd import ConfigPrd
from backendsanic.db.db import Pydblite
from backendsanic.service.login_service import LoginService
from backendsanic.service.todo_service import TodoService
from backendsanic.controller import all_bp

########################
###### Sanic 入口 ######
########################

# 日志格式设定
LOGGING_CONFIG_DEFAULTS['formatters']['generic'][
    'class'
] = 'sanic.logging.formatter.ProdFormatter'
LOGGING_CONFIG_DEFAULTS['formatters']['access'][
    'class'
] = 'sanic.logging.formatter.ProdAccessFormatter'

# 创建Sanic实例
app: Sanic = Sanic("BackendSanic", log_config=LOGGING_CONFIG_DEFAULTS)

# 读取环境变量 SANIC_ENVIRONMENT，默认 development
sanic_env: str = os.environ.get('SANIC_ENVIRONMENT', 'development').lower()
# 加载配置文件
if sanic_env == "development":
    app.config.update_config(ConfigDev)
    logger.info("开发环境配置文件加载完成")
else:
    app.config.update_config(ConfigPrd)
    logger.info("生产环境配置文件加载完成")

# 添加所有蓝图（路由）
app.blueprint(all_bp)


# 服务开启前运行
@app.before_server_start
async def on_start(app, _):
    # 创建数据库对象
    db_conn = Pydblite()
    # 依赖注入数据库连接
    app.ext.dependency(db_conn)
    # 依赖注入LoginService
    login_service = LoginService(db_conn)
    app.ext.dependency(login_service)
    # 依赖注入TodoService
    todo_service = TodoService(db_conn)
    app.ext.dependency(todo_service)

    logger.info("后端服务Sanic已开启")


# 工厂方法
# 使用sanic命令启动时会调用此方法
# async def create_app() -> Sanic:
#    return app


if __name__ == "__main__":
    # 不推荐使用main函数启动
    host: str = "0.0.0.0"
    port: int = 9501
    # app_name: str = "BackendSanic"
    # loader: AppLoader = AppLoader(factory=partial(create_app))
    # app: Sanic = loader.load()
    app.prepare(host=host, port=port, single_process=True, debug=True)
    # Sanic.serve(primary=app, app_loader=loader)
    Sanic.serve()
