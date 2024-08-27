#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logging
import redis
import uuid
from typing import Any, Awaitable
from redis.typing import ResponseT


# pyright会报ResponseT的类型错误，使用此函数包装
def extract(value: ResponseT) -> Any:
    if isinstance(value, Awaitable):
        raise TypeError
    return value


# pyright会报ResponseT的类型错误，使用此函数包装
async def extract_async(value: ResponseT) -> Any:
    if not isinstance(value, Awaitable):
        raise TypeError
    return await value


def main():
    logging.basicConfig(
        level=logging.DEBUG,
        format="[%(asctime)s] %(levelname)s [%(thread)s][%(filename)s:%(lineno)d] - %(message)s",
    )

    # 建立连接
    # socket_connect_timeout有issues，不生效
    try:
        connect_timeout: float = 2.0
        redis_cache = redis.Redis(
            host='localhost',
            port=6379,
            # username='dvora',
            # password='redis',
            decode_responses=True,
            socket_timeout=connect_timeout,
            socket_connect_timeout=connect_timeout,
            retry_on_timeout=False,
            socket_keepalive=True,
        )
        redis_cache.ping()
    except Exception as e:
        logging.error(f"Redis连接失败: {e}", exc_info=True)
        return

    # 设定Key
    key: str = "PythonKey"
    uuid_str: str = str(uuid.uuid4())
    set_value: str = "使用Python客户端添加_" + uuid_str
    redis_cache.set(key, set_value)
    logging.info(f"添加Key成功    key={key}    value={set_value}")

    # 取得Key
    get_value: str = extract(redis_cache.get(key))
    logging.info(f"取得Key成功    key={key}    value={get_value}")

    # 判断Key是否存在
    is_exists: int = extract(redis_cache.exists(key))
    logging.info(f"Key[{key}]是否存在    {is_exists}")
    not_existkey: str = "abcde"
    is_exists: int = extract(redis_cache.exists(not_existkey))
    logging.info(f"Key[{not_existkey}]是否存在    {is_exists}")

    # 为Key设置过期时间(秒)
    expire_seconds: int = 10
    redis_cache.expire(key, expire_seconds)
    logging.info(f"设定Key[{key}]的过期时间为：{expire_seconds}秒")

    # 关闭连接
    redis_cache.close()


if __name__ == "__main__":
    main()
