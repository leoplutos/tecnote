return {
  -- https://github.com/folke/flash.nvim
  {
    "folke/flash.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
    },
    keys = {
      --快捷键绑定
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, noremap = true, silent = true, nowait = true, desc = "flash: Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, noremap = true, silent = true, nowait = true, desc = "flash: Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, noremap = true, silent = true, nowait = true, desc = "flash: Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, noremap = true, silent = true, nowait = true, desc = "flash: Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, noremap = true, silent = true, nowait = true, desc = "flash: Toggle Flash Search" },
    },
  },
}
