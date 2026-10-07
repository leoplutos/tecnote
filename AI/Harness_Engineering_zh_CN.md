# Prompt Engineering、Context Engineering、Harness Engineering 的区别

| 概念 | 关注对象 | 核心问题 | 类比 |
|--------|--------|--------|--------|
| Prompt Engineering | 提示词 | 怎么问 AI | 写问题的人 |
| Context Engineering | 上下文 | 给 AI 什么信息 | 给 AI 准备资料的人 |
| Harness Engineering | AI系统框架 | 如何让 AI 稳定工作 | 搭建生产线的人 |

## 1. Prompt Engineering（提示工程）

最早流行的概念。

目标：通过优化 Prompt，让 LLM 输出更好的结果。

例如：

普通 Prompt：

```text
帮我写一个登录功能
```

优化后：

```text
你是一名资深Java开发工程师。

请使用：
- Java 17
- Spring Boot 4
- JPA

实现登录功能。

要求：
1. JWT认证
2. 密码BCrypt加密
3. REST API设计
4. 返回完整代码
```

主要研究：
- Role（角色）
- Task（任务）
- Constraints（约束）
- Examples（Few-shot）
- Output Format（输出格式）

---

## 2. Context Engineering（上下文工程）

2025年以来越来越热门。

很多人发现：

> Prompt不是最重要的，Context才是最重要的。

因为：

```text
Answer = f(Context)
```

例如：

用户问：

```text
这个BUG怎么修？
```

AI并不知道：

- 项目是什么
- 技术栈是什么
- 哪段代码有问题

需要提供 Context：

```text
项目：Spring Boot 4 + GraphQL

相关代码：...
错误日志：...
数据库结构：...
```

主要内容：

### RAG

```text
Vector DB
↓
Top K Documents
↓
LLM
```

### Memory

长期记忆，例如：

```text
用户使用Java17
用户会日语
用户是开发工程师
```

### Tool Result

```text
Google Search
Database Query
API Response
```

核心：

> 如何把最有价值的信息放进有限的上下文窗口。

---

## 3. Harness Engineering（编排工程）

Agent时代的新概念。

Prompt 和 Context 解决的是一次调用 LLM。

Harness Engineering 解决的是：

```text
多个LLM
多个工具
多个步骤
```

如何协同工作。

例如：

```text
Step1 Google Search
↓
Step2 抓网页
↓
Step3 LLM总结
↓
Step4 生成PPT
↓
Step5 发送邮件
```

主要内容：

- Workflow
- Agent
- Tool Calling
- State Management

典型框架：

- LangChain
- LangGraph
- LlamaIndex
- OpenAI Agents SDK
- CrewAI

---

## 三者关系

```text
┌───────────────────────┐
│ Harness Engineering   │
│ Agent / Workflow      │
└──────────┬────────────┘
           │
┌──────────▼────────────┐
│ Context Engineering   │
│ Memory / RAG / Tools  │
└──────────┬────────────┘
           │
┌──────────▼────────────┐
│ Prompt Engineering    │
│ Instructions          │
└───────────────────────┘
```

实际项目中：

```text
Prompt Engineering
    ↓
Context Engineering
    ↓
Harness Engineering
```

很多团队目前的经验是：

```text
Harness > Context > Prompt
```

Prompt 优化往往只能带来有限提升，而优秀的 RAG、Memory 和 Agent Workflow 往往能够带来数量级的效果提升。

**一句话总结：**

> Prompt Engineering 是入门，Context Engineering 是核心，Harness Engineering 是真正的 AI 应用工程。

# Claude Code 项目 Harness Engineering 实战示例

## 项目背景

项目名称：MiniFlake

技术栈：

- Frontend: React + Vite
- Backend: Spring Boot
- Database: PostgreSQL

功能范围：

- 用户登录
- 商品管理（CRUD）
- 订单管理（CRUD）

---

## 推荐目录结构

```text
project/
├── CLAUDE.md                   # 项目级长期上下文/记忆（Claude Code 自动加载）
├── .claude/
│   ├── agents/                 # 子代理(subagent)，每个 agent 一个 .md 文件（进 git）
│   │   ├── architect.md
│   │   ├── developer.md
│   │   ├── tester.md
│   │   └── reviewer.md
│   └── skills/                 # 技能(skill)目录
│       └── pr-review/
│           └── SKILL.md
├── docs/
│   ├── 01_vision.md
│   ├── 02_requirement.md
│   ├── 03_architecture.md
│   ├── 04_api_design.md
│   ├── 05_db_design.md
│   ├── 06_task_breakdown.md
│   ├── 07_test_plan.md
│   ├── progress.md             # 进度看板（只存总表 / 索引）
│   └── tasks/                  # 一个 Task 一个文件（详情）
│       ├── BE-003.md
│       ├── BE-004.md
│       └── FE-001.md
├── frontend/
└── backend/
```

> 注意：Claude Code 的子代理放在 `.claude/agents/` 目录下（项目级），
> 用户级则在 `~/.claude/agents/`。每个文件需要 YAML frontmatter
> （`name`、`description`，可选 `tools`），不是纯文本。

---

## 第一阶段：Vision（愿景）

先让 Claude 生成项目目标文档。

示例 Prompt：

```text
请生成 docs/01_vision.md

项目:
商品订单管理系统

目标用户:
企业内部运营人员

MVP:
登录
商品CRUD
订单CRUD

非目标:
支付
物流
库存预测
```

---

## 第二阶段：Requirement（需求）

先写需求，不直接写代码。

示例 Prompt：

```text
请根据vision生成
docs/02_requirement.md

要求：

用户故事方式描述

每个功能定义：

前置条件
主流程
异常流程
验收标准
```

输出示例：

```markdown
US-001 登录

As User

I want login

So that use system

Acceptance Criteria

- 用户名密码正确
- JWT生成
- Token过期
```
---

## 第三阶段：Architecture（架构设计）

让 Claude 输出架构设计。

示例 Prompt：

```text
根据Requirement生成

docs/03_architecture.md

技术栈：

Frontend
React

Backend
Spring Boot

DB
PostgreSQL

要求：

系统架构图

模块划分

部署结构

ER图
```
---

## 第四阶段：API Design（接口设计）

先定义所有接口。

示例：

```yaml
POST /api/login

Request

{
  username
  password
}

Response

{
  token
}
```

生成：

```text
docs/04_api_design.md
```

---

## 第五阶段：DB Design（数据库设计）

生成：

```text
docs/05_db_design.md
```

示例：

```sql
users

id
username
password_hash

products

id
name
price

orders

id
user_id
status
```
---

## 第六阶段：Task Breakdown（任务拆分）

拆分为可执行任务。

示例：

```markdown
BE-001

创建SpringBoot工程

---

BE-002

创建User实体

---

BE-003

实现JWT认证

---

BE-004

实现登录接口
```

最终形成：

```text
docs/06_task_breakdown.md
```

---

## 第七阶段：让 Claude 按 Task 开发

不要让 AI 一次实现整个系统。

示例：

```text
使用Subagent developer 来完成

BE-003

实现JWT认证

要求：

完成后更新
docs/tasks/BE-003.md
并在 docs/progress.md 总表里更新状态

记录：

- Task
- 状态（Done / WIP / Todo）
- 负责Agent
- 详情
```

### progress.md（只存索引，不存日志）

```markdown
# 进度看板

| Task   | 状态     | 负责Agent | 详情                      |
|--------|----------|-----------|---------------------------|
| BE-003 | ✅ Done   | developer | docs/tasks/BE-003.md      |
| BE-004 | 🔄 WIP    | developer | docs/tasks/BE-004.md      |
| FE-001 | ⬜ Todo   | -         | -                         |
```

### docs/tasks/BE-003.md（单个 Task 的详情）

```markdown
# BE-003 实现JWT认证

状态: Done
负责: developer

## 修改文件
- src/.../JwtService.java

## 测试结果
- JwtServiceTest 全绿，覆盖率 85%

## 风险 / 遗留
- secret 暂用配置文件，待接入环境变量
```

### 要点

- 接棒的 Agent 只读"索引表 + 当前这一个 Task 的详情"，上下文极小。
- **一 Task 一文件**：改 BE-003 不碰别人的文件，并行无冲突，git 历史清晰。
- **只留结论，不留流水账**：Agent 干活过程中的碎碎念不要长期留存，
  完成后压缩成 3–5 行结论写回详情文件——这正是 Context Engineering 的核心。
- **Done 的 Task 定期归档**到 `docs/tasks/_archive/`，看板永远只显示进行中 + 待办。
- **不要把 progress.md 写进 CLAUDE.md**：CLAUDE.md 每次会话全量加载，progress 是按需读，
  两者要分开。

---

## 第八阶段：Test Harness（测试框架）

建立测试目录：

```text
tests/

frontend/

backend/
```

示例 Prompt：

```text
使用Subagent tester 根据 API Design 生成

JUnit Test

覆盖率目标80%
```

生成测试代码，例如：

```java
LoginControllerTest
```

---

## 第九阶段：Review Agent（代码审查代理）

使用独立 Agent 进行代码审查。

示例 Prompt：

```text
使用Subagent reviewer 审查安全性

检查：

安全性
SQL注入
事务
异常处理
性能
可维护性
```

输出：

```markdown
Review Report

Issue-001

JWT Secret硬编码

Severity High
```

---

## Claude Code Harness 核心组件

### CLAUDE.md

项目根目录的 `CLAUDE.md` 会被 Claude Code 自动读入上下文，
用来沉淀项目级的长期记忆（技术栈、约定、命令、注意事项）。
这是 Claude Code Harness 中最核心的上下文来源。

```markdown
# 项目：MiniFlake

技术栈：React + Vite / Spring Boot / PostgreSQL

约定：
- 数据库表名小写下划线
- 接口统一返回 { code, data, message }

常用命令：
- 后端测试：./mvnw test
- 前端启动：pnpm dev
```

### Subagent

#### 什么是 Subagent

传统 AI：
```text
用户
 ↓
AI
 ↓
结果
```
只有一个 `Agent` 负责所有事情。

Subagent 架构：
```text
用户
 ↓
主Agent（Orchestrator）
 ↓
 ├─ 前端开发Agent
 ├─ 后端开发Agent
 ├─ 测试Agent
 ├─ 文档Agent
 └─ 运维Agent
 ↓
汇总结果
```
主 `Agent` 不亲自干活，而是：

- 分析任务
- 拆解任务
- 分配任务
- 汇总结果

具体工作由 `Subagent` 完成。

> 最佳实践：通过 `tools` 字段为每个角色**收紧权限**，让职责边界由工具权限强制，
> 而不只靠 prompt 里写"禁止 XXX"。例如 architect 只读不写代码、reviewer 只读不改。

下面是 `Subagent` 的示例

#### .claude/agents/architect.md

```markdown
---
name: architect
description: 系统架构师。在需要系统设计、架构图、模块划分时使用。禁止直接写代码。
tools: Read, Grep, Glob, Write   # 只读代码 + 写 docs，不给 Edit/Bash
---
你是系统架构师

禁止直接写代码

优先输出设计文档
```

#### .claude/agents/developer.md

```markdown
---
name: developer
description: 高级工程师。只实现指定 Task。
tools: Read, Edit, Write, Bash, Grep, Glob   # 编码角色，给全套
---
你是高级工程师

只实现指定Task

禁止修改未授权模块

完成后更新 docs/tasks/目录下相关的task文件，并在 docs/progress.md 总表里更新状态
```

#### .claude/agents/tester.md

```markdown
---
name: tester
description: 自动化测试专家。
tools: Read, Edit, Write, Bash, Grep, Glob
---
生成自动化测试

测试的结果要存留，比如HTML报表

完成后更新 docs/tasks/目录下相关的task文件，并在 docs/progress.md 总表里更新状态

覆盖率80%以上
```

#### .claude/agents/reviewer.md

```markdown
---
name: reviewer
description: 代码审查专家。检查安全/性能/可维护性。
tools: Read, Grep, Glob, Bash   # 只读 + 跑测试，不给 Edit，避免自己改自己批
---
审查代码质量

发现问题输出Issue（只读，不修改代码与文档；由主 Agent 或 developer 回写 progress）
```

#### Subagent 目录结构最佳实践

```text
项目级（随项目走，进 git，团队共享）：
.claude/agents/
├── architect.md
├── developer.md
├── tester.md
└── reviewer.md

用户级（跨项目通用，放在 home 目录，不进项目 git）：
~/.claude/agents/
├── commit-helper.md
└── doc-writer.md
```

#### 要点：

- **扁平存放**：`.claude/agents/` 下直接平铺 `.md` 文件即可。Claude Code 不会递归扫描子目录做分类，建子文件夹分组并不会被识别，靠文件名本身区分即可。
- **同名时项目级覆盖用户级**：两处有同名 agent 时，项目级 `.claude/agents/` 优先。可以把通用角色放用户级，项目特有角色放项目级。
- **一个文件一个职责，名字即语义**：文件名 = `name` 字段（小写中划线），如 `code-reviewer.md`，便于显式调用和自动委派检索。
- **`description` 决定自动委派命中率**：写清"做什么 + 何时用"，加上"主动调用 / 完成编码后使用"这类措辞。
- **`tools` 按最小权限给**：审查/设计类只读，编码类给写，从机制上锁死边界（见上）。
- **项目级 agent 进 git**：作为 Harness 的一部分随仓库版本化，团队成员开箱即用。

#### Subagent 最佳实践

以 `项目经理` 的身份在主聊天窗口  
假设 `.claude/agents/` 下已经放好了 `developer / tester / reviewer` 三个 agent。

直接说下面的内容即可在一条消息里把整条流水线交代清楚，让主 Agent 当 `班长` 逐棒调度
```text
按以下顺序推进 BE-003：
1. 使用Subagent developer 实现 JWT 认证，参考 docs/04_api_design.md
2. 使用Subagent tester 为它补单元测试，覆盖率高于 80%
3. 使用Subagent reviewer 审查安全性，发现问题输出 Issue 列表
每一步完成后更新 docs/tasks/BE-003.md，并在 docs/progress.md 总表里更新状态，最后把三步的结论汇总给我。
```

#### 关键心智模型
- 你始终只跟主 Agent 对话，它是你的 `项目对接人/班长`。
- `Subagent` 不直接跟你聊，它们是主 Claude 临时雇来干一段活的 `专家`，干完汇报就解散。
- `Subagent` 之间不共享对话历史，靠文件（代码、`docs/progress.md`）传递状态——所以文档里 `完成后更新 progress.md` 的设计很重要，那是它们交接的接口。
- 隔离上下文 = 审查/测试不会被编码时的 `思维包袱` 污染，结论更干净客观。

---

## 核心思想

```text
文档驱动开发（Document Driven Development）
       +
任务驱动开发（Task Driven Development）
       +
多Agent角色分工
       +
自动测试
       +
自动Review
```

不要采用：

```text
Prompt
↓
Claude
↓
代码
```

而应采用：

```text
需求
↓
设计
↓
任务拆分
↓
编码
↓
测试
↓
Review
↓
部署
```

Claude Code 更适合作为一个开发团队成员，而 Harness Engineering 的目标是建立一套稳定、高质量、可持续的软件开发机制。

