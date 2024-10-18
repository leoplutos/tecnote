# SSH Config
SSH Config 是 Linux 系统下针对 SSH 客户端的一个参数配置方案，可以将一些关于 SSH 命令的参数放到配置文件中去，执行 ssh 命令的时候从文件中读取，简化命令行的操作。

## 概述
SSH 参数配置有3个层次：

#### 命令行参数
如 ``-p 10086``, ``-i /path/to/identity_file`` 等选项来设置SSH的端口号或认证证书位置

#### 用户配置文件
所在路径为 ``~/.ssh/config``，默认是不存在的，需要手动创建

#### 系统配置文件
所在路径为 ``/etc/ssh/ssh_config``

参数重要性的顺序也是 1 > 2 > 3，即越近的配置重要性越高。前者的设置会覆盖后者。  
笔者这里主要讲述第2种情况下的配置方式，即针对 ``~/.ssh/config`` 文件的写法进行说明。

## 笔者的设定文件
* [config](config)

在设定文件最上面添加
```
Host *
	UserKnownHostsFile=/dev/null
	StrictHostKeyChecking=no
```
以不启用 ``~/.ssh/known_hosts`` 文件，但是会产生中间人攻击，生产环境不要这样设定

## 示例
```
# 设定1
Host server4
	HostName 1.2.3.4
	User user1
	Port 22
	HostKeyAlgorithms +ssh-dss
	#IdentityFile /path/to/key.pem
	RequestTTY yes
	#RemoteCommand exec bash --init-file <(echo 'source /path/to/.bashrc && set -u')
	RemoteCommand exec bash --rcfile /path/to/.bashrc
	#UserKnownHostsFile /dev/null

# 设定2
Host server5
	HostName 1.2.3.5
	User user2
	Port 22
	HostKeyAlgorithms +ssh-dss
	#IdentityFile /path/to/key.pem
	RequestTTY yes
	#RemoteCommand exec bash --init-file <(echo 'source /path/to/.bashrc && set -u')
	RemoteCommand exec bash --rcfile /path/to/.bashrc
	#UserKnownHostsFile /dev/null
```

## 设定内容说明

#### Host
类似昵称，用于标识某个特定的配置，在ssh命令中使用，例如我们想要ssh连接到上例中的#设定1配置的主机，则在命令行执行如下命令即可：
```
ssh server4
```
一个最有用的场景是使用scp在不同主机间传数据。没有配置之间，你得写很长的参数，如
```
scp a.txt user1@1.2.3.4:~/
```
尤其是IP地址记忆起来好麻烦啊。配置过上例中的文件后，这个任务可以简化成这样：
```
scp a.txt server4:~/
```
省略了用户名和IP地址，方便多了。

#### HostName
需要ssh连接过去的主机名，一般是IP地址，也可以用%h来替代命令行参数，这种情况由于我用的不多，所以没有深入了解，具体情况可以参考参考链接。

#### User
登录主机的用户名

#### Port
登录主机的端口号，默认是22端口

#### HostKeyAlgorithms
登录主机的密钥签名算法。如果指定列表以“+”字符开头，是把指定的签名算法将附加到默认设置而不是替换。

#### IdentityFile
认证证书文件，默认位置是~/.ssh/id_rsa, ~/ssh/id_dsa等，如果采用默认的证书，可以不用设置此参数，除非你的证书放在某个自定义的目录，那么你就需要设置该参数来指向你的证书

#### RequestTTY
指定是否为会话请求。参数为：no 不请求TTY、 yes 当标准输入是TTY时总是请求TTY、force 总是请求TTY、auto 打开登录会话时请求TTY。此选项等价于ssh的 -t 选项

#### RemoteCommand
指定成功连接到服务器后要在远程计算机上执行的命令。命令字符串延伸到行尾，并使用用户的 shell 执行。

#### UserKnownHostsFile
指定一个或多个文件以用于用户主机密钥数据库，以空格分隔。每个文件名都可以使用波浪符号来指代用户的主目录、 TOKENS部分中描述的令牌 和ENVIRONMENT VARIABLES部分中描述的环境变量 。值none导致 ssh忽略任何特定于用户的已知主机文件。默认是 ~/.ssh/known_hosts , ~/.ssh/known_hosts2。  
除了一些特殊场合，比如发生“Host key verification failed.”错误，否则**不建议动此设定**。

#### 其他
貌似常用的参数就这些，别的参数可以在命令行通过man ssh_config来查看，其实涉及的参数还是非常多的。

## 更多
https://man.openbsd.org/ssh_config.5
