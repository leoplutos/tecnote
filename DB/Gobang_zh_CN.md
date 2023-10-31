# Gobang

## Gobang简介
Gobang 是一个用 Rust 编写的跨平台 TUI 数据库管理工具。  

支持DB
 - MySQL
 - PostgreSQL
 - SQLite

## 下载安装
* [Github地址](https://github.com/TaKO8Ki/gobang)
* [Windows平台v0.1.0免安装版](https://github.com/TaKO8Ki/gobang/releases/download/v0.1.0-alpha.5/gobang-0.1.0-alpha.5-x86_64-pc-windows-msvc.zip)
* [Linux平台v0.1.0免安装版](https://github.com/TaKO8Ki/gobang/releases/download/v0.1.0-alpha.5/gobang-0.1.0-alpha.5-x86_64-unknown-linux-musl.tar.gz)

## 安装后确认命令
```
gobang --version
```

## 配置文件的默认路径
- Linux:
```
$HOME/.config/gobang/config.toml
```
- MacOS:
```
$HOME/.config/gobang/config.toml
```
- Windows：
```
%APPDATA%/gobang/config.toml
```

## 配置文件示例
```
[[conn]]
type = "mysql"
user = "root"
host = "localhost"
port = 3306
password = "password"
database = "foo"
name = "mysql Foo DB"

[[conn]]
type = "postgres"
user = "root"
host = "localhost"
port = 5432
password = "password"
database = "bar"
name = "postgres Bar DB"

[[conn]]
type = "sqlite"
path = "D:/WorkSpace/DB/Sqlite3/sl3test.db"

[[conn]]
type = "sqlite"
path = "/home/lchuser/work/lch/workspace/db/sqlite3/sl3test.db"
```

## 快捷键
| 键位               | 说明                               |
|--------------------|------------------------------------|
| h, j, k, l         | 左下上右                           |
| Ctrl + u, Ctrl + d | 向上/向下滚动                      |
| g, G               | 到达最上/最下                      |
| H, J, K, L         | 展开1个所选择的单元格向左/下/上/右 |
| y                  | 复制                               |
| ←, →               | 将焦点移至左/右                    |
| c                  | 将焦点移到connections              |
| /                  | 过滤                               |
| ?                  | 帮助                               |
| 1, 2, 3, 4, 5      | 切换到记录/列/约束/外键/索引选项卡 |
| Esc                | 隐藏弹出窗口                       |

## Linux安装命令
先将二进制放到服务器
```
sudo mkdir -p /usr/local/gobang
cd /usr/local/gobang
sudo tar -zxvf ~/work/lch/tmp/gobang-0.1.0-alpha.5-x86_64-unknown-linux-musl.tar.gz -C /usr/local/gobang
sudo chown -R root: /usr/local/gobang
ll /usr/local/gobang/
ll /usr/local/gobang/gobang-0.1.0-alpha.5-x86_64-unknown-linux-musl/
sudo ln -s /usr/local/gobang/gobang-0.1.0-alpha.5-x86_64-unknown-linux-musl/gobang /usr/local/bin/
ll /usr/local/bin
gobang --version
```
编辑配置文件
```
touch $HOME/.config/gobang/config.toml
nvim $HOME/.config/gobang/config.toml
```
