#!/usr/bin/python3
# -*- coding: utf-8 -*-


from functools import wraps
from typing import Callable
import jwt
from sanic import Request
from sanic.response import json
from result import Result


# 检查请求头里面是否有token
def check_token(request: Request):
    # 取得请求头
    request_headers = request.headers
    request_token = ''
    # 判断请求头内是否存在token
    if request_headers is not None and 'token' in request_headers:
        request_token = request_headers.getone("token")
    # if not request.token:
    if request_token is None or request_token == '':
        return False
    # 判断token是否合法
    try:
        # jwt.decode(request.token, request.app.config.SECRET, algorithms=["HS256"])
        jwt.decode(request_token, request.app.config.SECRET, algorithms=["HS256"])
    except jwt.exceptions.InvalidTokenError:
        return False
    else:
        return True


# protected标注定义，定义了此标注的函数会检验权限
def protected(wrapped: Callable):
    def decorator(f):
        @wraps(f)
        async def decorated_function(request, *args, **kwargs):
            is_authenticated = check_token(request)
            if is_authenticated:
                response = await f(request, *args, **kwargs)
                return response
            else:
                result = Result.fail(code=401, message="未携带token,请登录")
                return json(result.to_dict(), ensure_ascii=False)
                # return text("未携带token,请登录", 401)

        return decorated_function

    return decorator(wrapped)
