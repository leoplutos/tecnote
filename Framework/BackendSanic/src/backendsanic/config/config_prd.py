#!/usr/bin/python3
# -*- coding: utf-8 -*-


# 设定文件(生产环境)
class ConfigPrd(object):

    ###### 自定义设定 ######
    # development/production
    ENVIRONMENT = "production"

    ###### Sanic设定 ######
    # 是否开启 CORS 防护
    CORS = False
    # 是否启用 OpenAPI 规范生成
    OAS = False
    # JWT的密钥
    SECRET = "KEEP_IT_SECRET_KEEP_IT_SAFE"
