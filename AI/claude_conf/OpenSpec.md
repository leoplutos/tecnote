# OpenSpec 驱动开发工作流

本文档记录环境搭建、生命周期与本项目约定的 task 实现流水线。

---

## OpenSpec

Spec-driven development (SDD) for AI coding assistants.

https://github.com/Fission-AI/openspec


## 1. 安装 OpenSpec CLI

```bash
npm install -g @fission-ai/openspec@latest
```

## 2. 初始化项目

```bash
cd your-project
openspec init
```

---

## 3. OpenSpec全生命周期

```
 /opsx:explore   →   /opsx:propose   →   /opsx:apply   →   /opsx:sync   →   /opsx:archive
   探索(现在)          生成artifacts        按tasks实现       同步spec        归档
      │                   │                    │               │              │
   想清楚              proposal.md          写代码          delta→主spec    change入库
                       design.md            勾选task                       specs/固化
                       specs/*.md
                       tasks.md
```

| 阶段 | 命令 | 做什么 |
|------|------|--------|
| 探索 | `/opsx:explore` | 想清楚要做什么(思考,不写代码) |
| 提议 | `/opsx:propose` | 生成 proposal / design / specs / tasks |
| 实现 | `/opsx:apply` | 按 tasks 逐条实现并勾选 |
| 同步 | `/opsx:sync` | delta spec 并入主 specs |
| 归档 | `/opsx:archive` | change 入库,specs 固化 |

---

## 4. task 实现流水线(本项目约定)

`/opsx:apply` 逐条处理 `tasks.md`,把每条的"实现"替换成下面的多 agent 流水线:

```
对 tasks.md 里每个 task (如 AUTH-001):
  ┌─────────────────────────────────────────────────────┐
  │ 1. subagent developer  → 实现                         │
  │ 2. subagent tester     → 补单测,覆盖率>80%            │
  │ 3. subagent reviewer   → 审安全,输出 Issue 列表        │
  │ 每步完成 → 更新 tasks_progress.md + tasks/AUTH-001.md │
  └─────────────────────────────────────────────────────┘
              ↓ 三步全过
  在 tasks.md 里把 [ ] AUTH-001 → [x]   ← CLI 进度随之 +1 ✅
              ↓
  汇总三步结论给你
```

### 示例

```
按以下顺序推进 CORE-001：
1. 使用subagent developer 实现
2. 使用subagent tester 为它补单元测试，覆盖率高于 80%
3. 使用subagent reviewer 审查代码，包括安全性，性能等等，发现问题输出 Issue 列表
每步完成 → 更新 tasks.md + tasks_progress.md + tasks/CORE-001.md
最后把三步的结论汇总给我。
```

### 目录约定(折中方案:CLI 可见 + 自定义 task 结构)

```
openspec/changes/<name>/
├── proposal.md            ← CLI 认
├── design.md              ← CLI 认
├── specs/
│   ├── auth/spec.md        ← CLI 认,可 validate/sync
│   └── todos/spec.md
├── tasks.md               ← CLI 认,进度真相源([x]/[ ])
├── tasks_progress.md      ← CLI 无视,细粒度状态汇总
└── tasks/                 ← CLI 无视,每-task 实现详情
    ├── AUTH-001.md         (developer / tester / reviewer 三段结果)
    └── TODO-001.md ...
```

- task 前缀按 capability 分:`AUTH-001`、`TODO-001` …
- `tasks.md` 每行链到对应的 `tasks/<ID>.md` 详情文件。
