# Next.js 可以选择构建为SSR版本，或导出为静态HTML
# 导出为静态HTML后的部署方式与部署纯Vue导出的静态HTML一致
# 这里使用构建SSR的工作方式
# 更多可看:
#  https://nextjs.org/docs/app/building-your-application/deploying
#  https://github.com/vercel/next.js/tree/canary/examples/with-docker

# 多阶段构建

# 阶段1：编译，命名为builder
FROM oven/bun:alpine AS builder

# 设定alpine镜像仓库为国内源
RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine
RUN apk update --quiet
RUN apk add --no-cache --upgrade libc6-compat

# 创建应用路径
RUN mkdir /opt/app

# 将本地文件复制到镜像中
COPY bunfig.toml /opt/app/FullStackNext/bunfig.toml
COPY public /opt/app/FullStackNext/public
COPY src /opt/app/FullStackNext/src
COPY .env.production /opt/app/FullStackNext/.env.production
COPY components.json /opt/app/FullStackNext/components.json
COPY next*.ts /opt/app/FullStackNext/
COPY package.json /opt/app/FullStackNext/package.json
COPY postcss.config.mjs /opt/app/FullStackNext/postcss.config.mjs
COPY tailwind.config.ts /opt/app/FullStackNext/tailwind.config.ts
COPY tsconfig.json /opt/app/FullStackNext/tsconfig.json

# 设定环境变量
ENV NODE_ENV="production"
# 禁用 Next.js 遥测
ENV NEXT_TELEMETRY_DISABLED=1

# 设置工作目录
WORKDIR /opt/app/FullStackNext

# 安装依赖并且编译工程
# RUN --mount=type=cache,target=/root/.npm npm install
RUN --mount=type=cache,target=/root/.bun bun install
RUN bun run build

#---------------------------------------------------------------------

# 阶段2：运行
FROM node:20.16-alpine3.20

# 设定alpine镜像仓库为国内源
RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine
RUN apk update --quiet
RUN apk add --no-cache --upgrade bash curl libc6-compat

# 创建应用路径
RUN mkdir /opt/app

# 设定环境变量
ENV NODE_ENV="production"
# 禁用 Next.js 遥测
ENV NEXT_TELEMETRY_DISABLED=1
# 设定监听 host 和 端口
ENV HOSTNAME="0.0.0.0"
ENV PORT=9500
# https://authjs.dev/reference/core#trusthost
ENV AUTH_TRUST_HOST="true"

# 创建用户（以非 root 运行）
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# 从阶段1复制编译结果
COPY --from=builder --chown=nextjs:nodejs /opt/app/FullStackNext/public /opt/app/FullStackNext/public
COPY --from=builder --chown=nextjs:nodejs /opt/app/FullStackNext/.next/standalone /opt/app/FullStackNext/
COPY --from=builder --chown=nextjs:nodejs /opt/app/FullStackNext/.next/static /opt/app/FullStackNext/.next/static

# 指定用户
USER nextjs

# 设置工作目录
WORKDIR /opt/app/FullStackNext

# 声明容器运行时监听的特定网络端口
EXPOSE 9500

# 指定容器创建时的默认命令
CMD ["node", "server.js"]

# 启动命令
# docker run -d -p 9500:9500 --name next_9500 fullstack_next:latest
