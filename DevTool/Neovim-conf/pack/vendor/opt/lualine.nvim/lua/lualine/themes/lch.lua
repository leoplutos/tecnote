--lualine.nvim的自定义主题，会根据发行以下命令自适应
--set background=light
--set background=dark
--使用方式为
--1.将lch.lua/lch_dark.lua/lch_light.lua这3个文件放到/lualine.nvim/lua/lualine/themes下
--2.require('lualine').setup { options = { theme='lch' } }

local background = vim.opt.background:get()

return require('lualine.themes.lch_' .. background)
