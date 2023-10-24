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
--vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {noremap = true, silent = true}) 
--vim.api.nvim_set_keymap("t", "<leader>l", "<Cmd> wincmd l<CR>", {noremap = true, silent = true}) 
--vim.api.nvim_set_keymap("t", "<leader>h", "<Cmd> wincmd h<CR>", {noremap = true, silent = true}) 
--vim.api.nvim_set_keymap("t", "<leader>j", "<Cmd> wincmd j<CR>", {noremap = true, silent = true}) 
--vim.api.nvim_set_keymap("t", "<leader>k", "<Cmd> wincmd k<CR>", {noremap = true, silent = true})

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
