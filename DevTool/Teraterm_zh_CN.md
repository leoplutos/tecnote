# Teraterm设定

## 1.Teraterm的宏脚本

在使用teraterm连接终端的时候，每次都要输入用户名密码很繁琐。这里介绍用宏脚本文件ttl启动的的方法。  

#### 首先，需要新建.ttl脚本文件
※ ttl脚本文件中;为注释
```ttl
;user@192.168.0.3.ttl

;服务器信息
host = '192.168.0.3'
user = 'user'
pass = 'password123'

;使用ssh连接服务器
COMMAND = host
strconcat COMMAND ':22 /ssh /2 /auth=password /user='
strconcat COMMAND user
strconcat COMMAND ' /passwd="'
strconcat COMMAND pass
strconcat COMMAND '"'
connect COMMAND

;自定义登录后的发行command
sendln "export log=/aaa/app/log"
;等待服务器的命令提示符%（也有可能是'$' '#' '>'）
wait '%'

end
```

#### 然后，使用ttl脚本启动teraterm
* 1.鼠标右键 → 新建 → 快捷方式
* 2.输入
```
"C:\Program Files\teraterm\ttpmacro.exe" "/V" "C:\test.ttl"
```
  - 第一个双引号内容为ttpmacro.exe所在路径
  - 第三个双引号内容为ttl脚本所在路径
* 3.给快捷方式设定一个名字
* 4.用快捷方式启动teraterm会自动连接上服务器并且发行自定义命令

## 2.Teraterm的自动log记录设定

Setup → Additional settings... → Log（tab）  
#### 2-1.在[Default log file name]中输入如下内容
```
teraterm-%Y%m%d_%H%M%S_&h.log
```
※ 上面的「&h」代表连接的远程主机的名字

#### 2-2.在[Default log save folder]中  
根据需要选择log路径

#### 2-3.选中[Auto start logging]Checkbox

#### 2-4.设置完成之后，需要保存才能生效
Setup → Save setup...