# AGENTS.md - Project Configuration

本仓库的配置以 [CLAUDE.md](./CLAUDE.md) 为准，**先读那个文件**。
本文件只记录 `CLAUDE.md` 中没有的内容。

## Windows 文本编码

本仓库中的所有文本文件（包括 `.md`、`.txt`、`.json`、`.yaml`、`.yml`、`.xml`、`.csv`、`.ts`、`.js`、`.java` 等）均使用 **UTF-8** 编码。
在 Windows 环境下使用 PowerShell 读取文本文件时，必须显式指定 UTF-8 编码，不要使用默认编码。
例如：

```powershell
Get-Content -LiteralPath <文件路径> -Encoding utf8
```

因为在部分 Windows 环境（尤其是 Windows PowerShell 5.1）中，默认编码可能不是 UTF-8，导致中文或日文出现乱码。
如需读取整个文件内容，也可以使用：

```powershell
[System.IO.File]::ReadAllText(
    "<文件路径>",
    [System.Text.Encoding]::UTF8
)
```

## 工具（CLAUDE.md 未记载的部分）
