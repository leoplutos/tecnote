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
