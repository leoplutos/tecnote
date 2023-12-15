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
--local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
vim.cmd([[
function! TerminalSend(text)
  exec "TermExec cmd='" . a:text. "'"
endfunction
]])

--toggleterm.nvim插件的快捷键绑定
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-c>', '<Cmd>bd<CR>', opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

--在toggleterm.nvim中集成gitui和lazygit
--https://github.com/jesseduffield/lazygit
local Terminal  = require('toggleterm.terminal').Terminal
--集成gitui
local gitui = Terminal:new({ cmd = "gitui", hidden = true, dir = vim.g.g_s_projectrootpath })
function _gitui_toggle()
  gitui:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>gu", "<cmd>lua _gitui_toggle()<CR>", {noremap = true, silent = true})
--集成lazygit
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, dir = vim.g.g_s_projectrootpath })
function _lazygit_toggle()
  lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
--集成gobang
local gobang = Terminal:new({ cmd = "gobang", hidden = true, dir = vim.g.g_s_projectrootpath })
function _gobang_toggle()
  gobang:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>lua _gobang_toggle()<CR>", {noremap = true, silent = true})
