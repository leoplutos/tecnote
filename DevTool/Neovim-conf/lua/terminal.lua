--terminal.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--toggleterm.nvim插件设置
--https://github.com/akinsho/toggleterm.nvim

--加载toggleterm.nvim插件设置
vim.cmd('packadd toggleterm.nvim')

--设定启动命令
--vim.cmd [[ let &shell = g:terminal_shell ]]

--启动toggleterm.nvim
require('toggleterm').setup{
  open_mapping = [[<Leader>a]],
  autochdir = true,
  highlights = {
    Normal = {
      guifg = '#dadada',
      guibg = '#1d1f21',
    },
    NormalFloat = {
      guifg = '#dadada',
      guibg = '#1d1f21',
    },
    FloatBorder = {
      guifg = '#8d8dbf',
      --guibg = '#1e1e1e',
    },
  },
  --shade_terminals = false,
  start_in_insert = true,
  direction = 'float',
  --shell = vim.o.shell,
  shell = vim.g.terminal_shell,
  float_opts = {
    border = 'single',
  },
}

--制作TerminalSend()函数，将参数传递给终端
vim.cmd([[
function! TerminalSend(text)
  exec 'TermExec cmd="' . a:text. '"'
endfunction
]])
