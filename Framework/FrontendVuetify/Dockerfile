# Vuetify.js 可以选择构建为SSR版本，或导出为静态HTML
# 导出为静态HTML后的部署方式与部署纯Vue导出的静态HTML一致

# 多阶段构建

# 阶段1：编译，命名为builder
FROM oven/bun:alpine AS builder

# 设定alpine镜像仓库为国内源
RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine
RUN apk update --quiet
# 需要安装 nodejs 才可以编译
# https://github.com/oven-sh/bun/issues/12153
# https://github.com/vuejs/language-tools/issues/4082
RUN apk add --no-cache --upgrade libc6-compat nodejs

# 创建应用路径
RUN mkdir /opt/app

# 将本地文件复制到镜像中
COPY bunfig.toml /opt/app/FrontendVuetify/bunfig.toml
COPY public /opt/app/FrontendVuetify/public
COPY src /opt/app/FrontendVuetify/src
COPY .env.* /opt/app/FrontendVuetify/
COPY env.d.ts /opt/app/FrontendVuetify/env.d.ts
COPY index.html /opt/app/FrontendVuetify/index.html
COPY package.json /opt/app/FrontendVuetify/package.json
COPY tsconfig*.json /opt/app/FrontendVuetify/
COPY vite.config.mts /opt/app/FrontendVuetify/vite.config.mts

# 设定环境变量
ENV NODE_ENV="production"

# 设置工作目录
WORKDIR /opt/app/FrontendVuetify

# 安装依赖并且编译工程
# RUN --mount=type=cache,target=/root/.npm npm install
RUN --mount=type=cache,target=/root/.bun bun install
RUN bun run build

#---------------------------------------------------------------------

# 阶段2：运行
# 根据需要选择nginx的基于alpine的环境
FROM nginx:1.26-alpine3.19-slim

# 设定alpine镜像仓库为国内源
RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 创建应用路径
RUN mkdir /opt/app

# 添加bash，curl
RUN apk update --quiet
RUN apk add --no-cache --upgrade bash curl

# 从阶段1复制编译结果
# 将dist目录下的内容复制到 /usr/share/nginx/html/ 这个目录下面
COPY --from=builder /opt/app/FrontendVuetify/dist/ /usr/share/nginx/html/
# 设定nginx的配置文件default.conf
RUN cp -afp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf_origin_bak
RUN echo $'server {\n\
    listen       80;\n\
    server_name  localhost;\n\
    location / {\n\
        root   /usr/share/nginx/html;\n\
        index  index.html index.htm;\n\
        try_files $uri $uri/ /index.html =404;\n\
    }\n\
    error_page   500 502 503 504  /50x.html;\n\
    location = /50x.html {\n\
        root   /usr/share/nginx/html;\n\
    }\n\
}' > /etc/nginx/conf.d/default.conf

# 个人习惯定制化
RUN echo $'\n\
PS_GREEN="\[\033[0;32m\]"\n\
PS_YELLOW="\[\033[0;33m\]"\n\
PS_BLUE="\[\033[0;34m\]"\n\
PS_MAGENTA="\[\033[0;35m\]"\n\
PS_CLEAR="\[\033[0m\]"\n\
export PS1="${PS_GREEN}[${DOCKER_CONTAINER_NAME}]${PS_MAGENTA}\u@\h${PS_CLEAR}:${PS_YELLOW}\w${PS_CLEAR}\n${PS_BLUE}\$ ${PS_CLEAR}"\n\
alias ll="ls -hl --full-time --color=auto"\n\
alias lg="lazygit"\n\
alias vi="nvim"\n\
alias vim="nvim"\n\
' >> $HOME/.bashrc

# 设置工作目录
WORKDIR /usr/share/nginx/html/

# 声明容器运行时监听的特定网络端口
EXPOSE 80

# docker run -d -p 9500:80 --name vuetify_9500 frontend_vuetify:latest
