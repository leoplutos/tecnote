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

## 推荐选项
除了 `Git for Windows` 之外，参考 [这里](../Other/Ripgrep_zh_CN.md) 安装 `rg` 和 `fd`

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

### 4. 在 JetBrains IDEs 中使用插件
在 JetBrains IDE 中提供与 VS Code 的 Claude Code 完全相同的 UI UX

https://github.com/Swttch/swttch

## 配置

全局文件默认放在：
```
~/.claude/CLAUDE.md
```

项目层放在：
```
my-project/
├── CLAUDE.md          # 项目公共规则，团队共享，进仓库
├── CLAUDE.local.md    # 个人针对这个项目的额外规则/配置，通常加入 .gitignore
├── .gitignore
└── src/
```

参考 [claude_conf](./claude_conf) 目录

### AGENTS.md 支持
Claude Code 从 `2.1.277` 版本开始支持 `AGENTS.md`

**具体规则**：

- 如果某个目录下存在 CLAUDE.md，Claude Code 优先使用 CLAUDE.md
- 如果该目录下没有 CLAUDE.md，Claude Code 会检查 AGENTS.md，如果存在就使用它

这个行为可以在 Claude Code 的 `/config` 中开启或关闭

## 使用技巧

每次和和AI结束对话后必须问的2句话
```
眼下你最没把握的事情是什么
```
```
关于当前的情况，我最大的遗漏是什么？我没有意识到什么？
```

## UI/UX设计 - Claude Design

`Claude Design` 是 专门做的 AI 设计，原型制作工具。它和普通的 Claude Chat 最大区别是：不是只跟你聊天，而是直接生成一个可以交互、修改、导出的视觉设计作品

用来做 `UI` / `Wireframe` / `Mockup` / `PPT资料` / `产品介绍页` 都可以

https://claude.ai/design

制作完毕后还可以 `Hand off to Claude Code` 非常方便

### 制作 Claude Design 模板

先自己制作一个 pptx 模板文件，然后在 Claude Design 开启会话

把 design_template_liang.pptx 拖进去，再贴上下面这段 prompt

```
请根据上传的 design_template_liang.pptx 为我建立一个设计系统（演示文稿用，不是 Web 应用）。

这份 PPT 共 15 页：
- 第 1–7 页是规则：使用方法、配色、字体、版式骨架、组件
- 第 8–15 页是空白模板：表紙、章扉、要点、数字、メッセージ、導入効果、実績マップ、体制図

要求：
1. 颜色、字号、间距严格按 PPT 里的实际数值提取，不要自己发挥
2. 字体：日文和英文都用 Meiryo
3. 第 8–15 页各做成一个可复用的幻灯片模板
4. 第 1–7 页的规则整理进 Readme
```

## 其他

### 每次和和AI结束对话后必须问的2句话
```
眼下你最没把握的事情是什么
关于当前的情况，我最大的遗漏是什么？我没有意识到什么？
```

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

### 一个开源版的Claude - OpenClaude

https://github.com/Gitlawb/openclaude
