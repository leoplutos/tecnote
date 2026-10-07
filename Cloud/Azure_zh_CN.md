# Azure

Azure 是 Microsoft Azure（微软云平台），是 Microsoft 提供的一整套云计算服务，和 AWS、GCP 属于同一类平台。

## 资源层级

Azure 的资源按四层组织，权限（RBAC）沿这条链向下继承：

```
Management Group（管理组，可选，可多层嵌套）
  └─ Subscription（订阅）
       └─ Resource Group（资源组）
            └─ Resource（VM / 存储账户 / 数据库 …）
```

**Subscription 是计费与配额的边界**，**Resource Group 是资源的管理单位**（同一批资源一起创建、一起删除）。日常操作前先确认「当前在哪个订阅」，这是最容易踩坑的地方。

> 和 GCP 的差异：GCP 的 Project 一个人身兼「计费边界 + 资源容器」两职；Azure 把它拆成了 Subscription（计费）和 Resource Group（容器）两层。

## 常用服务

| 分类 | 服务 | 说明 |
|---|---|---|
| **计算** | Virtual Machines (VM) | 虚拟机，对应 AWS EC2 |
| **计算** | Container Apps | 容器化的 Serverless 服务，按请求自动伸缩（可缩到 0） |
| **计算** | Container Apps Jobs | 跑完即退出的批处理任务，不接收请求 |
| **计算** | Azure Kubernetes Service (AKS) | 托管 Kubernetes |
| **计算** | Azure Functions | 函数级 Serverless，对应 AWS Lambda |
| **计算** | App Service | 托管 Web 应用 / API |
| **存储** | Blob Storage | 对象存储，对应 AWS S3 |
| **数据库** | Azure Database for MySQL / PostgreSQL | 托管 MySQL / PostgreSQL |
| **数据库** | Azure SQL Database | 托管 SQL Server |
| **数据库** | Cosmos DB | 文档型 NoSQL（多模型） |
| **数据库** | Synapse Analytics / Fabric | 数据仓库，适合分析与报表 |
| **网络** | VNet / Load Balancer / Application Gateway | 网络与负载均衡 |
| **消息** | Service Bus / Event Grid / Event Hubs | 消息队列 / 事件分发 / 流式接入 |
| **CI/CD** | Azure Pipelines（Azure DevOps） | 构建流水线 |
| **CI/CD** | Azure Container Registry (ACR) | 容器镜像 / 制品仓库 |
| **权限** | Microsoft Entra ID + RBAC | 账号（旧称 Azure AD）、角色、权限管理 |
| **运维** | Azure Monitor / Log Analytics | 日志与监控 |
| **安全** | Key Vault | 密钥、证书、凭据管理 |

## 与 AWS / GCP 的术语对照

| Azure | AWS | GCP |
|---|---|---|
| Subscription | Account | Project（计费部分） |
| Resource Group | （无直接对应） | Project（容器部分） |
| Virtual Machines | EC2 | Compute Engine |
| Blob Storage | S3 | Cloud Storage |
| Container Apps | App Runner / Fargate | Cloud Run |
| Azure Functions | Lambda | Cloud Functions |
| AKS | EKS | GKE |
| Azure SQL / Database for MySQL | RDS | Cloud SQL |
| Synapse / Fabric | Redshift / Athena | BigQuery |
| Service Bus / Event Grid | SNS + SQS | Pub/Sub |
| Container Registry (ACR) | ECR | Artifact Registry |
| Azure Monitor Logs | CloudWatch Logs | Cloud Logging |
| Key Vault | Secrets Manager | Secret Manager |
| Entra ID + RBAC | IAM | IAM |

---

# Azure CLI

官方安装文档：https://learn.microsoft.com/zh-cn/cli/azure/install-azure-cli

## 安装（Debian / Ubuntu）

### 这里使用Azure CLI团队维护的脚本一次性安装

```bash
curl -fsSL 'https://azurecliprod.blob.core.windows.net/$root/deb_install.sh' | sudo bash
```

### 安装后确认

```bash
az version
```

## 登录

> WSL 里没浏览器，`--use-device-code` 会给你一个 URL 和一个设备码，在 Windows 浏览器里打开 URL 输入码完成授权。

```bash
az login --use-device-code
```

## 认证与配置确认

确认当前登录账号与订阅：

```bash
az account show
```

检查 CLI 配置：

```bash
az configure --list-defaults
```

## 订阅操作

查看能访问哪些订阅：

```bash
az account list --output table
```

设定默认订阅：

```bash
az account set --subscription "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

设定默认资源组（后续命令可省略 `-g`）：

```bash
az configure --defaults group=xxx-rg
```

## 资源查看

查看该订阅下所有资源组：

```bash
az group list --output table
```

查看该订阅下所有虚拟机：

```bash
az vm list --output table
```

查看该订阅下所有 Container Apps：

```bash
az containerapp list --output table
```

查看该订阅下所有 Container Apps Jobs：

```bash
az containerapp job list --output table
```

查看该订阅下所有 App Service（Web 应用）：

```bash
az webapp list --output table
```

查看某个资源组下的全部资源：

```bash
az resource list --resource-group xxx-rg --output table
```

> `az containerapp` 属于扩展命令，首次执行时 CLI 会提示自动安装扩展；也可以手动装：
> ```bash
> az extension add --name containerapp
> ```
