--配置路径为 %LOCALAPPDATA%\nvim\lua
-- 全局设定

--vim.g.github_url = 'https://github.com'
vim.g.github_url = 'https://bgithub.xyz'
vim.g.pip_url = 'https://mirrors.aliyun.com/pypi/simple'
vim.g.user_home = vim.fn.expand('~')
vim.g.lazy_nvim_root = vim.fn.stdpath("config") .. "/lazy"
vim.g.lazy_nvim_path = vim.g.lazy_nvim_root .. "/lazy.nvim"
vim.g.mason_nvim_root = vim.fn.stdpath("config") .. "/mason"
vim.g.g_s_rootmarkers = {'.git', '.svn', '.root', '.hg', 'pom.xml', 'gradlew', 'mvnw', '.venv', 'pyproject.toml', 'go.mod', 'go.work', 'Cargo.toml', 'package.json', 'tsconfig.json', 'jsconfig.json', '.vscode'}
if (vim.g.os_flg == 'windows') then
  vim.opt.shellslash = true
  vim.g.terminal_shell = 'cmd.exe /k D:/Tools/WorkTool/Cmd/cmdautorun.cmd'
  vim.g.java_maven_conf_path = 'D:/Tools/WorkTool/Java/apache-maven-3.9.7/conf/settings.xml'
  -- Windows %APPDATA%\Code\User\snippets
  vim.g.vscode_snippets = vim.g.user_home .. "/AppData/Roaming/Code/User/snippets"
else
  -- vim.g.terminal_shell = '/bin/bash -l -i'
  vim.g.terminal_shell = '/bin/bash'
  vim.g.java_maven_conf_path = '/usr/share/maven/conf/settings.xml'
  -- $HOME/.config/Code/User/snippets
  vim.g.vscode_snippets = vim.g.user_home .. "/.config/Code/User/snippets"
end

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,ucs-bom,shift-jis,cp932,euc-jp,gb18030,gbk,gb2312,cp936,utf-16,big5,latin1'
vim.opt.termguicolors = true
vim.opt.ruler = true
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.confirm = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
--vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.whichwrap = '<,>,h,l,[,]'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.sidescroll = 10
vim.opt.foldenable = false
vim.opt.showtabline = 2
vim.opt.wrapscan = false
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.autochdir = true
vim.opt.showfulltag = true
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.shortmess = 'ltToOCFc'
vim.opt.complete = '.,k,w,b'
vim.opt.omnifunc = 'syntaxcomplete#Complete'
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 1
vim.opt.pumheight = 15
vim.opt.formatoptions = 'tcqjmB'
vim.opt.matchpairs = '(:),{:},[:],<:>'
vim.opt.jumpoptions = 'stack'
vim.o.ambiwidth = 'single'
-- 同步系统剪切板
function my_paste(reg)
  return function(lines)
    -- 返回 " 寄存器的内容，用来作为 p 操作符的粘贴物
    local content = vim.fn.getreg('"')
    return vim.split(content, '\n')
  end
end
if (vim.env.SSH_TTY == nil) then
  -- 当前环境为本地环境，也包括 WSL
  vim.opt.clipboard = "unnamedplus"
else
  -- 远程环境
  vim.opt.clipboard:append("unnamedplus")
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      -- 小括号里面的内容可能是毫无意义的，但是保持原样可能看起来更好一点
      ["+"] = my_paste("+"),
      ["*"] = my_paste("*"),
    },
  }
end
-- Docker环境
local docker_container = os.getenv('DOCKER_CONTAINER')
if docker_container then
  -- 在Docker容器内
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      -- 小括号里面的内容可能是毫无意义的，但是保持原样可能看起来更好一点
      ["+"] = my_paste("+"),
      ["*"] = my_paste("*"),
    },
  }
else
  -- 不在Docker容器内
end
