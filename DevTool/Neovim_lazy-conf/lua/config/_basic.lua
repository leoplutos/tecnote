--配置路径为 %LOCALAPPDATA%\nvim\lua
-- 全局设定

--vim.g.github_url = 'https://github.com'
vim.g.github_url = 'https://bgithub.xyz'
vim.g.pip_url = 'https://mirrors.aliyun.com/pypi/simple'
vim.g.user_home = vim.fn.expand('~')
vim.g.lazy_nvim_root = vim.fn.stdpath("config") .. "/lazy"
vim.g.lazy_nvim_path = vim.g.lazy_nvim_root .. "/lazy.nvim"
vim.g.mason_nvim_root = vim.fn.stdpath("config") .. "/mason"
vim.g.g_s_rootmarkers = {'.git', '.svn', '.root', '.hg', 'pom.xml', 'package.json', '.vscode', '.venv'}
if (vim.g.os_flg == 'windows') then
  vim.g.terminal_shell = 'cmd.exe /k D:/Tools/WorkTool/Cmd/cmdautorun.cmd'
  vim.g.java_maven_conf_path = 'D:/Tools/WorkTool/Java/apache-maven-3.9.7/conf/settings.xml'
else
  vim.g.terminal_shell = '/bin/bash -l -i'
  vim.g.java_maven_conf_path = '/usr/share/maven/conf/settings.xml'
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
vim.opt.shellslash = true
vim.opt.jumpoptions = 'stack'
vim.o.ambiwidth = 'single'

vim.cmd([[
"-----------------------------------------------"
"               工程跟路径函数定义              "
"               使用s:project_root()函数取得    "
"-----------------------------------------------"
function! GetProjectRoot()
  let name = expand('%:p')
  return FindRoot(name, g:g_s_rootmarkers, 0)
endfunction
function! FindRoot(name, markers, strict)
  let name = fnamemodify((a:name != '')? a:name : bufname('%'), ':p')
  let finding = ''
  " iterate all markers
  for marker in a:markers
    if marker != ''
      " search as a file
      let x = findfile(marker, name . '/;')
      let x = (x == '')? '' : fnamemodify(x, ':p:h')
      " search as a directory
      let y = finddir(marker, name . '/;')
      let y = (y == '')? '' : fnamemodify(y, ':p:h:h')
      " which one is the nearest directory ?
      let z = (strchars(x) > strchars(y))? x : y
      " keep the nearest one in finding
      let finding = (strchars(z) > strchars(finding))? z : finding
    endif
  endfor
  if finding == ''
    let path = (a:strict == 0)? fnamemodify(name, ':h') : ''
  else
    let path = fnamemodify(finding, ':p')
  endif
  if has('win32') || has('win16') || has('win64') || has('win95')
    let path = substitute(path, '\/', '\', 'g')
  endif
  if path =~ '[\/\\]$'
    let path = fnamemodify(path, ':h')
  endif
  return path
endfunction
]])
