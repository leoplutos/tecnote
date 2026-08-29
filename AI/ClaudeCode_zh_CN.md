# Claude Code

## 简介
``Claude Code`` 一直是大家公认的 AI 编程命令行工具 ``Top 1``，在 AI 和程序员圈子里几乎是神一般的存在

官网简介  
https://code.claude.com/docs/zh-CN/overview

### 注意
如果在 Windows 平台使用的话，需要安装完全版的 ``官方 Git for Windows``  
因为 Claude Code 明确依赖 ``cygpath`` ，精简版Git（Portable Git／MinGit／IDE工具内嵌Git／精简版Git）不包含 ``cygpath``  
官方 Git for Windows 安装方法可以参考 [这里](../Git/Git-bash_zh_CN.md)

### 使用向导
https://johng.cn/ai/claude-code-guide

## 安装

### 1. 在终端中使用 Claude Code CLI
Windows

```bash
winget install Anthropic.ClaudeCode
```
winget 安装不会自动更新。定期运行 `winget upgrade Anthropic.ClaudeCode` 来获取最新功能和安全修复。

MacOS
```bash
brew install --cask claude-code
```

### 2. 在桌面App中使用 Claude Code
https://code.claude.com/docs/zh-CN/desktop-quickstart

### 3. 在 VSCode 中使用插件

安装插件 [Claude Code for VS Code](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code) 后，使用 VSCode 打开你的工程，然后打开 ``Claude Code`` 的聊天窗口，即可开始使用了  
主要的使用方式就是通过聊天框说明你的需求，尽量说的详细些  

比如 在 Claude 对话中输入
```
请阅读 .claude/prompts/estimate_prompt.md，分析当前项目并生成报价书，生成md文件
```

## 配置
参考 [claude_conf](./claude_conf) 目录

## 使用技巧

每次和和AI结束对话后必须问的2句话
```
眼下你最没把握的事情是什么
```
```
关于当前的情况，我最大的遗漏是什么？我没有意识到什么？
```

## Skill

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

## 其他

### 删除 Claude 的Session

使用 CMD 查看 Claude 数据目录
```bash
dir %USERPROFILE%\.claude\projects
```
找到你的工程目录删除所有即可

### 在 Windows 系统下使用 Claude 之后会有一个 nul 的文件删不掉

使用 CMD 命令删除（不是 PowerShell，优先用 CMD）
```bash
del \\?\C:\pathto\project\nul
```

