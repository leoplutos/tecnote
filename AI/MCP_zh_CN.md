# MCP

## 简介
MCP（Model Context Protocol，模型上下文协议）是一套让 AI 能够标准化连接外部工具、数据和服务的开放协议。

简单来说：

> MCP = 给 AI 接入外部世界的统一接口。

例如通过 MCP，AI 可以连接：

- 📁 文件系统：读取、修改文件
- 🗄️ 数据库：查询 SQL 数据
- 🐙 GitHub：查看代码、Issue、PR
- 📅 日历：查询和创建日程
- 🌐 Web/API：调用外部服务

## 一些例子

### SQL Server

将 [sqlserver.mcp.json](./mcp_conf/sqlserver.mcp.json) 改名为 `.mcp.json` 放在工程的根目录下，然后 AI 即可看到并使用

### Jira、Confluence

使用 Claude Code 的桌面App 运行 `/mcp` 后，连接 `Atlassian Rovo` 后授权即可

更多：
https://support.atlassian.com/atlassian-ai-gateway/docs/get-started-with-the-atlassian-remote-mcp-server

### Playwright

将 [playwright.mcp.json](./mcp_conf/playwright.mcp.json) 改名为 `.mcp.json` 放在工程的根目录下，然后 AI 即可看到并使用

## 其他
AI代码开发常用Agent Skills与MCP工具梳理  
https://johng.cn/ai/ai-code-dev-agent-skills-and-mcp-tools  

