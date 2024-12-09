# 使用Nodejs镜像
FROM node:20.16-alpine3.20

# 设定alpine镜像仓库为国内源
RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 创建应用路径
RUN mkdir /opt/app

# 添加bash和libc6-compat
# https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine
RUN apk update --quiet
RUN apk add --no-cache --upgrade bash libc6-compat

# 复制所有html文件
COPY *.html /opt/app/FetchDemo/
# 复制所有json文件
COPY *.json /opt/app/FetchDemo/
# 复制所有js文件
COPY *.js /opt/app/FetchDemo/

# 设定环境变量
ENV NODE_ENV="production"

# 个人习惯定制化
RUN echo 'PS_GREEN="\[\033[0;32m\]"' >> /root/.bashrc
RUN echo 'PS_YELLOW="\[\033[0;33m\]"' >> /root/.bashrc
RUN echo 'PS_BLUE="\[\033[0;34m\]"' >> /root/.bashrc
RUN echo 'PS_MAGENTA="\[\033[0;35m\]"' >> /root/.bashrc
RUN echo 'PS_CLEAR="\[\033[0m\]"' >> /root/.bashrc
RUN echo 'export PS1="${PS_GREEN}[Container]${PS_MAGENTA}\u@\h${PS_CLEAR}:${PS_YELLOW}\w${PS_CLEAR}\n${PS_BLUE}\$ ${PS_CLEAR}"' >> /root/.bashrc
RUN echo 'alias ll="ls -hl --full-time --color=auto"' >> /root/.bashrc

# 设置工作目录
WORKDIR /opt/app/FetchDemo

# 声明容器运行时监听的特定网络端口
EXPOSE 9500

# 指定容器创建时的默认命令
CMD ["node", "server.js"]

#docker run --rm -d \
#  -p 9500:9500 \
#  -v /etc/timezone:/etc/timezone:ro \
#  -v /etc/localtime:/etc/localtime:ro \
#  --name fetchdemo_9500 \
#  fetchdemo:latest
