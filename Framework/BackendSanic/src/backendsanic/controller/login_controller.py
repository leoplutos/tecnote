#!/usr/bin/python3
# -*- coding: utf-8 -*-

from sanic import Request, Blueprint
from sanic.log import logger
from sanic.response import json, JSONResponse
import jwt
from backendsanic.common.result import Result
from backendsanic.service.login_service import LoginService
from backendsanic.common.result import Result

# 映射url:/login
login_bp = Blueprint("login", url_prefix="/login")


# 映射url:子路由的根,即 /login
@login_bp.route("/", methods=["POST", "GET"])
async def login(request: Request, login_service: LoginService) -> JSONResponse:

    # 取得参数
    requestData: dict = request.json
    userId: str = ''
    password: str = ''
    # 判断输入信息
    if requestData is not None and 'userId' in requestData:
        userId: str = requestData["userId"]
    else:
        result = Result.fail(code=400, message="账号不能为空")
        return json(result.to_dict(), ensure_ascii=False)
    if userId == '':
        result = Result.fail(code=400, message="账号不能为空")
        return json(result.to_dict(), ensure_ascii=False)
    if requestData is not None and 'password' in requestData:
        password: str = requestData["password"]
    else:
        result = Result.fail(code=400, message="密码不能为空")
        return json(result.to_dict(), ensure_ascii=False)
    if password == '':
        result = Result.fail(code=400, message="密码不能为空")
        return json(result.to_dict(), ensure_ascii=False)
    # 阻塞调用LoginService
    user_info_list: tuple = await login_service.login(userId, password)
    # if user_info_list is None:
    if len(user_info_list) == 0:
        result = Result.fail(code=401, message="用户名或密码错误！")
        return json(result.to_dict(), ensure_ascii=False)

    # 使用jwt创建token
    token = jwt.encode({}, request.app.config.SECRET)
    # 创建返回
    result = Result.success(message="登录成功", data=token)
    logger.info("请求Login成功")
    # body：响应要返回的JSON数据，通常是一个字典
    # kwargs：dumps函数的参数，传入ensure_ascii=False以支持中文
    return json(result.to_dict(), ensure_ascii=False)
