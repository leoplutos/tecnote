return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}

      -- 在当前主题上修改，而不是替换整个主题
      local theme = opts.options.theme

      if type(theme) == "string" then
        theme = require("lualine.themes." .. theme)
      end

      if type(theme) == "table" then
        theme.normal = theme.normal or {}
        theme.normal.b = vim.tbl_extend("force", theme.normal.b or {}, {
          fg = "#779ae7",
          bg = "#3b4261",
        })
        opts.options.theme = theme
      end

      return opts
    end,
  },
}