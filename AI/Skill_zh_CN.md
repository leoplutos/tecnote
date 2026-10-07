# Skill

## 简介
Skills 是一组可复用的专业能力模块，让 AI 能针对特定任务调用专门的知识、流程和工具，从而更高效地完成复杂工作。

## 笔者常用的Skill

### SIer 制作納品物的 Skill
可根据需求自动生成基本设计书、详细设计书、UML 图和画面功能设计书等 SIer 风格的系统设计文档。

https://github.com/kazu2377/skills_sample

### grill-me
Matt Pocock 的 Skills 是一套面向 Claude Code、Codex 等 AI Coding Agent 的工程化 Skills，帮助 AI 按规范进行需求分析、设计、TDD、调试、代码审查和架构改进。

https://github.com/mattpocock/skills

其中最有名的就是 `grill-me`

添加到你的工程
```bash
cd /path/to/project_root
npx skills add mattpocock/skills
```

### Effective HTML
一套面向 AI Coding Agent 的 HTML 创作 Skills，用于快速生成自包含的线框图、交互原型、计划、架构图等可视化 HTML 产物，并强调响应式、可访问性与浏览器验证

https://github.com/plannotator/effective-html

### ai-memory
一个面向 AI Coding Agent 的长期记忆与跨 Agent 接力系统，让 Claude Code、Codex、Cursor 等共享项目记忆，实现跨会话、跨机器无缝续接开发工作。

https://github.com/akitaonrails/ai-memory

### show-me
通过 Mermaid、代码结构图、调用树、文件树或交互式 HTML 等可视化方式，帮助用户更直观地理解复杂的代码、架构、流程和概念。

https://github.com/humanlayer/skills/blob/main/plugins/show-me/skills/show-me/SKILL.md

## AI 相关工具

### RTK（Rust Token Killer）
一个面向 AI Coding Agent 的 Rust CLI 代理，通过过滤、压缩和去重终端输出，减少 AI 读取 Bash/CLI 输出时的 Token 消耗，从而降低上下文占用和成本。

https://github.com/rtk-ai/rtk
