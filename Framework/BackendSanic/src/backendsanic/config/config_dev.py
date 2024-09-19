#!/usr/bin/python3
# -*- coding: utf-8 -*-


# 设定文件(开发环境)
class ConfigDev(object):

    ###### 自定义设定 ######
    # development/production
    ENVIRONMENT = "development"

    ###### Sanic设定 ######
    # 是否开启 CORS 防护
    CORS = False
    # 是否启用 OpenAPI 规范生成
    OAS = True
    # JWT的密钥
    SECRET = "KEEP_IT_SECRET_KEEP_IT_SAFE"
