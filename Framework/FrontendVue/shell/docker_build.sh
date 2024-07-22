#!/bin/bash

cd ..
echo "开始构建镜像"
docker build -t frontend_vue:1.0.0 -f ./shell/app_dockerfile .
echo "成功构建镜像"
