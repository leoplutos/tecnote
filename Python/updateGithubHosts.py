#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import urllib.request


# 这个脚本用来更新 github.com 的 hosts 文件
# 因为要更新 C:\Windows\System32\drivers\etc\hosts 文件，所以运行需要 admin 权限
# 流程
# 1. 访问 https://gitlab.com/ineo6/hosts/-/raw/master/hosts 取得最新 github.com 的 ip 地址
# 2. 写入系统 hosts 文件
# 3. 运行 ipconfig /flushdns 命令刷新 DNS 缓存


# 入口主函数
def main():
    # 取得默认 hosts 文件内容
    original_content: str = get_original_hosts_content()
    # 1. 访问 https://gitlab.com/ineo6/hosts/-/raw/master/hosts 取得最新 github.com 的 ip 地址
    github_content: str = get_new_hosts_content()
    # 2. 写入 hosts 文件
    write_to_system_hosts(
        original_content=original_content, github_content=github_content
    )
    # 3. 运行 ipconfig /flushdns 命令刷新 DNS 缓存
    flush_dns()


# 1. 访问 https://gitlab.com/ineo6/hosts/-/raw/master/hosts 取得最新 github.com 的 ip 地址
def get_new_hosts_content() -> str:
    # 返回值
    hosts_content: str = ''
    response = urllib.request.urlopen(
        'https://gitlab.com/ineo6/hosts/-/raw/master/hosts'
    )
    # print("查看 response 响应信息类型: ", type(response))
    page = response.read()
    hosts_content = page.decode('utf-8')
    # print(hosts_content)
    return hosts_content


# 取得默认 hosts 文件内容
def get_original_hosts_content() -> str:
    original_content: str = """# Copyright (c) 1993-2009 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# This file contains the mappings of IP addresses to host names. Each
# entry should be kept on an individual line. The IP address should
# be placed in the first column followed by the corresponding host name.
# The IP address and the host name should be separated by at least one
# space.
#
# Additionally, comments (such as these) may be inserted on individual
# lines or following the machine name denoted by a '#' symbol.
#
# For example:
#
#      102.54.94.97     rhino.acme.com          # source server
#       38.25.63.10     x.acme.com              # x client host

# localhost name resolution is handled within DNS itself.
#	127.0.0.1       localhost
#	::1             localhost

"""
    return original_content


# 2. 写入 hosts 文件
def write_to_system_hosts(original_content: str, github_content: str) -> None:
    #file_name: str = 'D:\Temp\hosts'
    file_name :str = 'C:\Windows\System32\drivers\etc\hosts'
    with open(file=file_name, mode='wt', encoding='utf-8', newline='\r\n') as f:
        # 写入原始内容
        f.write(original_content)
        # 写入取得的动态内容
        f.write(github_content)


# 3. 运行 ipconfig /flushdns 命令刷新 DNS 缓存
def flush_dns() -> None:
    os.system('ipconfig /flushdns')


if __name__ == "__main__":
    main()
