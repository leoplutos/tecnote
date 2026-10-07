# Pi

## 简介
`Pi`（Pi Coding Agent）是 `Earendil Inc.` 开源的 **极简终端 AI 编程框架**，主打一句话：
> Adapt pi to your workflows, not the other way around.
> 让 Pi 适配你的工作流，而不是反过来。

和 `Claude Code` 这类 `开箱即用、功能全都内置` 的工具不同，Pi 的思路是 **只提供原语（primitives），其余全部交给扩展**。  
官方明确列出 `不内置` 的东西：无 MCP、无 SubAgent、无权限弹窗、无 Plan Mode、无 TODO、无后台 bash —— 这些都可以用扩展或第三方包自己实现。

内置工具只有 4 个：`read` / `write` / `edit` / `bash`。

官网  
https://pi.dev/

官方文档  
https://pi.dev/docs/latest

GitHub  
https://github.com/earendil-works/pi

许可证：``MIT``

### 主要特性

| 特性 | 说明 |
|------|------|
| 多模型 | 支持 15+ 提供商：Anthropic、OpenAI、Google、Azure、Bedrock、Mistral、Groq 等，会话中可随时切换 |
| 会话树 | 历史记录为树形结构，支持分支（fork）、书签、HTML 导出、分享到 GitHub Gist |
| 上下文工程 | ``AGENTS.md`` 项目指令、``SYSTEM.md`` 系统提示自定义、自动压缩（compact） |
| 四种运行模式 | 交互式 TUI / print・JSON 输出 / RPC 协议 / SDK 嵌入 |
| 可扩展 | Extensions、Skills、Prompt Templates、Themes，可打包成 Pi Package 分发 |


## 推荐选项
如果在 Windows 平台使用的话，需要安装完全版的 ``官方 Git for Windows``  

参考 [这里](../Other/Ripgrep_zh_CN.md) 安装 `rg` 和 `fd`

## 安装

### Windows
通过包管理器
```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

### Linux / MacOS
```bash
curl -fsSL https://pi.dev/install.sh | sh
```

### 更新
更新 Pi 本体
```bash
pi update
```
更新已安装的扩展
```bash
pi update --extensions
```

## 使用

在你的工程根目录直接运行
```bash
pi
```

### 登录

首次使用需要认证，二选一：
- 在 Pi 里执行 `/login`（订阅制提供商登录）
- 或设置环境变量，例如 `ANTHROPIC_API_KEY`

**推荐用 OpenAI Codex 的订阅方式登录**，原因是计费口径不一样：

| 提供商 | 计费方式 |
|------|------|
| Claude | **不走** Claude 订阅额度，而是按 `Extra Usage` 的 Token 额外计费 |
| OpenAI Codex | **走** ChatGPT／Codex 订阅额度，不按 API Token 额外计费 |

登录路径
```
/login
→ Sign in with an account
   OpenAI Codex • unconfigured
 → Browser login (default)
```

### 非交互模式
```bash
pi -p "把 README 翻译成日文"
```
标准输入会自动合并进 prompt，所以可以这样用
```bash
cat error.log | pi -p "分析这段日志，找出根因"
```

### RPC 模式（供非 Node.js 系统集成）
```bash
pi --mode rpc
```

### 常用命令行参数
```
--provider <name>        指定提供商
--model <pattern>        指定模型
--thinking <level>       设置思考深度
-c, --continue           继续上一次会话
--no-session             临时会话，不落盘
-e, --extension <src>    加载扩展
--tools <list>           工具白名单
```

### 常用斜杠命令

| 命令 | 作用 |
|------|------|
| ``/login`` ``/logout`` | 登录 / 登出 |
| ``/model`` 或 ``Ctrl+L`` | 切换模型（``Ctrl+P`` 在常用模型间循环） |
| ``/settings`` | 修改配置 |
| ``/tree`` | 浏览会话树 |
| ``/fork`` | 从某条消息分支出新会话 |
| ``/compact`` | 压缩早期上下文 |
| ``/export`` | 导出为 HTML |
| ``/share`` | 分享到 GitHub Gist |
| ``/reload`` | 重新加载 |
| ``/skill:名称`` | 调用某个 Skill |
| ``/llama`` | 本地模型路由与管理 |

## 配置

### 配置文件位置

全局文件默认放在：
```
~/.pi/agent/AGENTS.md
```

项目层放在：
```
my-project/
├── AGENTS.md           # 项目公共规则，团队共享，进仓库
├── SYSTEM.md           # 个人针对这个项目的额外规则/配置，通常加入 .gitignore
├── .gitignore
└── src/
```

参考 [codex_conf](./codex_conf/) 目录

其他的一些配置
| 路径 | 说明 |
|------|------|
| `~/.pi/agent/settings.json` | 全局配置 |
| `.pi/settings.json` | 工程配置，**覆盖全局** |
| `~/.pi/agent/auth.json` | 登录凭据 |
| `~/.pi/agent/trust.json` | 目录信任决策 |
| `~/.pi/agent/sessions/` | 会话记录 |

Windows 下认证文件的实际路径
```
%USERPROFILE%\.pi\agent\auth.json
```
内容形如（`/login` 后自动生成，不要手工改）
```json
{
  "anthropic": {
    "type": "oauth",
    "refresh": "xxxx",
    "access": "xxxx",
    "expires": 1788682967887
  }
}
```
```json
{
  "openai-codex": {
    "type": "oauth",
    "refresh": "xxxx",
    "access": "xxxx",
    "expires": 1788682967887
  }
}
```

### 常用环境变量

| 变量 | 说明 |
|------|------|
| ``ANTHROPIC_API_KEY`` | API 认证（其他提供商同理） |
| ``PI_OFFLINE`` | 禁用启动时的网络请求 |
| ``PI_SKIP_VERSION_CHECK`` | 跳过版本检查 |
| ``PI_TELEMETRY`` | 控制遥测与归因头 |
| ``VISUAL`` / ``EDITOR`` | 外部编辑器 |

## 扩展体系

Pi 的全部能力扩展分四层，都可以打包成 ``Pi Package`` 用 npm 或 git 分发。

| 类型 | 说明 | 存放位置 |
|------|------|----------|
| Extensions | TypeScript 模块，可注册工具、命令、事件、自定义 UI | ``~/.pi/agent/extensions/`` |
| Skills | Markdown 写的按需能力（Agent Skills 标准） | ``~/.pi/agent/skills/`` 或工程内 ``.agents/skills/`` |
| Prompt Templates | 可复用的 Prompt，支持变量替换，通过斜杠命令展开 | ``~/.pi/agent/prompts/`` |
| Themes | 终端主题 | ``~/.pi/agent/themes/`` |

### 包管理
查看已安装的全部资源
```bash
pi list
```
安装
```bash
pi install npm:@foo/pi-tools
```
```bash
pi install git:github.com/user/repo@v1
```
```bash
pi update --all
```
```bash
pi config
```
（``pi config`` 用于启停已安装的资源）

官方包浏览  
https://pi.dev/packages

模型配置参考  
https://pi.dev/models

### 推荐扩展

#### 1. pi-mcp-adapter —— MCP 支持，优先级最高
Pi 本体不内置 MCP，装这个扩展补上。

```bash
pi install npm:pi-mcp-adapter
```

配置文件 `~/.agents/mcp/mcp.json`

内容参考 [atlassian.mcp.json](./mcp_conf/atlassian.mcp.json)

认证（以 atlassian 为例）
```bash
/mcp-auth atlassian
```
查看连接状态
```bash
/mcp status
```

#### 2. pi-subagents —— 补上 Claude Code 的 Subagent 体验
把活委派给专注的子 Agent：代码审查、调研、实现、并行审计。
内置 `scout`（代码库侦查）、`researcher`（联网调研）、`worker`（实现）、`reviewer`（代码审查）、`oracle`（第二意见）、`delegate`（通用委派）。

```bash
pi install npm:pi-subagents
```

常用命令：`/council` 多模型会诊、`/subagents-fleet` 查看运行中的任务、`/subagents-doctor` 排障、`/subagents-guide` 看文档。

#### 3. pi-web-access —— 给 Agent 强化联网能力
网页搜索、正文抓取、GitHub 仓库克隆、PDF 提取、YouTube 与本地视频理解。

```bash
pi install npm:pi-web-access
```

零配置即可用（走 Exa MCP，也能复用 Codex 的认证）；要换搜索源（OpenAI／Brave／Jina／Tavily／Gemini 等）就在 `~/.pi/web-search.json` 里配 Key。
常用命令：`/websearch`、`/search`、`/curator`。

#### 4. pi-memory —— 长期记忆
跨日志、长期记忆和便签做语义检索（基于 qmd）。

```bash
pi install npm:pi-memory
```

记忆以纯 Markdown 存在 `~/.pi/agent/memory/` 下：长期记忆 `MEMORY.md`、日志 `daily/`、恢复文件 `recovery/`。

#### 5. rpiv-ask-user-question
类似 Claude Code 里的选项式提问。pi 上的这个扩展做到了同款体验：选择、确认、输入都是类型化选项，回答成本极低。它先花 10 秒把关键决策问清楚，再动手干活。

```bash
pi install npm:@juicesharp/rpiv-ask-user-question
```

## UI/UX 设计 - pi-design-deck

`pi-design-deck` 是 Pi Agent 的开源设计扩展，主要用于 UI Mockup、视觉设计方向探索、Architecture Diagram 和设计方案对比。

可以从 PRD、Markdown 或文字需求出发，生成多个高保真的 UI 设计方案，并通过视觉 Deck 进行比较和选择；选定设计方向后，可以继续交给 Pi Agent 实现。

pi-design-deck 本身无需额外费用，但使用的 AI 模型/API 可能产生费用

安装：
```bash
pi install npm:pi-design-deck
```

项目地址：  
https://pi.dev/packages/pi-design-deck

## 前端（GUI）

Pi 本体只有 TUI，但它提供了 `--mode rpc` 和 SDK，所以社区做了不少图形前端。

### PiDeck（推荐）
https://github.com/ayuayue/PiDeck.

`Electron` + `React 19` 的开源桌面工作台，本质是拉起多个 `pi --mode rpc` 进程的外壳，**不是 Pi 的分支**。

### pi-web-ui
https://pi.dev/packages/pi-web-ui  
https://github.com/xing-shuyin/pi-web-ui/blob/main/README.zh-CN.md  

浏览器端的 Web UI，走 WebSocket 流式对话，可以装成系统服务（Docker／systemd／launchd），适合放在服务器上远程用。凭据保存在服务端，Provider Key 不会到浏览器。

### PiCove
https://github.com/Skitre/PiCove

`Tauri 2` 的原生桌面 App，内置了 Node 运行时和 Pi SDK，**不依赖全局安装的 pi CLI**。
支持会话历史浏览恢复、模型切换、Git 变更审阅、包（扩展／Skill／Prompt／主题）管理，有中文界面。
目前提供 Windows 11 x64、macOS Apple Silicon、macOS Intel。

## 其他
