# Vim-DAP

## DAP简介

DAP（Debug Adapter Protocol）：DAP 顾名思义，它是用来对多种调试器进行抽象统一的适配层，将原有 IDE 和调试工具直接交互的模式更改为和 DAP 进行交互。该模式可以让 IDE 集成多种调试器变得更简单，且灵活性更好。  

## DAP 官网

https://microsoft.github.io/debug-adapter-protocol/  

## 在 Vim 中使用 DAP

笔者主要使用
- [vimspector](https://github.com/puremourning/vimspector)

## vimspector配置

### 小工具设定(gadgets)

``vimspector`` 并不提供DAP服务端，需要自己配置。  
一般有2种方式：  
- 方式1：使用VSCode下载插件，然后把插件路径配置好。
- 方式2：使用 ``:VimspectorInstall debugpy`` 命令安装

小工具的配置目录为：
```
vimspactor安装目录/gadgets/os
```
小工具的配置文件为：
```
.gadgets.json
```
比如笔者的设定文件位置为：
```
C:\Users\Leo-G5000\vimconf\pack\vendor\opt\vimspector\gadgets\windows\.gadgets.json
```

这是一个配置文件例子，其中debugpy是用``VimspectorInstall``命令安装的，cpptools是下载的vscode的插件
```
{
	"adapters": {
		"debugpy": {
			"command": [
				"D:\\Tools\\WorkTool\\Python\\Python38-32\\python.exe",
				"${gadgetDir}/debugpy/build/lib/debugpy/adapter"
			],
			"configuration": {
				"python": "D:\\Tools\\WorkTool\\Python\\Python38-32\\python.exe"
			},
			"custom_handler": "vimspector.custom.python.Debugpy",
			"name": "debugpy"
		},
		"multi-session": {
			"host": "${host}",
			"port": "${port}"
		},
		"vscode-cpptools": {
			"attach": {
				"pidProperty": "processId",
				"pidSelect": "ask"
			},
			"command": [
				"C:/Users/Leo-G5000/.vscode/extensions/ms-vscode.cpptools-1.17.4-win32-x64/debugAdapters/bin/OpenDebugAD7.exe"
			],
			"name": "cppdbg"
		}
	}
}
```

### 项目设定

在项目文件夹的根目录下新建建立如下文件即可
```
.vimspector.json
```

#### C工程配置例子
```
{
	"configurations": {
		"Launch": {
			"adapter": "vscode-cpptools",
			"filetypes": [
				"c",
				"cpp",
				"pc",
				"objc",
				"rust"
			],
			"configuration": {
				"request": "launch",
				"type": "cppdbg",
				"program": "${workspaceRoot}\\bin\\Debug\\${fileBasenameNoExtension}.exe",
				"args": [],
				"stopAtEntry": true,
				"cwd": "${workspaceRoot}\\testdir",
				"environment": [],
				"externalConsole": false,
				"MIMode": "gdb",
				"miDebuggerPath": "D:\\Tools\\WorkTool\\C\\codeblocks-20.03mingw-nosetup\\MinGW\\bin\\gdb.exe",
				"setupCommands": [
					{
						"description": "为 gdb 启用整齐打印",
						"text": "-enable-pretty-printing",
						"ignoreFailures": true
					},
					{
						"description": "将反汇编风格设置为 Intel",
						"text": "-gdb-set disassembly-flavor intel",
						"ignoreFailures": true
					}

				]
			}
		}
	}
}
```

#### Python工程配置例子
```
{
	"configurations": {
		"Launch": {
			"adapter": "debugpy",
			"filetypes": [
				"python"
			],
			"configuration": {
				"name": "Launch",
				"type": "python",
				"request": "launch",
				"cwd": "${workspaceRoot}\\testdir",
				"python": "D:\\Tools\\WorkTool\\Python\\Python38-32\\python.exe",
				"stopOnEntry": true,
				"console": "integratedTerminal",
				"debugOptions": [],
				"program": "${workspaceRoot}\\src\\${fileBasenameNoExtension}.py"
			}
		}
	}
}
```

### 错误处理

如果使用的时候报错
```
pack/vendor/opt/vimspector/python3/vimspector/debug_session.py

UnicodeDecodeError: 'gbk' codec can't decode byte 0xba in position 628: illegal multibyte sequence
```
的话，原因是 ``debug_sesstion.py`` 里面open文件的时候 ``encoding`` 不对，需要手动修改一下。
位置在 ``debug_sesstion.py`` 的191行，``with open`` 这里打开文件的函数加上参数
```
, encoding="utf-8"
```
即可
