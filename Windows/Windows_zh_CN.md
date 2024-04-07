# Windows

## 右键→发送到
``Win键+r`` 然后输入
```
shell:sendto
```
可以打开，一般地址为
```
C:\Users\{user}\AppData\Roaming\Microsoft\Windows\SendTo
```
将快捷方式粘贴到此即可  
这里记录几个开发工具  
1. Gvim
新建快捷方式，输入地址
```
"D:\Tools\WorkTool\Text\vim90\gvim.exe" -p --remote-tab-silent "%*"
```
2. VSCode
直接将VSCode复制到这里即可

## 开机自动运行
``Win键+r`` 然后输入
```
shell:startup
```
可以打开，一般地址为
```
C:\Users\{user}\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```
将快捷方式粘贴到这里即可

## 使用 CURL 命令下载

支持断点续传的下载
```
curl -L -O https://download.url/a.zip  -C -
```

## 系统优化工具 - Optimizer
[github - optimizer](https://github.com/hellzerg/optimizer)

## 精简版Windows - AtlasOS
[github - Atlas](https://github.com/Atlas-OS/Atlas)

## Windows10添加双拼

添加小鹤的方法有两种

1. 微软拼音设置里面 ``添加双拼方案``，手工输入布局
2. 用写字板新建立一个 ``小鹤双拼-Win10.reg`` 文件，内容如下

```
Windows Registry Editor Version 5.00
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputMethod\Settings\CHS]
"Enable Double Pinyin"=dword:00000001
"DoublePinyinScheme"=dword:0000000a
"UserDefinedDoublePinyinScheme0"="小鹤双拼*2*^*iuvdjhcwfg^xmlnpbksqszxkrltvyovt"
```

## Windows10终端软件
[cmder](https://cmder.app/)  
Windows下的终端软件，VSCode支持内嵌


