return {
  --https://github.com/abidibo/nvim-httpyac
  --需要安装 npm install -g httpyac
  {
    "abidibo/nvim-httpyac",
    version = "*",
    event = "VeryLazy",
    config = function()

      --加载插件
      local httpyac = require('nvim-httpyac')
      httpyac.setup({})

    end,
    keys = {
      --快捷键绑定
      { "<leader>sr", mode = { "n" }, '<cmd>:NvimHttpYac<CR>', noremap = true, silent = true, nowait = true, desc = "Send httpyac request" },
    },
  }
}
