# Php语言相关

## Php

### Php下载
官方下载地址：  
https://windows.php.net/download/  

按需选择非线程安全版本（Non Thread Safe）和线程安全版本（Thread Safe）下载即可

比如  
https://windows.php.net/downloads/releases/php-8.2.28-nts-Win32-vs16-x64.zip


### 配置环境变量

下载后解压缩，然后配置环境变量
```bash
set PHP_HOME=D:\Tools\WorkTool\Php\php
set PATH=%PATH%;%PHP_HOME%
```

配置好后确认
```bash
php --version
```

### 配置设定文件 php.ini

在安装目录内可以找到 ``php.ini-development``  
将其复制一份并重命名为 ``php.ini``  
编辑 ``php.ini`` 将下面注释掉的内容 ``按需`` 打开  

```
extension_dir = "ext"

extension=curl
extension=fileinfo
extension=mbstring
extension=openssl
extension=pdo_pgsql
extension=pgsql

extension=zip
```

## Php 包管理器 Composer

### Composer 下载
官方下载地址：  
https://getcomposer.org/download/

按需选择一个版本下载即可

比如  
https://getcomposer.org/download/2.8.6/composer.phar

**NOTE**：``composer.phar`` 是一个PHPar打包后的，可执行的脚本文件

### 配置环境变量

将下载的 ``composer.phar`` 放到 ``D:\Tools\WorkTool\Php\composer``  
然后运行命令
```bash
cd D:\Tools\WorkTool\Php\composer
echo @php "%~dp0composer.phar" %*>composer.bat
```
会新生成文件 ``composer.bat``

然后配置环境变量
```bash
set COMPOSER_HOME=D:\Tools\WorkTool\Php\composer
set PATH=%PATH%;%COMPOSER_HOME%
```

配置好后确认
```bash
composer -V
```

### 配置 Composer 设定

``按需`` 设定
```bash
# 这个设定会禁用tls，慎用
# composer config -g -- disable-tls true
```

运行后在 ``D:\Tools\WorkTool\Php\composer`` 生成 ``config.json``

## 启动 Php 工程

运行命令
```bash
cd D:\pathto\php_backend
# 安装依赖库
composer install
# 启动
php -S localhost:9501
# 指定根目录为 public 文件夹并启动
php -S localhost:9501 -t public
```

## 使用 VSCode 开发
使用插件为
- [**PHP Intelephense**](https://marketplace.visualstudio.com/items?itemName=bmewburn.vscode-intelephense-client)  

### settings.json例子

``settings.json``
```json
{
    "editor.guides.indentation": true, //缩进参考线
    "files.eol": "\n", // LF 换行
    "php.validate.executablePath": "D:/Tools/WorkTool/Php/php/php.exe",
    "php.validate.run": "onType",
    // "php.validate.executablePath": "/usr/bin/php" // Linux
    "intelephense.environment.shortOpenTag": true,
    "intelephense.diagnostics.undefinedClassConstants": false,
    "intelephense.diagnostics.undefinedConstants": false,
    "intelephense.diagnostics.undefinedFunctions": false,
    "intelephense.diagnostics.undefinedMethods": false,
    "intelephense.diagnostics.undefinedProperties": false,
    "intelephense.diagnostics.undefinedTypes": false,
    "debug.allowBreakpointsEverywhere": true, //允许在任何文件中设置断点
    "terminal.integrated.automationProfile.windows": {
        //自动化相关终端的设定(如Codelens上面的[Run]，[Debug]和其他的任务)（设定后需要重启）
        "path": "${env:windir}\\System32\\cmd.exe",
        "args": [
            "/k",
            "chcp",
            "65001",
        ],
        "env": {},
        "icon": "terminal-ubuntu",
        "color": "terminal.ansiYellow",
        "overrideName": true
    },
    "terminal.integrated.env.windows": { //设定所有终端环境变量
    },
}
```

### tasks.json例子

``tasks.json``
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
                "PATH": "${env:path};D:\\Tools\\WorkTool\\Php\\php;D:\\Tools\\WorkTool\\Php\\composer",
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
            "label": "composer_install",
            "type": "shell",
            "command": "composer install",
            "args": [],
            "options": {
                "cwd": "${workspaceFolder}"
            },
            "problemMatcher": [],
            "detail": "安装依赖",
        },
        {
            "label": "start_php",
            "type": "shell",
            // php -S localhost:9501 -t public
            "command": "php -S localhost:9501",
            "args": [],
            "options": {
                "cwd": "${workspaceFolder}"
            },
            "problemMatcher": [],
            "detail": "启动PHP服务(端口9501)",
        },
    ]
}
```

## 使用 VSCode 调式

使用插件为
- [**PHP Debug**](https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug)  

### Php设定

####  访问 phpinfo.php

新建文件 ``phpinfo.php``
```php
<?php
    phpinfo();
?>
```

#### 启动Php
启动 Php 访问这个网页，并且复制内容（``Ctrl+A`` 然后 ``Ctrl+C`` 即可）

#### 下载dll
访问  https://xdebug.org/wizard

在 TextArea 中粘贴复制的内容，然后点击 ``Analyse my phpinfo() output``

在 ``Instructions`` 节点处可以找到 xdebug 的 dll 文件下载

下载 dll 文件后，将文件移动到 php 安装目录下的 ``ext`` 目录内并且重命名为 ``php_xdebug.dll``

#### 更新 php.ini

```ini
;zend_extension=opcache

[xdebug]
zend_extension="D:\Tools\WorkTool\Php\php\ext\php_xdebug.dll"
; debug 可以使用 VSCode 等 IDE 进行远程调试
; profile 进行性能分析（测量执行时间和内存使用量）
; trace 输出执行跟踪（记录函数的执行顺序等）
; 可使用逗号分隔指定多个选项
xdebug.mode=debug,profile
; 设置在执行 PHP 脚本时是否自动启用 Xdebug
xdebug.start_with_request=yes
xdebug.client_host=127.0.0.1
xdebug.client_port=9003
;xdebug.idekey=PHPSTORM
```

#### 重新访问 phpinfo.php

``Ctrl+A`` 搜索 ``xdebug`` 如果可以找到 ``xdebug`` 表示已经安装完成

### 配置 launch.json

在 Php 工程中新建 ``launch.json``

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www/project-directory": "${workspaceFolder}/public"
            },
            // 指定调试时不进行单步执行（跳过）的文件
            "skipFiles": [
                "**/project-directory/index.php",
                "**/App/Model/Func2.php"
            ],
            // 设置忽略特定的 PHP 错误
            "ignore": [
                "E_WARNING",
                "E_NOTICE",
                "E_DEPRECATED"
            ]
        }
    ]
}
```

### 开始调试
1. 运行命令启动 Php 工程
```bash
php -S localhost:9501 -t public
```

2. 在 ``VSCode`` 按下 ``F5`` 启动 ``launch.json``

3. 为程序添加断点

4. 访问URL即可进入调试

## 其他

### 报错 GuzzleHttp Exception

**错误信息**

```
GuzzleHttp Exception cURL error 60: SSL certificate problem: unable to get local issuer certificate
```

**解决办法**

访问  https://curl.haxx.se/ca/cacert.pem  下载 ``cacert.pem``

将下载好的文件放在 ``D:\Tools\WorkTool\Php\php\pem``

**修改 php.ini**

```ini
curl.cainfo ="D:\Tools\WorkTool\Php\php\pem\cacert.pem"
```

参考： [GuzzleHttp Exception cURL error 60: SSL certificate problem: unable to get local issuer certificate](https://github.com/guzzle/guzzle/issues/1935)



