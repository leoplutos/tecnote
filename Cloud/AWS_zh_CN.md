# AWS

## Localstack

Localstack 是开发 JIRA 的公司 Atlassian 开发的, 用 Python ``山寨`` 了 AWS 的 API, 通过 REST API 提供跟 AWS 一模一样的服务

它 是一个云服务模拟器，可在笔记本电脑或 CI 环境中的单个容器中运行。使用 LocalStack，您可以完全在本地计算机上运行 AWS 应用程序或 Lambda，而无需连接到远程云提供商

- [Github官网](https://github.com/localstack/localstack)
- [Localstack官网](https://docs.localstack.cloud/overview/)
- [DockerHub官网](https://hub.docker.com/r/localstack/localstack)
- [使用 LocalStack 和 Docker 开发和测试 AWS 云应用程序](https://docs.docker.com/guides/localstack/)

### Localstack Docker 启动
使用命令
```bash
# 拉取社区版镜像(1.15GB 左右), 社区版映像可免费使用不需要许可证
docker pull localstack/localstack:latest
# localstack/localstack-pro:latest 为 Pro版, 收费

# 启动容器
docker run --rm -it \
  -p 4566:4566 \
  -p 4510-4559:4510-4559 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name localstack \
  localstack/localstack:latest
```
如果需要运行 AWS Lambda 的话，必须加上参数 ``-v /var/run/docker.sock:/var/run/docker.sock``
更多参数可以看官方示例配置文件 [docker-compose.yml](https://github.com/localstack/localstack/blob/master/docker-compose.yml)

#### 端口说明
- 4566 : EDGE_PORT
- 4510-4559 : 外部服务端口范围

### 创建本地 Amazon S3 存储
安装 [awscli-local](https://github.com/localstack/awscli-local) 此软件包提供 awslocal 命令，该命令是 AWS 命令行界面的精简包装器，用于 LocalStack

使用 Python 容器进行安装
```bash
# 启动Python容器
docker pull python:3.12-slim
docker run -it --entrypoint /bin/bash \
  --add-host=host.docker.internal:host-gateway \
  --name python312 \
  python:3.12-slim

# 设定国内源
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
pip config list

# 安装 awscli-local
pip install awscli-local[ver1]
awslocal --version

# 使用方法
# 列出本地 S3 存储桶
awslocal --endpoint-url=http://host.docker.internal:4566 s3api list-buckets
export AWS_ENDPOINT_URL=http://host.docker.internal:4566
awslocal s3api list-buckets

# 创建本地 S3 存储桶
awslocal s3 mb s3://mysamplebucket
# awslocal s3api create-bucket --bucket my-bucket

# 删除本地 S3 存储桶
awslocal s3 rb s3://mysamplebucket --force

# 在 DynamoDB 中创建表 Music
# 表名[Music] 分区键[Artist] 排序键[SongTitle] 最大吞吐量[10个读取容量单位]和[5个写入容量单位]
awslocal dynamodb create-table \
  --table-name Music \
  --attribute-definitions \
    AttributeName=Artist,AttributeType=S \
    AttributeName=SongTitle,AttributeType=S \
  --key-schema \
    AttributeName=Artist,KeyType=HASH \
    AttributeName=SongTitle,KeyType=RANGE \
  --provisioned-throughput \
    ReadCapacityUnits=10,WriteCapacityUnits=5 \
  --table-class STANDARD

# 查看表
awslocal dynamodb describe-table --table-name Music
# 删除表
awslocal dynamodb delete-table --table-name Music
```

## AWS SDK

[AWS SDK 和工具包](https://aws.amazon.com/cn/developer/tools/)

## 主流语言SDK

### Node.js(TypeScript)
示例代码 [aws](../Web/TSSampleProject/src/aws/)
