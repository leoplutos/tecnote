# GCP

GCP 是 Google Cloud Platform（Google 云平台），是 Google 提供的一整套云计算服务，和 AWS、Microsoft Azure 属于同一类平台。

## 资源层级

GCP 的资源按四层组织，权限（IAM）沿这条链向下继承：

```
Organization（组织）
  └─ Folder（文件夹，可选）
       └─ Project（项目）
            └─ Resource（VM / 存储桶 / 数据库 …）
```

**Project 是最核心的单位**：计费、配额、API 启用、IAM 权限都以项目为边界。日常操作前先确认「当前在哪个项目」，这是最容易踩坑的地方。

## 常用服务

| 分类 | 服务 | 说明 |
|---|---|---|
| **计算** | Compute Engine (GCE) | 虚拟机，对应 AWS EC2 |
| **计算** | Cloud Run | 容器化的 Serverless 服务，按请求自动伸缩（可缩到 0） |
| **计算** | Cloud Run Jobs | 跑完即退出的批处理任务，不接收请求 |
| **计算** | Google Kubernetes Engine (GKE) | 托管 Kubernetes |
| **计算** | Cloud Functions | 函数级 Serverless，对应 AWS Lambda |
| **存储** | Cloud Storage (GCS) | 对象存储，对应 AWS S3 |
| **数据库** | Cloud SQL | 托管 MySQL / PostgreSQL / SQL Server |
| **数据库** | Firestore | 文档型 NoSQL |
| **数据库** | BigQuery | 数据仓库，适合分析与报表 |
| **网络** | VPC / Cloud Load Balancing | 网络与负载均衡 |
| **消息** | Pub/Sub | 消息队列 / 事件分发 |
| **CI/CD** | Cloud Build | 构建流水线 |
| **CI/CD** | Artifact Registry | 容器镜像 / 制品仓库 |
| **权限** | IAM | 账号、角色、权限管理 |
| **运维** | Cloud Logging / Monitoring | 日志与监控（旧称 Stackdriver）|
| **安全** | Secret Manager | 密钥、凭据管理 |

## 与 AWS 的术语对照

| GCP | AWS |
|---|---|
| Project | Account |
| Compute Engine | EC2 |
| Cloud Storage | S3 |
| Cloud Run | App Runner / Fargate |
| Cloud Functions | Lambda |
| GKE | EKS |
| Cloud SQL | RDS |
| BigQuery | Redshift / Athena |
| Pub/Sub | SNS + SQS |
| Artifact Registry | ECR |
| Cloud Logging | CloudWatch Logs |
| Secret Manager | Secrets Manager |

---

# Google Cloud CLI

官方安装文档：https://docs.cloud.google.com/sdk/docs/install-sdk?hl=zh-cn

## 安装（Debian 9+ / Ubuntu 18.04+）

### 1. 安装基础依赖

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates gnupg curl
```

### 2. 导入 Google Cloud 公钥

```bash
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
```

### 3. 添加 gcloud CLI 发行版 URI 作为软件包源

```bash
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
```

### 4. 更新并安装 gcloud CLI

```bash
sudo apt-get update
sudo apt-get install -y google-cloud-cli
```

### 5. 确认

```bash
gcloud version
```

## 登录

> WSL 里没浏览器，`--no-launch-browser` 会给你一个 URL，复制到 Windows 浏览器授权后把码贴回来。

```bash
gcloud auth login --no-launch-browser
```

## 认证与配置确认

确认当前认证状态：

```bash
gcloud auth list
```

检查当前配置：

```bash
gcloud config list
```

## 项目操作

查看能访问哪些项目：

```bash
gcloud projects list
```

设定默认项目：

```bash
gcloud config set project xxx-xxx-xxx
```

## 资源查看

查看该项目下所有 Compute Engine VM：

```bash
gcloud compute instances list
```

查看该项目下所有 Cloud Run Services：

```bash
gcloud run services list
```

查看该项目下所有 Cloud Run Jobs：

```bash
gcloud run jobs list
```
