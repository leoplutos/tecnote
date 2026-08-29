# DESIGN.md

## 简介
Google 开源的 `DESIGN.md`：一种专门为 AI Coding Agent / AI Agent 描述 UI 设计规范和品牌视觉规则 的文件格式

简单来说：

> DESIGN.md 是一份让 Claude Code、Cursor、Copilot 等 AI Agent “按你的设计规范写 UI”的标准化设计说明文件

DESIGN.md 大概长这样

```
---
name: My Design System

colors:
  primary: "#1A1C1E"
  secondary: "#B8422E"

typography:
  h1:
    fontFamily: "Public Sans"
    fontSize: 3rem

rounded:
  sm: 4px

spacing:
  sm: 8px
---
```

## awesome-design-md

https://github.com/VoltAgent/awesome-design-md

这个仓库定义了一些主流的 `DESIGN.md`，可以直接使用
