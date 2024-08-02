return {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    --true:启用、false:禁用
    enabled = true,
    version = "*",
    event = "VeryLazy",
    main = "ibl",
    init = function()
      vim.o.list = true
      vim.o.listchars = 'tab:│ ,nbsp:+,trail:·,space:·,extends:→,precedes:←'
    end,
    --插件的设定
    opts = {
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
            'which_key',
            '',
          },
      },
    },
  },
}
