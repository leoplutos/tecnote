--indent.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--indent-blankline.nvim插件设置
--https://github.com/lukas-reineke/indent-blankline.nvim

-- 加载indent-blankline.nvim插件设置
vim.cmd('packadd indent-blankline.nvim')

-- 关闭默认的list可见性
vim.cmd('set nolist')
-- 如果使用实线字符（aligned solid）的话，需要设定ambiwidth=single
vim.cmd('set ambiwidth=single')

vim.o.list = true
vim.o.listchars = 'tab:│ ,nbsp:+,trail:·,space:·,extends:→,precedes:←'

require('ibl').setup({
  enabled = true,
  debounce = 200,
  --设定缩进显示为实线，tab显示为虚线
  indent = {
    --char = "|",  --虚线字符，可以ambiwidth=double
    --char = "▏",  --实线字符，必须ambiwidth=single
    char = "│", --居中实线
    --tab_char = {'¦'},
    tab_char = {'│'}, --居中实线
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
        'netrw',
        'ctrlp',
        'nerdtree',
        'VimspectorPrompt',
        'NvimTree',
        'cmp_menu',
        'cmp_docs',
        'Outline',
        'toggleterm',
        'flash_prompt',
        'dashboard',
        'mason',
        '',
      },
  },
})

--indent-blankline.nvim插件的高亮设定
vim.cmd([[
hi clear IblIndent
hi! link IblIndent IndentBlankLineBase
hi clear IblWhitespace
hi! link IblWhitespace IndentBlankLineBase
hi clear IblScope
hi! link IblScope IndentBlankLineBase
hi clear @ibl.indent.char.1
hi! link @ibl.indent.char.1 IndentBlankLineBase
hi clear @ibl.indent.char.2
hi! link @ibl.indent.char.2 IndentBlankLineBase
hi clear @ibl.indent.char.3
hi! link @ibl.indent.char.3 IndentBlankLineBase
hi clear @ibl.indent.char.4
hi! link @ibl.indent.char.4 IndentBlankLineBase
hi clear @ibl.indent.char.5
hi! link @ibl.indent.char.5 IndentBlankLineBase
hi clear @ibl.indent.char.6
hi! link @ibl.indent.char.6 IndentBlankLineBase
hi clear @ibl.indent.char.7
hi! link @ibl.indent.char.7 IndentBlankLineBase
hi clear @ibl.whitespace.char.1
hi! link @ibl.whitespace.char.1 IndentBlankLineBase
hi clear @ibl.whitespace.char.2
hi! link @ibl.whitespace.char.2 IndentBlankLineBase
hi clear @ibl.whitespace.char.3
hi! link @ibl.whitespace.char.3 IndentBlankLineBase
hi clear @ibl.whitespace.char.4
hi! link @ibl.whitespace.char.4 IndentBlankLineBase
hi clear @ibl.whitespace.char.5
hi! link @ibl.whitespace.char.5 IndentBlankLineBase
hi clear @ibl.whitespace.char.6
hi! link @ibl.whitespace.char.6 IndentBlankLineBase
hi clear @ibl.whitespace.char.7
hi! link @ibl.whitespace.char.7 IndentBlankLineBase
hi clear @ibl.scope.char.1
hi! link @ibl.scope.char.1 IndentBlankLineBase
hi clear @ibl.scope.char.2
hi! link @ibl.scope.char.2 IndentBlankLineBase
hi clear @ibl.scope.char.3
hi! link @ibl.scope.char.3 IndentBlankLineBase
hi clear @ibl.scope.char.4
hi! link @ibl.scope.char.4 IndentBlankLineBase
hi clear @ibl.scope.char.5
hi! link @ibl.scope.char.5 IndentBlankLineBase
hi clear @ibl.scope.char.6
hi! link @ibl.scope.char.6 IndentBlankLineBase
hi clear @ibl.scope.char.7
hi! link @ibl.scope.char.7 IndentBlankLineBase
hi clear @ibl.scope.underline.1
hi! link @ibl.scope.underline.1 IndentBlankLineUnderlineBase
hi clear @ibl.scope.underline.2
hi! link @ibl.scope.underline.2 IndentBlankLineUnderlineBase
hi clear @ibl.scope.underline.3
hi! link @ibl.scope.underline.3 IndentBlankLineUnderlineBase
hi clear @ibl.scope.underline.4
hi! link @ibl.scope.underline.4 IndentBlankLineUnderlineBase
hi clear @ibl.scope.underline.5
hi! link @ibl.scope.underline.5 IndentBlankLineUnderlineBase
hi clear @ibl.scope.underline.6
hi! link @ibl.scope.underline.6 IndentBlankLineUnderlineBase
hi clear @ibl.scope.underline.7
hi! link @ibl.scope.underline.7 IndentBlankLineUnderlineBase
]])
