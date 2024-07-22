#!/bin/bash

cd ..
echo "开始构建镜像"
docker build -t backend_gin:1.0.0 -f ./shell/app_dockerfile .
# docker build -t backend_gin:1.0.0 -f ./shell/app_dockerfile_singel .
echo "成功构建镜像"
