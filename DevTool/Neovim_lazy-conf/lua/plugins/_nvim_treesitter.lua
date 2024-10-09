return {
  --https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    version = "*",
    event = "VeryLazy",
    --true:启用、false:禁用
    enabled = true,
    config = function()
      --设定国内镜像
      for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
        config.install_info.url = config.install_info.url:gsub("https://github.com/", vim.g.github_url.."/")
      end
      --加载插件
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        --ensure_installed = {'html', 'css', 'vim', 'lua', 'javascript', 'typescript', 'c', 'cpp', 'python', 'java', 'rust', 'go'},
        ensure_installed = {},
        sync_install = false,
        auto_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          disable = { "vimdoc" },
          additional_vim_regex_highlighting = false,
        },
        --启用增量选择
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
            scope_incremental = '<TAB>'
          }
        },
        -- 启用基于 Treesitter 的代码格式化(=)
        indent = {
          enable = true
        },
      })
      -- 设定json使用jsonc
      vim.treesitter.language.register('jsonc', { 'jsonc', 'json', 'json5' })
	  -- 设定app_dockerfile使用dockerfile
      vim.treesitter.language.register('dockerfile', { 'Dockerfile', 'app_dockerfile' })
	  -- 设定mustache使用html
      vim.treesitter.language.register('html', { 'html', 'mustache' })
    end,
  }
}
