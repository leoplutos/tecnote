# Docker-在容器内开发

## 前言
在微服务大行其道的时代，有时候会有在容器内开发的需求，本文记录一下笔者在容器内开发的内容

## 开发环境
- Windows 10
- WSL2（Ubuntu-22.04）
- Docker 27.0.3

为了解决 Docker 数据卷挂载的文件权限问题，在容器内没有使用 root 用户  
而是在容器内新建了和宿主机一致的用户和组  
然后使用 ``gosu`` 进行用户切换

## 使用 VSCode 开发

容器内 SSH 端口 ``22``，映射到宿主机 ``50022``，SSH登录密码使用 ``ARG_USER_PWD`` 参数设定

VSCode使用 [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) 插件登录到容器内进行开发  
需要使用 ``x86_64 Debian 8+、Ubuntu 16.04+、CentOS/RHEL 7+ Linux``

### Dockerfile 存放位置
- [vscode](./dev_container/vscode/)

### Java 环境

- ``Dockerfile_java`` : Ubuntu22.04 Jammy 镜像，gRPC开发使用

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/vscode`` 内

构建镜像
```bash
cd ~/workspace/dev_container/vscode

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_USER_PWD="123456" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t java21_vsc_image:latest \
  -f Dockerfile_java .
```

启动容器
```bash
mkdir -p /home/$USER/.vscode-server
mkdir -p /home/$USER/.m2/repository
docker run -itd \
  -p 50022:22 \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.vscode-server:/home/$(id -un)/.vscode-server \
  -v /home/$USER/.m2/repository:/home/$(id -un)/.m2/repository \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name java21_vsc \
  java21_vsc_image:latest
```

### .NET Core 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/vscode`` 内

- ``Dockerfile_csharp`` : Deiban12 Bookworm 镜像，gRPC开发使用

构建镜像
```bash
cd ~/workspace/dev_container/vscode

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_USER_PWD="123456" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t dotnet8_vsc_image:latest \
  -f Dockerfile_csharp .
```

启动容器
```bash
mkdir -p /home/$USER/.vscode-server
mkdir -p /home/$USER/.nuget/packages
docker run -itd \
  -p 50022:22 \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.vscode-server:/home/$(id -un)/.vscode-server \
  -v /home/$USER/.nuget/packages:/home/$(id -un)/.nuget/packages \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name dotnet8_vsc \
  dotnet8_vsc_image:latest
```

### Golang 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/vscode`` 内

构建镜像
```bash
cd ~/workspace/dev_container/vscode

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_USER_PWD="123456" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t golang_vsc_image:latest \
  -f Dockerfile_golang .
```

启动容器
```bash
mkdir -p /home/$USER/.vscode-server
mkdir -p /home/$USER/.go/pkg/mod
docker run -itd \
  -p 50022:22 \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.vscode-server:/home/$(id -un)/.vscode-server \
  -v /home/$USER/.go/pkg/mod:/home/$(id -un)/.go/pkg/mod \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name golang_vsc \
  golang_vsc_image:latest
```

### Rust 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/vscode`` 内

构建镜像
```bash
cd ~/workspace/dev_container/vscode

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_USER_PWD="123456" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t rust_vsc_image:latest \
  -f Dockerfile_rust .
```

启动容器
```bash
mkdir -p /home/$USER/.vscode-server
mkdir -p /home/$USER/.cargo/registry
docker run -itd \
  -p 50022:22 \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.vscode-server:/home/$(id -un)/.vscode-server \
  -v /home/$USER/.cargo/registry:/usr/local/cargo/registry/ \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name rust_vsc \
  rust_vsc_image:latest
```

### Python 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/vscode`` 内

构建镜像
```bash
cd ~/workspace/dev_container/vscode

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_USER_PWD="123456" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t python_vsc_image:latest \
  -f Dockerfile_python .
```

启动容器
```bash
mkdir -p /home/$USER/.vscode-server
mkdir -p /home/$USER/.cache/pypoetry
docker run -itd \
  -p 50022:22 \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.vscode-server:/home/$(id -un)/.vscode-server \
  -v /home/$USER/.cache/pypoetry:/home/$(id -un)/.cache/pypoetry \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name python_vsc \
  python_vsc_image:latest
```

### Node.js 环境

这里使用 ``Bun`` 镜像，生成环境建议使用 ``Node.js``镜像  
官方的 ``Bun`` 镜像 和 ``Node.js``镜像都有1000:1000用户，所以这里不做新建用户的设定  

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/vscode`` 内

构建镜像
```bash
cd ~/workspace/dev_container/vscode

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_USER_PWD="123456" \
  -t node_vsc_image:latest \
  -f Dockerfile_node .
```

启动容器
```bash
mkdir -p /home/$USER/.vscode-server
mkdir -p /home/$USER/.bun/install/cache
mkdir -p /home/$USER/.npm
docker run -itd \
  -p 50022:22 \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.vscode-server:/home/bun/.vscode-server \
  -v /home/$USER/.bun/install/cache:/home/bun/.bun/install/cache \
  -v /home/$USER/.npm:/home/bun/.npm \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name node_vsc \
  node_vsc_image:latest
```

### Zig 环境

因为暂时没有官方镜像，所以从debian-slim自己定制

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/vscode`` 内

构建镜像
```bash
cd ~/workspace/dev_container/vscode

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_USER_PWD="123456" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t zig_vsc_image:latest \
  -f Dockerfile_zig .
```

启动容器
```bash
mkdir -p /home/$USER/.vscode-server
mkdir -p /home/$USER/.cache/zig
docker run -itd \
  -p 50022:22 \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.vscode-server:/home/$(id -un)/.vscode-server \
  -v /home/$USER/.cache/zig:/home/$(id -un)/.cache/zig \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name zig_vsc \
  zig_vsc_image:latest
```
### CentOS Stream 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/vscode`` 内

构建镜像
```bash
cd ~/workspace/dev_container/vscode

# 指定Github设定的下载地址，用户和组
docker build \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t centos_vsc_image:latest \
  -f Dockerfile_centos_stream .
```

启动容器
```bash
mkdir -p /home/$USER/.vscode-server
docker run -d \
  -p 50022:22 \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.vscode-server:/home/$(id -un)/.vscode-server \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name centos_vsc \
  centos_vsc_image:latest
```

## 使用 Neovim 开发

需要 ``Neovim 0.10 +``

### Dockerfile 存放位置
- [neovim](./dev_container/neovim/)

### Java 环境

- ``Dockerfile_java`` : Ubuntu22.04 Jammy 镜像，gRPC开发使用
- ``Dockerfile_java_alpine`` : alpine 镜像，其他时使用

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/neovim`` 内

构建镜像
```bash
cd ~/workspace/dev_container/neovim

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_GITHUB_URL="http://host.docker.internal:13000" \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t java21_nvim_image:latest \
  -f Dockerfile_java .
# -f Dockerfile_java_alpine .
```

启动容器
```bash
mkdir -p /home/$USER/.m2/repository
docker run -it \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.m2/repository:/home/$(id -un)/.m2/repository \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name java21_nvim \
  java21_nvim_image:latest
```

启动 ``nvim`` 后，安装 ``treesitter`` 高亮
```bash
:TSInstall java properties xml jsonc yaml html javascript css scss sql dockerfile bash proto markdown markdown_inline lua query vim vimdoc
# :TSInstallInfo
# :TSUpdate
# :TSUninstall json json5
```

### .NET Core 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/neovim`` 内

- ``Dockerfile_csharp`` : Deiban12 Bookworm 镜像，gRPC开发使用
- ``Dockerfile_csharp_alpine`` : alpine 镜像，其他时使用

构建镜像
```bash
cd ~/workspace/dev_container/neovim

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_GITHUB_URL="http://host.docker.internal:13000" \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t dotnet8_nvim_image:latest \
  -f Dockerfile_csharp .
# -f Dockerfile_csharp_alpine .
```

启动容器
```bash
mkdir -p /home/$USER/.nuget/packages
docker run -it \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.nuget/packages:/home/$(id -un)/.nuget/packages \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name dotnet8_nvim \
  dotnet8_nvim_image:latest
```

启动 ``nvim`` 后，安装 ``treesitter`` 高亮
```bash
:TSInstall c_sharp xml jsonc yaml html javascript css scss sql dockerfile bash proto markdown markdown_inline lua query vim vimdoc
# :TSInstallInfo
# :TSUpdate
# :TSUninstall json json5
```

### Golang 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/neovim`` 内

构建镜像
```bash
cd ~/workspace/dev_container/neovim

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_GITHUB_URL="http://host.docker.internal:13000" \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t golang_nvim_image:latest \
  -f Dockerfile_golang .
```

启动容器
```bash
mkdir -p /home/$USER/.go/pkg/mod
docker run -it \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.go/pkg/mod:/home/$(id -un)/.go/pkg/mod \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name golang_nvim \
  golang_nvim_image:latest
```

启动 ``nvim`` 后，安装 ``treesitter`` 高亮
```bash
:TSInstall go gomod gowork jsonc yaml html javascript css scss sql dockerfile bash proto markdown markdown_inline lua query vim vimdoc
# :TSInstallInfo
# :TSUpdate
# :TSUninstall json json5
```

### Rust 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/neovim`` 内

构建镜像
```bash
cd ~/workspace/dev_container/neovim

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_GITHUB_URL="http://host.docker.internal:13000" \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t rust_nvim_image:latest \
  -f Dockerfile_rust .
```

启动容器
```bash
mkdir -p /home/$USER/.cargo/registry
docker run -it \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.cargo/registry:/usr/local/cargo/registry/ \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name rust_nvim \
  rust_nvim_image:latest
```

启动 ``nvim`` 后，安装 ``treesitter`` 高亮
```bash
:TSInstall rust toml jsonc yaml ini html javascript css scss sql dockerfile bash proto markdown markdown_inline lua query vim vimdoc
# :TSInstallInfo
# :TSUpdate
# :TSUninstall json json5
```

### Python 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/neovim`` 内

构建镜像
```bash
cd ~/workspace/dev_container/neovim

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_GITHUB_URL="http://host.docker.internal:13000" \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t python_nvim_image:latest \
  -f Dockerfile_python .
# -f Dockerfile_python_alpine .
```

启动容器
```bash
mkdir -p /home/$USER/.cache/pypoetry
docker run -it \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.cache/pypoetry:/home/$(id -un)/.cache/pypoetry \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name python_nvim \
  python_nvim_image:latest
```

启动 ``nvim`` 后，安装 ``treesitter`` 高亮
```bash
:TSInstall python ini toml jsonc yaml html javascript css scss sql dockerfile bash proto markdown markdown_inline lua query vim vimdoc
# :TSInstallInfo
# :TSUpdate
# :TSUninstall json json5
```

### Node.js 环境

这里使用 ``Bun`` 镜像，生成环境建议使用 ``Node.js``镜像  
官方的 ``Bun`` 镜像 和 ``Node.js``镜像都有1000:1000用户，所以这里不做新建用户的设定  

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/neovim`` 内

构建镜像
```bash
cd ~/workspace/dev_container/neovim

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_GITHUB_URL="http://host.docker.internal:13000" \
  -t node_nvim_image:latest \
  -f Dockerfile_node .
```

启动容器
```bash
mkdir -p /home/$USER/.bun/install/cache
mkdir -p /home/$USER/.npm
docker run -it \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.bun/install/cache:/home/bun/.bun/install/cache \
  -v /home/$USER/.npm:/home/bun/.npm \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name node_nvim \
  node_nvim_image:latest
```

启动 ``nvim`` 后，安装 ``treesitter`` 高亮
```bash
:TSInstall typescript toml jsonc yaml html javascript css scss sql dockerfile bash proto markdown markdown_inline lua query vim vimdoc
# :TSInstallInfo
# :TSUpdate
# :TSUninstall json json5
```

### Zig 环境

因为暂时没有官方镜像，所以从debian-slim自己定制

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/neovim`` 内

构建镜像
```bash
cd ~/workspace/dev_container/neovim

# 指定Github设定的下载地址，用户和组
docker build \
  --add-host=host.docker.internal:host-gateway \
  --build-arg ARG_GITHUB_URL="http://host.docker.internal:13000" \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t zig_nvim_image:latest \
  -f Dockerfile_zig .
```

启动容器
```bash
mkdir -p /home/$USER/.cache/zig
docker run -it \
  -v /home/$USER/workspace:/workspace \
  -v /home/$USER/.cache/zig:/home/$(id -un)/.cache/zig \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name zig_nvim \
  zig_nvim_image:latest
```

启动 ``nvim`` 后，安装 ``treesitter`` 高亮
```bash
:TSInstall zig toml jsonc yaml html javascript css scss sql dockerfile bash proto markdown markdown_inline lua query vim vimdoc
```

### CentOS Stream 环境

将 ``Dockerfile`` 放到 ``cd ~/workspace/dev_container/neovim`` 内

构建镜像
```bash
cd ~/workspace/dev_container/neovim

# 指定Github设定的下载地址，用户和组
docker build \
  --build-arg ARG_USER_ID="$(id -u)" \
  --build-arg ARG_USER_NAME="$(id -un)" \
  --build-arg ARG_GROUP_ID="$(id -g)" \
  --build-arg ARG_GROUP_NAME="$(id -gn)" \
  -t centos_nvim_image:latest \
  -f Dockerfile_centos_stream .
```

启动容器
```bash
docker run -it \
  -v /home/$USER/workspace:/workspace \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --add-host=host.docker.internal:host-gateway \
  --name centos_nvim \
  centos_nvim_image:latest
```
