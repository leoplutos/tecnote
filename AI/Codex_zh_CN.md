# Codex

## 简介
`Codex` 是 OpenAI 推出的 AI 编程智能体，能够理解代码库、编写和修改代码、运行测试，并协助完成开发任务。

它不仅能生成代码，还可以在真实开发环境中自主执行多步骤任务，适合用于开发、调试、重构和代码审查。

官网简介  
https://chatgpt.com/zh-Hans-CN/codex/

https://learn.chatgpt.com/docs/codex/cli

### 使用向导
https://johng.cn/ai/codex-cli-guide


### 注意
如果在 Windows 平台使用的话，建议安装 ``PowerShell 7``  

## PowerShell 7 安装

### 1. 在PowerShell运行命令确认当前版本
```PowerShell
$PSVersionTable
```

### 2. 安装 PowerShell 7（必须安装MSI版本的，不要安装MSIX版本）

https://github.com/PowerShell/PowerShell/releases

安装 `PowerShell-7.6.6-win-x64.msi`

### 3. 安装后确认

发下面的内容给 Codex 确认一下
```
我已经安装了 PowerShell 7
从 Codex 使用 PowerShell 时，会使用 PowerShell 7 吗？
```

## 推荐选项
除了 `PowerShell 7` 之外，参考 [这里](../Other/Ripgrep_zh_CN.md) 安装 `rg` 和 `fd`

## Codex 安装

### 1. 在终端中使用 Codex CLI
Windows

```bash
winget install -e --id OpenAI.Codex
```
Codex 安装不会自动更新。定期运行 `winget upgrade -e --id OpenAI.Codex` 来获取最新功能和安全修复。

MacOS
```bash
brew install --cask codex
```

### 2. 在桌面App中使用 Codex
https://chatgpt.com/zh-Hans-CN/download/

### 3. 在 VSCode 中使用插件

安装插件 [Codex – OpenAI’s coding agent](https://marketplace.visualstudio.com/items?itemName=openai.chatgpt) 后，使用 VSCode 打开你的工程后使用

## 配置

全局文件默认放在：
```
~/.codex/AGENTS.md
```

项目层放在：
```
my-project/
├── AGENTS.md           # 项目公共规则，团队共享，进仓库
├── AGENTS.override.md  # 个人针对这个项目的额外规则/配置，通常加入 .gitignore
├── .gitignore
└── src/
```

参考 [codex_conf](./codex_conf/) 目录

## UI/UX 设计 - ChatGPT Product Design

`Product Design` 是 OpenAI 官方的产品设计插件/技能，主要用于 UI、Wireframe、Prototype、产品流程、Landing Page、UX Research、Design QA 和设计交付

可以从文字需求、URL、截图或已有设计开始，进行产品设计、用户流程设计和交互原型的制作与迭代。

https://chatgpt.com/plugins/product-design?open_in_app

## UI/UX 设计 - Stitch
https://stitch.withgoogle.com/

使用 Stitch 生成好页面以后，在导出里面选择 `MCP`，然后在 CodeX 里面配置 MCP 选择 `流式HTTP` 即可

