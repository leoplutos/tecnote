#!/usr/bin/python3
# -*- coding: utf-8 -*-

from typing import List
from typing import Any
from sanic import Request, Blueprint
from sanic.response import json, JSONResponse
from sanic.log import logger
from backendsanic.jwt.auth import protected
from backendsanic.common.result import Result
from backendsanic.service.todo_service import TodoService

# 映射url:/todo
todo_bp = Blueprint("todo", url_prefix="/todo")


# 映射url:/todo/getAll
@todo_bp.route("/getAll", methods=["POST", "GET"])
@protected
async def todogetAll(request: Request, todo_service: TodoService) -> JSONResponse:
    # 阻塞调用TodoService
    todolist: List[Any] = await todo_service.get_all_todo()
    # 创建返回
    result = Result.success(message="success", data=todolist)
    logger.info("请求TodoList成功")
    # body：响应要返回的JSON数据，通常是一个字典
    # kwargs：dumps函数的参数，传入ensure_ascii=False以支持中文
    return json(result.to_dict(), ensure_ascii=False)
