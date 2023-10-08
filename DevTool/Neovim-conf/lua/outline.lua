--outline.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--symbols-outline.nvim插件设置
--https://github.com/simrat39/symbols-outline.nvim

-- 加载symbols-outline.nvim插件设置
vim.cmd('packadd symbols-outline.nvim')

require('symbols-outline').setup({
})

-- 快捷键绑定
vim.keymap.set('n', '<F1>', ':SymbolsOutline<CR>', { noremap = true })
