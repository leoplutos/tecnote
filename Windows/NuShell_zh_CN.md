# NuShell

## 简介
Nushell 是一个现代化的、结构感知的开源 shell 工具，基于 Rust 语言开发，旨在提升命令行体验并兼容平台相关可执行文件。它能够处理结构化数据（如 JSON、CSV），提供跨平台支持，并具备简单的学习曲线和丰富的配置选项。以下从安装、配置、美化、特点与优势、高级用法及相关资源等方面详细展开。

## 安装
参考 [官网](https://www.nushell.sh/zh-CN/book/installation.html) 安装即可

```bash
# 安装到用户范围（默认）。
winget install nushell
# 系统范围安装（以管理员身份运行）。
winget install nushell --scope machine
```

## 设置

### 用户设定文件位置（Windows）
```
%AppData%\nushell
```

### 笔者的设定文件
- [NuShell-conf](../DevTool/NuShell-conf)
