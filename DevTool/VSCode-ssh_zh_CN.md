# VSCode 通过SSH进行远程开发

## 下载插件
 - [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) ： 通过SSH协议
 - [Remote - Tunnels](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server) ： 通过VSCode隧道
 - [WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) ： 通过WSL
 - [4合一远程开发工具包](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

因为笔者使用 ``SSH`` 最多，所以这里用 ``Remote - SSH``

## 确认ssh
打开控制台，输入
```
ssh
```
Windows10开始自带ssh，如果是更早的版本可以安装 [Git for Windows](https://git-scm.com/download/win) 来获得

## 服务器端更新
```
sudo apt update
sudo apt install wget ca-certificates
```

## 连接远程服务器
1. 在 VSCode 最左下角处，可以看到一个类似 ``><`` 的图标，点击它
2. 选择 ``Connect to Host...``，会引导你设置要连接的服务器信息。参考 [SSH Config](../Linux/Ssh-config_zh_CN.md) 设置你的连接信息  
例如
```
Host MySshServer
	HostName 172.24.106.152
	User lchuser
	Port 8122
	RequestTTY yes
```
，然后选择目标服务器

3. 连接后需要输入密码验证。第一次登录需要等待一会，因为会在服务器上安装服务端。安装路径为 ``~/.vscode-server``
4. 打开资源管理器（Ctrl + Shift + e），即可选择服务器的路径进行开发
5. 连接成功之后，扩展也会分为 ``本地`` 和 ``SSH``，需要在 ``SSH`` 下安装对应语言的插件。插件的安装路径为 ``~/.vscode-server/extensions``
6. 点击最下角 ``><`` → ``关闭远程连接`` 即可关闭远程开发回到本地

