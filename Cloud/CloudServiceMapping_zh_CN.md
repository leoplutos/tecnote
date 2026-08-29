# 三大云平台服务对应关系

| 功能 | AWS | GCP | Azure | 说明 |
|------|------|------|------|------|
| DNS | Route 53 | Cloud DNS | Azure DNS | 域名解析 |
| CDN | CloudFront | Cloud CDN | Azure Front Door (CDN) | 全球内容分发 |
| WAF | AWS WAF | Cloud Armor | Azure WAF | Web 防火墙 |
| Load Balancer | Application Load Balancer (ALB) | Application Load Balancer | Azure Application Gateway | 七层负载均衡 |
| 自动扩缩容 | Auto Scaling Group | Managed Instance Group (MIG) Autoscaling | Virtual Machine Scale Sets (VMSS) | VM 自动扩缩容 |
| 定时任务 | EventBridge Scheduler | Cloud Scheduler | Logic Apps / Azure Functions Timer Trigger | Cron 调度 |
| 容器（Serverless） | ECS on Fargate | Cloud Run | Azure Container Apps | 不需要管理服务器 |
| Kubernetes | EKS | GKE | AKS | 托管 Kubernetes |
| 虚拟机 | EC2 | Compute Engine | Azure Virtual Machines | IaaS |
| VPC | VPC | VPC | Virtual Network (VNet) | 私有网络 |
| 子网 | Subnet | Subnet | Subnet | 基本一致 |
| Internet Gateway | Internet Gateway | Cloud NAT + Default Internet Gateway | Internet Gateway（隐式） | 出入口 |
| NAT | NAT Gateway | Cloud NAT | NAT Gateway | 私网访问公网 |
| 对象存储 | S3 | Cloud Storage (GCS) | Blob Storage | 文件存储 |
| 块存储 | EBS | Persistent Disk | Managed Disk | 云硬盘 |
| 文件存储 | EFS | Filestore | Azure Files | NAS |
| 关系数据库 | RDS | Cloud SQL | Azure Database | MySQL/Postgres 等 |
| 高性能数据库 | Aurora | AlloyDB / Cloud SQL HA | Azure Database Hyperscale | 云原生数据库 |
| NoSQL | DynamoDB | Firestore / Bigtable | Cosmos DB | NoSQL |
| 消息队列 | SQS | Pub/Sub | Azure Service Bus | Queue |
| 发布订阅 | SNS | Pub/Sub | Event Grid | Pub/Sub |
| 邮件发送 | SES | 无官方对应（通常用 SendGrid） | Azure Communication Services Email | 邮件服务 |
| Serverless | Lambda | Cloud Functions | Azure Functions | 无服务器计算 |
| 应用托管 | Amplify Hosting | Firebase Hosting / App Hosting | Azure Static Web Apps | 前端托管 |
| 监控 | CloudWatch | Cloud Monitoring | Azure Monitor | Metrics |
| 日志 | CloudWatch Logs | Cloud Logging | Log Analytics | Logs |
| 告警 | CloudWatch Alarm | Alerting | Azure Alerts | 告警 |
| IAM | IAM | Cloud IAM | Microsoft Entra ID + Azure RBAC | 权限管理 |
| Secrets | Secrets Manager | Secret Manager | Key Vault | 密钥管理 |
| 参数配置 | Systems Manager Parameter Store | Secret Manager / Runtime Config（已逐步淡出） | App Configuration | 配置管理 |


