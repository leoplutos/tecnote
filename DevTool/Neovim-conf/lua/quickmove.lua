--quickmove.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--flash.nvim插件设置
--https://github.com/folke/flash.nvim

-- 加载flash.nvim插件设置
vim.cmd('packadd flash.nvim')

require('flash').setup({
})

-- 快捷键绑定
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require("flash").jump() end, { noremap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require("flash").treesitter() end, { noremap = true })
vim.keymap.set({ 'o' }, 'r', function() require("flash").remote() end, { noremap = true })
vim.keymap.set({ 'x', 'o' }, 's', function() require("flash").treesitter_search() end, { noremap = true })
vim.keymap.set({ 'c' }, '<C-s>', function() require("flash").toggle() end, { noremap = true })

--高亮设定
vim.cmd([[
hi clear FlashCurrent
hi! link FlashCurrent CurSearch
hi clear FlashPromptIcon
hi! link FlashPromptIcon Statement
]])
