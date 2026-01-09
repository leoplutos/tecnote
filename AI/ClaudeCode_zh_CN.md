# Claude Code

## 简介
``Claude Code`` 一直是大家公认的 AI 编程命令行工具 ``Top 1``，在 AI 和程序员圈子里几乎是神一般的存在

他的使用方式有多种，可以在网页，终端，IDE等等里面使用

安装方式可以查看官网  
https://code.claude.com/docs/en/overview

### 注意
如果在 Windows 平台使用的话，需要安装完全版的 ``官方 Git for Windows``  
因为 Claude Code 明确依赖 ``cygpath`` ，精简版Git（Portable Git／MinGit／IDE工具内嵌Git／精简版Git）不包含 ``cygpath``  
官方 Git for Windows 安装方法可以参考 [这里](../Git/Git-bash_zh_CN.md)

## 在 VSCode 中使用
因为笔者更倾向在 IDE 中使用所以主要介绍使用 VSCode 的方式，在终端中的使用体验是一致的

### 安装插件
- [Claude Code for VS Code](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code)

### Claude 推荐的 prompt 目录结构
```
your-project/
├── .claude/        # Claude 相关配置和 prompt
│   └── prompts/
│       └── estimate_prompt.md
├── CLAUDE.md       # 基础配置，你的每个会话都会读取此配置
├── src/
└── ...
```

文件的说明
|   项目   |          CLAUDE.md         |   estimate_prompt.md  |
|:--------:|:--------------------------:|:---------------------:|
| 位置     | 项目根目录                 | .claude/prompts/ 目录 |
| 加载方式 | Claude 自动读取            | 需要手动引用          |
| 作用范围 | 所有对话                   | 特定任务              |
| 内容性质 | 项目背景信息               | 任务执行指令          |
| 更新频率 | 项目初始化时设置，很少改动 | 根据需要调整          |

配置示例 : [claude_conf](./claude_conf/)

### 使用方式
使用 VSCode 打开你的工程，然后打开 ``Claude Code`` 的聊天窗口，即可开始使用了  
主要的使用方式就是通过聊天框说明你的需求，尽量说的详细些  
``Claude Code`` 暂时还不支持代码的 ``TAB补全`` 功能，如有需要可以尝试其他 AI

比如 在 Claude 对话中输入
```
请阅读 .claude/prompts/estimate_prompt.md，分析当前项目并生成报价书，生成md文件
```

## 其他

### 删除 Claude 的Session

使用 cmd 查看 Claude 数据目录
```bash
dir %USERPROFILE%\.claude\projects
```
找到你的工程目录删除所有即可
