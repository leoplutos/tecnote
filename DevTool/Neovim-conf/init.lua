--init.lua for neovim
--配置路径为 %LOCALAPPDATA%\nvim

--设置语言
vim.api.nvim_exec('language zh_CN', true)
--vim.api.nvim_exec('language message zh_CN.UTF-8', true)

if vim.g.vscode then
  --VSCode插件设置

  vim.api.nvim_exec('filetype off', true)
  vim.api.nvim_exec('filetype plugin indent off', true)
  vim.api.nvim_exec('filetype plugin off', true)
  vim.api.nvim_exec('filetype indent off', true)
  vim.api.nvim_exec('set whichwrap+=<,>,h,l,[,]', true)

  vim.g.mapleader = "\\"
  vim.keymap.set({"n", "v"}, "J", "10j", { noremap = true })
  vim.keymap.set({"n", "v"}, "K", "10k", { noremap = true })
  vim.keymap.set({"i"}, "<C-j>", "<down>", { noremap = true })
  vim.keymap.set({"i"}, "<C-h>", "<left>", { noremap = true })
  vim.keymap.set({"i"}, "<C-a>", "<C-o>^", { noremap = true })
  vim.keymap.set({"n", "v"}, "<C-z>", "u", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>q", "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>s", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>1", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex1')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>2", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex2')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>3", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex3')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>4", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex4')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>5", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex5')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>6", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex6')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>7", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex7')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>8", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex8')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>9", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex9')<CR>", { noremap = true })

else
  --默认neovim设置

  --加载vim的vimrc配置
  vim.cmd('source ~\\.vimrc')

end
