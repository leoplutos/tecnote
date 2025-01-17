# Lua

## Lua简介

Lua 是一种轻量小巧的脚本语言，用标准C语言编写并以源代码形式开放， 其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。

Lua 是巴西里约热内卢天主教大学（Pontifical Catholic University of Rio de Janeiro）里的一个研究小组于 1993 年开发的，该小组成员有：Roberto Ierusalimschy、Waldemar Celes 和 Luiz Henrique de Figueiredo

## 下载及配置环境

### 下载
访问 [这里](https://luabinaries.sourceforge.net/download.html) 下载 Windows 二进制 ``lua-5.4.2_Win64_bin.zip``

### 配置环境变量
```bash
set LUA_HOME=D:\Tools\WorkTool\Lua
set PATH=%PATH%;%LUA_HOME%
```

配置好后打开终端确认
```bash
lua54 -v
```

### 使用 VSCode 开发
使用插件为  [**Lua**](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)  


### 配置 ``tasks.json``

```json
{
	"version": "2.0.0",
	"windows": {
		"options": { //tasks.json定义的所有内容都使用cmd运行
			"shell": {
				"executable": "cmd.exe",
				"args": [
					"/d",
					"/c"
				]
			},
			"env": { //自定义环境变量
				// 添加 lua
				"PATH": "${env:path};D:/Tools/WorkTool/Lua"
			}
		},
	},
	"linux": {
		"options": { //tasks.json定义的所有内容都使用bash运行
			"shell": {
				"executable": "bash",
			},
			"env": { //自定义环境变量
			}
		},
	},
	"presentation": {
		"echo": true,
		"reveal": "always",
		"focus": true,
		"panel": "new"
	},
	"tasks": [
		{
			"label": "lua_run",
			"type": "shell",
			"command": "lua54 main.lua",
			"windows": {
				"command": "chcp 65001 && lua54 main.lua"
			},
			"args": [],
			"options": {
				"cwd": "${workspaceFolder}"
			},
			"problemMatcher": [],
			"detail": "运行",
		},
	]
}
```
