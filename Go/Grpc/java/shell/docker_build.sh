#!/bin/bash

cd ..
echo "确认构建环境"
# 镜像名
image_name="java_grpc:latest"
# 生成参数
param_str=""
if [ "$1" == "k3s" ]; then
    # 如果参数1为 k3s，则构建k3s命名空间的镜像
    param_str="--address=/run/k3s/containerd/containerd.sock --namespace=k8s.io"
else
    # 否则使用所有参数
    param_str="$@"
fi
# 因为给nerdctl创建了一个docker的别名,所以用此判断
# docker -v
#  nerdctl环境返回: nerdctl version 2.0.0
#  docker环境返回: Docker version 27.3.1, build ce12230
docker_cmd=$(docker -v | awk '{print $1}')
echo "使用 ${docker_cmd} 构建开始"
if [ "$docker_cmd" == "nerdctl" ]; then
    # 打开回显
    set -x
    sudo nerdctl build $param_str -t $image_name -f ./shell/app_dockerfile .
	# 关闭回显
	set +x
else
    # 打开回显
    set -x
    docker build -t $image_name -f ./shell/app_dockerfile .
	# 关闭回显
	set +x
fi
# 检查命令的返回值
if [ $? -eq 0 ]; then
    echo -e "\033[1;32m OK \033[0m构建镜像成功"
else
    echo -e "\033[1;31m NG \033[0m构建镜像失败"
fi
