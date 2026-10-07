# Cloudflare

Cloudflare 起家于 CDN / DNS / 安全防护，如今在此之上长出了一整套「开发者平台」（Workers 生态）。它和 AWS、GCP、Azure 属于同一类平台，但底子完全不同：**没有虚拟机，也没有「选哪个区域」这件事**——代码和数据直接跑在遍布全球的边缘节点上。

## 资源层级

Cloudflare 的层级只有两层半，而且是「一个账户，两条腿」：

```
Account（账户）
  ├─ Zone（站点 = 一个域名）
  │    └─ DNS 记录 / 缓存规则 / WAF / 证书 / 重定向 …
  └─ 开发者平台资源
       └─ Workers / Pages / R2 / D1 / KV / Queues …
```

**Account 是计费与权限的边界**，对应 GCP 的 Project、Azure 的 Subscription。

**Zone 是「一个域名」**，只有把域名托管到 Cloudflare 才会有 Zone。CDN、DNS、WAF 这些传统业务都以 Zone 为单位配置。

需要特别注意的是：**开发者平台的资源挂在 Account 下，和 Zone 是平级关系，不属于任何 Zone**。一个 Worker 不绑定域名也能跑（走 `*.workers.dev` 子域），绑域名时才和某个 Zone 产生关联。

> 和另外三家的差异：
> - **没有 Region**。GCP 要选 `asia-northeast1`、Azure 要选 `japaneast`，Cloudflare 不用选——部署一次即全球生效。数据类服务（R2 / D1）可以指定「位置提示」，但那只是提示。
> - **没有 Resource Group 这层**。资源直接躺在 Account 下，靠命名和项目配置文件（`wrangler.jsonc`）来组织。
> - **权限模型偏简单**。不是 GCP/Azure 那种细到每个资源的 IAM，而是「账户成员角色」+「API Token（可限定权限范围与生效的 Zone）」。

## 免费额度

Cloudflare 最值得一提的是它的免费额度，尤其是 **Workers 和 Pages**，慷慨到初创团队可以几乎零成本把产品跑起来：

- **Workers**：每天 10 万次请求，Worker 数量不限
- **Pages**：带宽和请求数不限量
- **R2**：10 GB 存储，且**出网流量完全免费**（S3 上最贵的一块，这里是零）
- D1、KV、Queues、Workers AI 也各带一份日额度

而且 **Free 计划超额不会产生账单，只会被拒绝服务**——顶多跑不动，不会半夜被账单叫醒。往上走 Workers Paid 是 **$5/月**起，按账户算而不是按项目。

具体数字会变，用之前对一下官方页面：

- 开发者平台：https://developers.cloudflare.com/workers/platform/pricing/
- Zone 侧（CDN / DNS / WAF）计划对比：https://www.cloudflare.com/plans/

## 常用服务

| 分类 | 服务 | 说明 |
|---|---|---|
| **计算** | Workers | 边缘 Serverless，请求级计费、冷启动近乎为零 |
| **计算** | Cron Triggers | Worker 的定时触发，跑完即退出的批处理 |
| **计算** | Workers Static Assets / Pages | 静态站点与前端托管（Pages 为早期产品，新项目官方推荐 Workers） |
| **计算** | Durable Objects | 带状态的单实例对象，用来做协调、房间、计数器、WebSocket 长连接 |
| **计算** | Workflows | 长时间运行、可重试、可持久化的多步骤任务编排 |
| **计算** | Containers | 在边缘跑容器，补上 Workers 跑不了的场景（较新） |
| **存储** | R2 | 对象存储，S3 API 兼容，**出网流量免费**是它最大的卖点 |
| **存储** | Workers KV | 全球分发的键值存储，最终一致，适合读多写少的配置/缓存 |
| **数据库** | D1 | 托管 SQLite，适合中小规模关系型数据 |
| **数据库** | Hyperdrive | 给外部 PostgreSQL / MySQL 加连接池与缓存，解决边缘连数据库慢的问题 |
| **数据库** | Vectorize | 向量数据库，配合 Workers AI 做 RAG |
| **网络** | CDN / DNS / Load Balancing | 老本行：缓存加速、权威 DNS、负载均衡 |
| **消息** | Queues | 消息队列，Worker 生产、Worker 消费 |
| **安全** | WAF / DDoS Protection / Bot Management | Web 应用防火墙、DDoS 防护、爬虫识别 |
| **安全** | Turnstile | 人机验证，reCAPTCHA 的替代品 |
| **安全** | SSL/TLS | 证书签发与管理（默认免费） |
| **Zero Trust** | Access / Gateway / Tunnel / WARP | 零信任接入；Tunnel（`cloudflared`）可把内网服务安全暴露出来，不用开公网端口 |
| **AI** | Workers AI | 在边缘跑开源模型，按调用计费 |
| **AI** | AI Gateway | 各家 LLM API 的统一入口，带缓存、限流、日志 |
| **媒体** | Images / Stream | 图片处理分发、视频转码与播放 |
| **权限** | API Token / 账户成员角色 | 权限管理 |
| **运维** | Logpush / Analytics / `wrangler tail` | 日志投递、流量分析、实时日志 |
| **安全** | Workers Secrets / Secrets Store | 密钥、凭据管理 |

## 与 AWS / GCP / Azure 的术语对照

| Cloudflare | AWS | GCP | Azure |
|---|---|---|---|
| Account | Account | Project | Subscription |
| Zone | Route 53 Hosted Zone | Cloud DNS Zone | DNS Zone |
| （无对应） | EC2 | Compute Engine | Virtual Machines |
| Workers | Lambda@Edge / Lambda | Cloud Functions / Cloud Run | Azure Functions |
| Cron Triggers | EventBridge + Lambda | Cloud Run Jobs | Container Apps Jobs |
| Pages / Static Assets | Amplify / S3 静态站点 | Firebase Hosting | Static Web Apps |
| Durable Objects | （无直接对应） | （无直接对应） | Durable Entities |
| R2 | S3 | Cloud Storage | Blob Storage |
| Workers KV | DynamoDB（简化版） | Firestore（简化版） | Cosmos DB（简化版） |
| D1 | Aurora Serverless | Cloud SQL | Azure SQL Database |
| Queues | SQS | Pub/Sub | Service Bus |
| CDN | CloudFront | Cloud CDN | Azure Front Door / CDN |
| WAF | AWS WAF | Cloud Armor | Azure WAF |
| Zero Trust Access | （无直接对应） | BeyondCorp / IAP | Entra ID 应用代理 |
| API Token | IAM | IAM | Entra ID + RBAC |
| Logpush | CloudWatch Logs | Cloud Logging | Azure Monitor Logs |
| Workers Secrets | Secrets Manager | Secret Manager | Key Vault |

---

# Wrangler CLI

官方安装文档：https://developers.cloudflare.com/workers/wrangler/install-and-update/

> 和 `gcloud` / `az` 不同，Wrangler **不是覆盖全平台的管理工具**，它只管开发者平台那条腿（Workers / R2 / D1 / KV / Queues …）。DNS、WAF、缓存规则这些 Zone 侧的东西，得走 Dashboard 或 REST API，见文末。

## 安装

Wrangler 是一个 npm 包，前提是有 **Node.js 20 及以上**。

### 全局安装

```bash
npm install -g wrangler
```

### 或者不装，直接用（推荐，版本跟着项目走）

```bash
npx wrangler --help
```

### 安装后确认

```bash
wrangler --version
```

## 登录

> WSL 里没浏览器，`wrangler login` 会打印一个 URL，复制到 Windows 浏览器完成 OAuth 授权即可。

```bash
wrangler login
```

**CI / 服务器等无法交互的场景**，改用 API Token（在 Dashboard → My Profile → API Tokens 创建）：

```bash
export CLOUDFLARE_API_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

## 认证与配置确认

确认当前登录身份、以及能访问哪些账户：

```bash
wrangler whoami
```

## 账户操作

Cloudflare 没有 `set account` 这类命令。当账号下有多个 Account 时，用环境变量指定：

```bash
export CLOUDFLARE_ACCOUNT_ID=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

也可以写进项目根目录的 `wrangler.jsonc`：

```jsonc
{
  "name": "my-worker",
  "main": "src/index.ts",
  "compatibility_date": "2026-08-01",
  "account_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

## 资源查看

查看当前 Worker 的部署历史：

```bash
wrangler deployments list
```

查看该账户下所有 R2 存储桶：

```bash
wrangler r2 bucket list
```

查看该账户下所有 D1 数据库：

```bash
wrangler d1 list
```

查看该账户下所有 KV 命名空间：

```bash
wrangler kv namespace list
```

查看该账户下所有 Queues：

```bash
wrangler queues list
```

查看该账户下所有 Pages 项目：

```bash
wrangler pages project list
```

查看当前 Worker 配置了哪些 Secret（只显示名字，不显示值）：

```bash
wrangler secret list
```

实时追踪某个 Worker 的线上日志：

```bash
wrangler tail my-worker
```

> 注意：**Wrangler 没有「列出账户下全部 Worker」的命令**。它是以「当前项目」为中心设计的，绝大多数命令要在含 `wrangler.jsonc` 的目录里执行。想拿全量清单只能走 API：
> ```bash
> curl -s -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
>   "https://api.cloudflare.com/client/v4/accounts/$CLOUDFLARE_ACCOUNT_ID/workers/scripts" \
>   | jq -r '.result[].id'
> ```

## Zone 侧的操作

DNS、WAF、缓存等 Zone 相关配置，Wrangler 管不了，用 REST API：

查看账户下所有 Zone（域名）：

```bash
curl -s -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  "https://api.cloudflare.com/client/v4/zones" \
  | jq -r '.result[] | "\(.id)  \(.name)  \(.status)"'
```

查看某个 Zone 的 DNS 记录：

```bash
curl -s -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  "https://api.cloudflare.com/client/v4/zones/<ZONE_ID>/dns_records" \
  | jq -r '.result[] | "\(.type)\t\(.name)\t\(.content)"'
```

API 文档：https://developers.cloudflare.com/api/
