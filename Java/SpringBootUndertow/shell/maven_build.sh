#!/bin/bash

cd ..
echo "开始构建jar"
mvn clean package -Dmaven.test.skip=true
echo "成功构建jar"
