#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import urllib.request
from socket import gethostbyname

# 这个脚本用来更新 github.com 的 hosts 文件
# 还更新了一些访问 stackoverflow.com 的CDN资源链接（比如：ajax.googleapis.com） 灵感来自（https://github.com/justjavac/ReplaceGoogleCDN）
# 因为要更新 C:\Windows\System32\drivers\etc\hosts 文件，所以运行需要 admin 权限
# 流程
# 1. 访问 https://gitlab.com/ineo6/hosts/-/raw/master/hosts 取得最新 github.com 的 ip 地址
# 2. 将 ajax.googleapis.com 等谷歌公共库换成中科大的资源
# 3. 替换 stackoverflow.com 的CDN资源链接
# 4. 写入系统 hosts 文件
# 5. 运行 ipconfig /flushdns 命令刷新 DNS 缓存


# 入口主函数
def main():
    # 取得默认 hosts 文件内容
    original_content: str = get_original_hosts_content()
    # 1. 访问 https://gitlab.com/ineo6/hosts/-/raw/master/hosts 取得最新 github.com 的 ip 地址
    github_content: str = get_new_hosts_content()
    # 3. 替换 stackoverflow.com 的CDN资源链接
    new_CDN_content: str = get_replace_CDN_content()
    # 4. 写入系统 hosts 文件
    write_to_system_hosts(
        original_content=original_content,
        github_content=github_content,
        cdn_content=new_CDN_content,
    )
    # 5. 运行 ipconfig /flushdns 命令刷新 DNS 缓存
    flush_dns()
    input("请按任意键继续")


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


# 取得替换的CDN资源链接
# ajax.googleapis.com - 前端公共库，替换为 ajax.loli.net
# fonts.googleapis.com - 免费字体库，替换为 fonts.googleapis.cn
# themes.googleusercontent.com - fonts 有时会使用到这个里面的资源，替换为 themes.loli.net
# fonts.gstatic.com - 免费字体库，替换为 fonts.gstatic.cn
# www.google.com/recaptcha - Google 图像验证库，替换为 www.recaptcha.net/recaptcha
# secure.gravatar.com - gravatar 头像，替换为 gravatar.loli.net
# maxcdn.bootstrapcdn.com/bootstrap - bootstrap 框架使用的 CDN，替换为 lib.baomitu.com/twitter-bootstrap
def get_replace_CDN_content() -> str:
    result: str = '\n'
    # ajax.googleapis.com - 前端公共库，替换为 ajax.loli.net
    try:
        ip_address = get_host_by_name('ajax.loli.net')
        result += ip_address + '          ajax.googleapis.com          #ajax.loli.net\n'
    except:
        print('ajax.loli.net get faild.')

    # fonts.googleapis.com - 免费字体库，替换为 fonts.googleapis.cn
    try:
        ip_address = get_host_by_name('fonts.googleapis.cn')
        result += ip_address + '          fonts.googleapis.com          #fonts.googleapis.cn\n'
    except:
        print('fonts.googleapis.cn get faild.')
    # themes.googleusercontent.com - 前端公共库，替换为 themes.loli.net
    try:
        ip_address = get_host_by_name('themes.loli.net')
        result += ip_address + '          themes.googleusercontent.com          #themes.loli.net\n'
    except:
        print('themes.loli.net get faild.')
    # fonts.gstatic.com - 前端公共库，替换为 fonts.gstatic.cn
    try:
        ip_address = get_host_by_name('fonts.gstatic.cn')
        result += ip_address + '          fonts.gstatic.com          #fonts.gstatic.cn\n'
    except:
        print('fonts.gstatic.cn get faild.')
    # www.google.com/recaptcha - 前端公共库，替换为 www.recaptcha.net/recaptcha
    try:
        ip_address = get_host_by_name('www.recaptcha.net/recaptcha')
        result += ip_address + '          www.google.com/recaptcha          #www.recaptcha.net/recaptcha\n'
    except:
        print('www.recaptcha.net/recaptcha get faild.')
    # secure.gravatar.com - 前端公共库，替换为 gravatar.loli.net
    try:
        ip_address = get_host_by_name('gravatar.loli.net')
        result += ip_address + '          secure.gravatar.com          #gravatar.loli.net\n'
    except:
        print('gravatar.loli.net get faild.')
    # maxcdn.bootstrapcdn.com/bootstrap - 前端公共库，替换为 lib.baomitu.com/twitter-bootstrap
    try:
        ip_address = get_host_by_name('lib.baomitu.com/twitter-bootstrap')
        result += ip_address + '          maxcdn.bootstrapcdn.com/bootstrap          #lib.baomitu.com/twitter-bootstrap\n'
    except:
        print('lib.baomitu.com/twitter-bootstrap get faild.')
    return result


# 4. 写入 hosts 文件
def write_to_system_hosts(
    original_content: str, github_content: str, cdn_content: str
) -> None:
    # file_name: str = 'D:/Temp/hosts'
    file_name: str = 'C:/Windows/System32/drivers/etc/hosts'
    with open(file=file_name, mode='wt', encoding='utf-8', newline='\r\n') as f:
        # 写入原始内容
        f.write(original_content)
        # 写入取得的动态内容
        f.write(github_content)
        # 写入CDN资源
        f.write(cdn_content)


# 5. 运行 ipconfig /flushdns 命令刷新 DNS 缓存
def flush_dns() -> None:
    os.system('ipconfig /flushdns')


# 取得对象服务器的IP地址
def get_host_by_name(host: str) -> str:
    ip_address = gethostbyname(host)
    return ip_address


if __name__ == "__main__":
    main()
