# ADE

## 简介
ADE（Agent Development Environment，智能体开发环境）是专门用于开发、调试、测试和部署 AI Agent 的开发环境。

可以把它理解成：

传统 IDE（如 VS Code）是开发程序的环境 → ADE 是开发 AI Agent 的环境。

一般会提供：

- 🤖 Agent 开发：定义 Agent 的角色、Prompt、Tools、Workflow
- 🔧 Tool 管理：接入 MCP、API、数据库、浏览器等工具
- 🧠 上下文管理：Memory、Context、Knowledge Base
- 🐛 调试：查看 Agent 每一步的思考、Tool Call、输入输出
- 📊 Tracing / Observability：追踪一次 Agent 执行全过程
- 🧪 Evaluation：批量测试 Agent 的准确率、稳定性
- 🚀 Deployment：将 Agent 部署到生产环境

## 一些流行的ADE

### codex-host
在 Codex Desktop 中运行 Pi, Claude Code 和其他 Harness

https://github.com/BytePioneer-AI/codex-host

### Paseo
一个统一管理 Claude Code、Codex、Copilot、OpenCode 等 AI 编程 Agent 的跨平台编排工具，可从桌面、Web、手机和 CLI 并行运行多个 Agent。

https://github.com/getpaseo/paseo

### Delta（还在开发中）
https://zed.dev/blog/introducing-delta  
https://zed.dev/deltadb  

### Orca
一款面向 AI Agent 的开源开发工具，帮助开发者通过自然语言让 AI 自主完成代码编写、调试、测试和项目操作。

https://github.com/stablyai/orca/blob/main/docs/readme/README.zh-CN.md

https://www.onorca.dev/

### Emdash

一个专门管理多个 AI Coding Agent 的桌面工作台。
它不是另一个 Claude Code / Codex，而是把你已经在用的 Claude Code、OpenAI Codex、OpenCode、Cursor、Amp、Qwen Code 等 Agent 统一放到一个 GUI 里，并且让它们并行工作

https://github.com/generalaction/emdash

### tty7
一个 基于 Rust + GPU 的现代终端工作台，集成了持久化会话、SSH、Git、远程开发以及 Claude Code/Codex 等 AI Coding Agent，定位上类似 「终端模拟器 + tmux + AI Agent 工作台」

https://github.com/l0ng-ai/tty7

https://tty7.io/

### Warp
一款现代化 AI 终端，将命令行、AI 助手和开发工作流结合，让开发者更高效地执行命令、编写代码和排查问题。

https://www.warp.dev/

https://github.com/warpdotdev/warp

### cmux
cmux：一款基于终端的 AI Agent 工作环境，将多个终端、分屏、浏览器和 AI Agent 集成在一个窗口中，方便同时管理和监控多个 Agent。

https://github.com/manaflow-ai/cmux/blob/main/README.zh-CN.md

https://cmux.com/zh-CN

### Intelligent Terminal
微软推出的 Windows Terminal 实验性分支，将 AI Agent 原生集成到终端中，可直接利用 Shell 上下文辅助执行、诊断和修复命令

https://github.com/microsoft/intelligent-terminal

### Herdr
一个专为 AI Coding Agent 设计的终端运行时和多路复用器，可让 Claude Code、Codex 等 Agent 在后台持续运行，并支持会话持久化、远程重连和多 Agent 管理

https://github.com/herdrdev/herdr

### Otty
一款原生、GPU 加速的现代终端应用，介于传统 Terminal 和完整 IDE 之间，并特别针对 Claude Code、Codex 等 AI Coding Agent 的多会话/多任务工作流进行了优化

https://otty.sh/

