# VBScript

## VBScript自动ssh登录脚本

* [VBScript自动ssh登录脚本](user@1.2.3.4-22.vbs)

使用方法：  

双击即可直接运行，会打开设定的终端外壳运行连接ssh服务器，并且自动输入密码。  

先将下面的定义修改  
```
Dim hostName: hostName = "1.2.3.4"
Dim portNo: portNo = "22"
Dim userName: userName = "user"
Dim passWord: passWord = "123456"
```

在这里设定终端外壳  
- 0 : 使用 cmd
- 1 : 使用 powershell
- 2 : 使用 mintty（需要修改mintty的路径）
- 3 : 使用 git-bash（需要修改git-bash的路径）
```
Dim shellType: shellType = 2
```

如果需要自定义登录服务器后的bashrc，修改这里
```
Dim personalBashrc: personalBashrc = True
Dim personalBashrcPath: personalBashrcPath = "/lch/workspace/bashrc/.bashrc-personal"
```

## VSCode内嵌自动ssh登录脚本
具体看 [VSCode说明](../DevTool/VSCode_zh_CN.md) 中 ``笔者的设定文件`` 的 ``tasks.json`` 部分
