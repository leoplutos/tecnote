#!/bin/bash

cd ..
echo "开始构建镜像"
docker build -t zig_sample:latest -f ./shell/app_dockerfile .
echo "成功构建镜像"
