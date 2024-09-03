#!/bin/bash

cd ..
echo "开始构建镜像"
docker build -t dotnet_grpc:1.0.0 -f ./shell/app_dockerfile .
echo "成功构建镜像"
