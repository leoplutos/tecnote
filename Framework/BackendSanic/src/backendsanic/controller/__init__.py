from sanic import Blueprint
from backendsanic.controller.login_controller import login_bp
from backendsanic.controller.todo_controller import todo_bp

# 蓝图（路由）组
all_bp = Blueprint.group(login_bp, todo_bp, url_prefix="/")
