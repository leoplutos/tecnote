return {
  -- https://nvimdev.github.io/indentmini/
  {
    "nvimdev/indentmini.nvim",
    --true:启用、false:禁用
    enabled = false,
    version = "*",
    event = "VeryLazy",
    config = function()
      --加载插件
      require('indentmini').setup({
        --char = '|',
        char = '│',
        exclude = {
            'erlang',
            'markdown',
        }
      })
    end,
  },
}
