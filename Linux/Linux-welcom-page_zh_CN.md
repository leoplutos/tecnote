# Linux自定义欢迎界面

## /etc/motd简介
在类 Unix 系统中，/etc/motd 是一个包含「今日消息（Message of the day）」的文件，用于自定义欢迎界面，在用户成功登录终端后显示。
此外，作为ssh访问系统用户必须配置/etc/ssh/sshd_config文件。

## 更改ssh配置文件
```bash
vim /etc/ssh/sshd_config
```
修改PrintMotd为yes
```
#远程用户登录时是否打印/etc/motd文件信息
PrintMotd yes
```

## 修改/etc/motd
确认
```bash
ll /etc/motd
```
不存在则新建
```bash
touch /etc/motd
```
修改
```bash
vim /etc/motd
```
加入如下内容
```
     _.-"""""-._         _.-"""""-._         _.-"""""-._
   ,'           `.     ,'           `.     ,'           `.
  /               \   /               \   /               \
 |                 | |                 | |                 |
|                   |                   |                   |
|                   |                   |                   |
 |             _.-"|"|"-._         _.-"|"|"-._             |
  \          ,'   /   \   `.     ,'   /   \   `.          /
   `.       /   ,'     `.   \   /   ,'     `.   \       ,'
     `-..__|..-'         `-..|_|..-'         `-..|__..-'
          |                   |                   |
          |                   |                   |
           |                 | |                 |
            \               /   \               /
             `.           ,'     `.           ,'
               `-..___..-'         `-..___..-'
```
退出重新登录即可

## 定制内容的网站

#### ASCiiWorld
提供现成的图案  
http://www.asciiworld.com/

#### Patorjk
可以根据自己输入的文字，并选择对应的字体来生成字符画，字体种类比较丰富  
http://patorjk.com/software/taag/

