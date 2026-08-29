# 数据库版本迁移（Database Migration）工具简介

数据库版本迁移（Database Migration）工具用于管理数据库 Schema（表、字段、索引等）的版本变化。

随着项目开发，数据库结构会不断调整，例如：

- 创建或删除表
- 新增、修改或删除字段
- 创建索引
- 修改字段类型或约束

Migration 工具会将这些变化记录为一个个迁移版本，并按照顺序执行，使开发、测试和生产环境的数据库结构保持一致。

可以简单理解为：

> **Git 管理代码版本，Migration 工具管理数据库 Schema 版本。**

## 1. 常见语言与推荐工具

不同语言和技术生态通常都有对应的数据库版本迁移工具。它们的实现方式不同，但核心目标都是让数据库结构变化可追踪、可重复执行，并在不同环境中保持一致。

| 语言 / 生态 | ORM / 数据库工具 | 推荐 Migration 工具 | 简介 |
| --- | --- | --- | --- |
| Python | SQLAlchemy | Alembic | SQLAlchemy 生态中常用的数据库迁移工具，支持基于模型变化生成 Migration。 |
| Java | MyBatis-Plus / jOOQ | Flyway | Java 项目中常见的 SQL-first 迁移方案，通过版本化 SQL 文件管理数据库结构变化。 |
| Node.js | Prisma ORM | Prisma Migrate | Prisma 官方迁移工具，可根据 Prisma Schema 的变化生成并管理数据库 Migration。 |
| Rust | SQLx | sqlx migrate | SQLx 配套的 SQL-first Migration 方案，通过 SQL 文件显式管理数据库版本。 |
| C# / .NET | Entity Framework Core | EF Core Migrations | EF Core 官方迁移机制，可根据实体模型变化生成 Migration 并更新数据库。 |
| Go | sqlc / database/sql | golang-migrate | Go 生态中常见的 SQL-first Migration 工具，使用版本化 SQL 文件执行升级和回滚。 |

## 2. 基本工作流程

数据库版本迁移通常遵循以下流程：

```text
修改数据库模型 / Schema
        ↓
创建 Migration
        ↓
检查 Migration
        ↓
执行 Migration
        ↓
数据库升级到新版本
```

不同语言和工具的实现方式有所区别，但核心目标相同：

> **安全、可追踪地管理数据库结构的演进。**

## 3. Flyway 使用流程示例

Flyway 是 Java 生态中常见的数据库版本迁移工具，采用 **SQL-first** 的方式管理数据库 Schema 的演进。

下面以 **Java / Spring Boot + PostgreSQL** 为例说明一个完整的使用流程。

### 3.1 引入 Flyway

Spring Boot 项目通常**不需要单独安装 Flyway CLI**，可以直接通过项目依赖集成 Flyway。

Maven 添加依赖：

```xml
<dependency>
    <groupId>org.flywaydb</groupId>
    <artifactId>flyway-core</artifactId>
</dependency>
```

### 3.2 创建 Migration 文件

Spring Boot 项目的 Migration 默认一般放在：

```text
src/main/resources/
└── db/
    └── migration/
        ├── V1__init.sql
        ├── V2__add_user.sql
        └── V3__add_index.sql
```

Flyway 常见的版本 Migration 命名格式：

```text
V<版本号>__<说明>.sql
```

例如：

```text
V1__init.sql
V2__add_user.sql
V3__add_index.sql
```

版本号和说明之间使用两个下划线 `__`。

### 3.3 编写第一个 Migration

例如创建 `users` 表：

`V1__init.sql`：

```sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
```

之后如果需要增加 `email` 字段，不要修改已经执行过的 `V1__init.sql`，而是创建新的 Migration：

`V2__add_user_email.sql`：

```sql
ALTER TABLE users
ADD COLUMN email VARCHAR(255);
```

Migration 会随着数据库结构变化持续增加：

```text
V1__init.sql
        ↓
V2__add_user_email.sql
        ↓
V3__add_index.sql
        ↓
...
```

### 3.4 配置 Spring Boot

例如 PostgreSQL：

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/mydb
    username: postgres
    password: 123456

  flyway:
    enabled: true
    locations: classpath:db/migration
```

配置完成后，Spring Boot 启动时 Flyway 会检查数据库的 Migration 状态，并执行尚未应用的 Migration。

例如：

```text
项目中的 Migration

V1 → V2 → V3

数据库当前版本

V1
```

应用启动后，Flyway 会依次执行：

```text
V2
 ↓
V3
```

最终数据库升级到最新版本。

Flyway 会在数据库中维护 Schema History 表，用于记录已经执行过的 Migration。

### 3.5 执行方式

Spring Boot 项目可以直接在**应用启动时自动执行 Migration**：

```text
Spring Boot 启动
        ↓
Flyway 初始化
        ↓
读取 db/migration
        ↓
检查 Schema History
        ↓
找到尚未执行的 Migration
        ↓
按照版本顺序执行
        ↓
更新 Schema History
        ↓
应用继续启动
```

如果不希望 Migration 和应用启动绑定，也可以通过 **Maven、Gradle 或 Flyway CLI** 在 CI/CD 阶段单独执行。

### 3.6 日常常用命令

使用 Flyway CLI 时，常见命令包括：

```bash
# 查看 Migration 状态
flyway info

# 执行尚未执行的 Migration
flyway migrate

# 检查 Migration 是否有效
flyway validate

# 修复 Schema History 中的部分记录
flyway repair
```

其中最常用的是：

```bash
flyway migrate
```

它的作用可以理解为：

> 检查数据库当前版本，并依次执行所有尚未执行的 Migration。

### 3.7 实际开发与部署流程

一个常见的开发流程：

```text
修改数据库 Schema
        ↓
创建新的 SQL Migration
例如：V2__add_user_email.sql
        ↓
本地启动应用 / 执行 Flyway
        ↓
验证 Migration
        ↓
提交代码和 Migration 到 Git
        ↓
部署到测试 / 生产环境
        ↓
执行 Migration
        ↓
Flyway 检查 Schema History
        ↓
执行尚未执行的 Migration
        ↓
记录新的 Migration History
        ↓
数据库升级完成
```

### 3.8 核心原则

已经执行并发布过的 Migration 通常不应该再修改。

例如已经存在：

```text
V1__init.sql
V2__add_user_email.sql
```

之后需要给 `users` 表增加 `status` 字段，应创建：

```text
V3__add_user_status.sql
```

而不是回头修改：

```text
V1__init.sql
```

这样每一次数据库结构变化都有明确的版本记录，不同环境也可以按照相同顺序完成数据库升级。
