# Zig 相关

## 官网
- [官网](https://ziglang.org/zh/)
- [Github](https://github.com/ziglang/zig)

## 教程
- [Zig 语言圣经](https://course.ziglang.cc/)
- [Zig 语言圣经 Github](https://github.com/zigcc/zig-course)

## 下载
- [Windows_0.13.0](https://ziglang.org/download/0.13.0/zig-windows-x86_64-0.13.0.zip)

## Docker
暂时没有官方镜像，需要自己制作，详见笔者的 [dockerfile](../Container/dev_container/)

## 常用命令

确认
```bash
zig version
zig env
```

创建Zig工程
```bash
mkdir -p /worspace/zig/hello_world
cd /worspace/zig/hello_world
# 工程初始化
zig init
# 编译
zig build
# 运行
./zig-out/bin/hello_world
# 或者
zig run src/main.zig
```

## 编译
``zig cc``、``zig c++`` 是 ``C/C++`` 编译器  
``zig build`` 适用于 ``Zig/C/C++`` 的构建系统

## 依赖项管理
Zig 管理依赖项为先在 ``build.zig.zon`` 添加包的元信息，然后在 ``build.zig`` 中引入包

### zig fetch 命令

获取包的 hash
```bash
zig fetch https://bgithub.xyz/JakubSzark/zig-string/archive/refs/heads/master.tar.gz
122047e740a48165ed1cdd10b8c595cb5b37d2ae2128364957ba0a8de5c7dc396adf
```

将包直接添加到 zon 文件中
```bash
zig fetch --save https://bgithub.xyz/JakubSzark/zig-string/archive/refs/heads/master.tar.gz
```

## 示例工程
 - [zig_sample](./zig_sample)

## VSCode开发
需要安装 [**Zig Language**](https://marketplace.visualstudio.com/items?itemName=ziglang.vscode-zig)  

安装好后在VSCode里面按 ``F1`` → 输入 ``zig lang``  
即可看到 ``Zig Language Server: Install Server``，选择安装即可

## 第三方库
- [awesome-zig](https://github.com/zigcc/awesome-zig)
