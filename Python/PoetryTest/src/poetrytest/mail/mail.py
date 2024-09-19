#!/usr/bin/python
# -*- coding: UTF-8 -*-

import smtplib
from email.message import EmailMessage

# 发件人邮箱账号
sender = 'from@example.com'
# 收件人列表
receivers = ['receiver1@example.com', 'receiver2@example.com']

# 邮件内容
message = EmailMessage()
message['From'] = sender
message['To'] = ', '.join(receivers)
message['Subject'] = '这是一封测试邮件'

# 邮件正文内容
mail_content = """
这是邮件正文内容，可以是纯文本或HTML。
你好，张三
此致，敬礼
"""
message.set_content(mail_content)

try:
    # 连接到SMTP服务器
    # smtpObj = smtplib.SMTP_SSL(
    #'smtp.example.com', 465
    # )
    smtpObj = smtplib.SMTP(
        'localhost',
        25,
    )

    smtpObj.send_message(message)
    print("邮件发送成功")
except smtplib.SMTPException as e:
    print("Error: 无法发送邮件", e)
finally:
    # 关闭连接
    smtpObj.quit()
