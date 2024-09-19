#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logging
from log.log import init_log
import asyncio
import etcd3
from etcd3.client import Etcd3Client
from etcd3.events import DeleteEvent
import uuid
import time


PREFIX: str = "/PythonKey"


# 环境变量需要设置 PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
# 作为一个不太推荐的临时解决方案，使用纯 Python 的解析器
# 这种方法会显著减慢 Protobuf 消息的处理速度，因为它不使用 C++ 编写的快速解析器
async def main() -> None:

    # 日志初始化
    init_log()

    # 连接参数
    timeoutSec: float = 0.5
    try:
        # 建立连接
        etcd: Etcd3Client = etcd3.client(
            host='localhost', port=2379, timeout=timeoutSec, grpc_options=None
        )
        status_response = etcd.status()
        logging.info(f"Etcd连接成功 Version:{status_response.version}")
    except Exception as e:
        logging.error(f"Etcd连接失败: {e}", exc_info=True)
        return

    # 设定Key
    key1: str = PREFIX + "/Key1"
    key2: str = PREFIX + "/Key2"
    set_value_1: str = "使用Python客户端添加_" + str(uuid.uuid4())
    set_value_2: str = "使用Python客户端添加_" + str(uuid.uuid4())
    etcd.put(key1, set_value_1)
    logging.info(f"添加Key成功    key={key1}    value={set_value_1}")
    etcd.put(key2, set_value_2)
    logging.info(f"添加Key成功    key={key2}    value={set_value_2}")

    # 取得Key
    get_value_obj = etcd.get(key1)
    get_value = get_value_obj[0].decode('utf-8')  # type: ignore
    logging.info(f"取得Key成功    key={key1}    value={get_value}")

    # 取得Key（前缀机制）
    # 前缀查询
    prefix_obj = etcd.get_prefix(PREFIX)
    logging.info(f"取得前缀成功    prefix={PREFIX}")
    for element in prefix_obj:
        logging.info(
            f"取得Key成功    key={element[1].key.decode('utf-8')}    value={element[0].decode('utf-8')}"
        )

    # 分布式锁
    lock_set_key: str = PREFIX + "/lock"
    lock = etcd.lock(lock_set_key)
    # 加锁
    is_success: bool = lock.acquire()
    logging.info(f"[加锁]分布式锁    is_success={is_success}")
    logging.info(
        f"5秒后解锁, etcd3是用lease实现的锁,所以 [etcdctl lock /PythonKey/lock] 命令无效"
    )
    time.sleep(1)
    lock.release()
    logging.info(f"[解锁]分布式锁成功    lockKey={lock_set_key}")

    # 调用租约函数
    await lease_register_async(etcd)
    # 调用监听函数
    await watch_service_async(etcd)

    # 在此堵塞线程
    time.sleep(5000)

    # 关闭连接
    etcd.close()
    logging.error(f"已断开Etcd连接")


# 租约函数
async def lease_register_async(etcd: Etcd3Client) -> None:
    # 创建租约
    lease_key: str = PREFIX + "/LsKey1"
    lease_value: str = "此Key会自动被删除"
    ttl: int = 5
    lease = etcd.lease(ttl)
    logging.info(f"创建租约(Lease)成功    leaseId={lease.id}")
    # 将租约附加到一个Key上
    etcd.put(lease_key, lease_value, lease=lease)
    logging.info(
        f"添加租约Key成功    key={lease_key}    value={lease_value}    leaseId={lease.id}"
    )
    # 续租，在租约过期之前续租
    # lease.refresh()
    # 主动撤销租约
    # lease.revoke()


# 监听函数
async def watch_service_async(etcd: Etcd3Client) -> None:
    watch_key: str = PREFIX + "/LsKey1"
    events_iterator, cancel = etcd.watch(watch_key)
    # events_iterator, cancel = etcd.watch_prefix("/doot/watch/prefix/")
    for event in events_iterator:
        if isinstance(event, DeleteEvent):
            event_key: str = event.key.decode('utf-8')
            logging.info(f"租约  key={event_key} 到期，续租")
            await lease_register_async(etcd)


if __name__ == "__main__":
    # asyncio是Python 3.4版本引入的标准库，直接内置了对异步IO的支持
    asyncio.run(main())
