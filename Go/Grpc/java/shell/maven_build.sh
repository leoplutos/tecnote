#!/bin/bash

cd ..
echo "开始构建jar"
mvn -f pom_docker.xml clean compile assembly:single -Dmaven.test.skip=true
echo "成功构建jar"
