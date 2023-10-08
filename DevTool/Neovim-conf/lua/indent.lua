--indent.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--indent-blankline.nvim插件设置
--https://github.com/lukas-reineke/indent-blankline.nvim

-- 加载indent-blankline.nvim插件设置
vim.cmd('packadd indent-blankline.nvim')

-- 关闭默认的list可见性
vim.cmd('set nolist')

require('ibl').setup({
  indent = {
    char = "|",
    tab_char = { '¦'},
    highlight = { "SpecialKey"},
    smart_indent_cap = true,
    priority = 9,
  },
  whitespace = {
    highlight = { "Whitespace", "NonText" },
    remove_blankline_trail = false,
  },
  scope = { enabled = false },
  exclude = {
      filetypes = {
        'lspinfo',
        'packer',
        'checkhealth',
        'help',
        'man',
        'gitcommit',
        'TelescopePrompt',
        'TelescopeResults',
        'startify',
        '',
      },
  },
})

