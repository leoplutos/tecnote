# Zig 相关

## 官网
- [官网](https://ziglang.org/zh/)
- [Github](https://github.com/ziglang/zig)

## 教程
- [Zig 语言圣经](https://course.ziglang.cc/)
- [Zig 语言圣经 Github](https://github.com/zigcc/zig-course)

## Docker
暂时没有官方镜像，待补充，可以临时使用如下镜像

拉取镜像，启动容器
```bash
# 此镜像为Wolfi
docker pull chainguard/zig:latest-dev
docker run -it --entrypoint /bin/bash --name zig chainguard/zig:latest-dev
```

Wolfi定制
```bash
echo 'PS_GREEN="\[\033[0;32m\]"' >> /root/.bashrc
echo 'PS_YELLOW="\[\033[0;33m\]"' >> /root/.bashrc
echo 'PS_BLUE="\[\033[0;34m\]"' >> /root/.bashrc
echo 'PS_MAGENTA="\[\033[0;35m\]"' >> /root/.bashrc
echo 'PS_CLEAR="\[\033[0m\]"' >> /root/.bashrc
echo 'export PS1="${PS_GREEN}[Container]${PS_MAGENTA}\u@\h${PS_CLEAR}:${PS_YELLOW}\w${PS_CLEAR}\n${PS_BLUE}\$ ${PS_CLEAR}"' >> /root/.bashrc
echo 'alias ll="ls -hl --full-time --color=auto"' >> /root/.bashrc
. /root/.bashrc

# Wolfi使用apk包，默认镜像源为 https://packages.wolfi.dev/os
# Alpine apk 不能与 Wolfi apk 混合使用
# cat /etc/apk/repositories
# 安装nvim
apk update --quiet
apk add --no-cache --upgrade neovim
```

Zig确认
```bash
zig version
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

再次进入容器
```bash
docker start zig
docker attach zig
```
ssssong'song'song'song'song
## 第三方库

- [awesome-zig](https://github.com/zigcc/awesome-zig)
