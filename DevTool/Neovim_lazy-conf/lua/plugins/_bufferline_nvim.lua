return {
  -- https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
    },
    config = function()

      --设定bufferline的高亮
      local lch_bufferline_colors = {
          base_bg  = '#000000',
          selected_fg  = '#ffffff',
          selected_bg  = '#1e1e1e',
          numbers_fg = '#cabd34',
          numbers_selected_fg = '#ffff00',
      }
      local lch_bufferline_highlights = {
        fill = {
          bg = { attribute = "bg", highlight = "TabLineFill" },
          fg = { attribute = "fg", highlight = "TabLineFill" },
        },
        background = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        tab = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        tab_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.selected_fg,
          bold = true,
        },
        tab_separator = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        tab_separator_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.selected_fg,
        },
        tab_close = {
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        close_button = {
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        close_button_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        close_button_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.selected_fg,
        },
        buffer_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        buffer_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.selected_fg,
          bold = true,
        },
        numbers = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = lch_bufferline_colors.numbers_fg,
        },
        numbers_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = lch_bufferline_colors.numbers_fg,
        },
        numbers_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.numbers_selected_fg,
          bold = true,
        },
        diagnostic = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        diagnostic_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        diagnostic_selected = {
          bg = lch_bufferline_colors.selected_bg,
          bold = true,
        },
        hint = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        hint_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        hint_selected = {
          bg = lch_bufferline_colors.selected_bg,
          bold = true,
        },
        hint_diagnostic = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        hint_diagnostic_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        hint_diagnostic_selected = {
          bg = lch_bufferline_colors.selected_bg,
          bold = true,
        },
        info = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        info_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        info_selected = {
          bg = lch_bufferline_colors.selected_bg,
          bold = true,
        },
        info_diagnostic = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        info_diagnostic_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        info_diagnostic_selected = {
          bg = lch_bufferline_colors.selected_bg,
          bold = true,
        },
        warning = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        warning_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        warning_selected = {
          bg = lch_bufferline_colors.selected_bg,
          bold = true,
        },
        warning_diagnostic = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        warning_diagnostic_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        warning_diagnostic_selected = {
          bg = lch_bufferline_colors.selected_bg,
          bold = true,
        },
        error = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        error_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        error_selected = {
          bg = lch_bufferline_colors.selected_bg,
          bold = true,
        },
        error_diagnostic = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        error_diagnostic_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        error_diagnostic_selected = {
          bg = lch_bufferline_colors.selected_bg,
          bold = true,
        },
        modified = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        modified_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        modified_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.selected_fg,
          bold = true,
        },
        duplicate_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.selected_fg,
          bold = true,
        },
        duplicate_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        duplicate = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        separator_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.base_bg,
        },
        separator_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = lch_bufferline_colors.base_bg,
        },
        separator = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = lch_bufferline_colors.base_bg,
        },
        indicator_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        indicator_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.selected_fg,
        },
        pick_selected = {
          bg = lch_bufferline_colors.selected_bg,
          fg = lch_bufferline_colors.selected_fg,
        },
        pick_visible = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        pick = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        offset_separator = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
        trunc_marker = {
          bg = { attribute = "bg", highlight = "TabLine" },
          fg = { attribute = "fg", highlight = "TabLine" },
        },
      }

      --加载插件
      local bufferline = require('bufferline')
      bufferline.setup{
        highlights = lch_bufferline_highlights,
        options = {
          mode = "buffers",
          style_preset = bufferline.style_preset.no_italic,
          numbers = "ordinal",
          max_name_length = 15,
          max_prefix_length = 8,
          tab_size = 10,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          -- 左侧让出 nvim-tree 的位置
          offsets = {{
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Title",
              text_align = "left",
              separator = false
          }},
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = true,
          --slant：斜式，slope：坡式，thick：厚，thin：瘦
          separator_style = "slope",
        },
      }
    end,
    keys = {
      --快捷键绑定
      { "<S-Space><C-w>", mode = { "n" }, "<cmd>BufferLineCloseOthers<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Close Other Buffer" },
      { "<leader>tn", mode = { "n" }, "<cmd>enew<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: New Tab" },
      { "<Leader>bd", mode = { "n" }, "<cmd>BufferLinePickClose<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Close Pickup Buffer" },
      { "<Leader>bo", mode = { "n" }, "<cmd>BufferLineCloseOthers<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Close Other Buffer" },
      { "<TAB>1", mode = { "n" }, "<cmd>BufferLineGoToBuffer 1<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 1" },
      { "<TAB>2", mode = { "n" }, "<cmd>BufferLineGoToBuffer 2<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 2" },
      { "<TAB>3", mode = { "n" }, "<cmd>BufferLineGoToBuffer 3<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 3" },
      { "<TAB>4", mode = { "n" }, "<cmd>BufferLineGoToBuffer 4<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 4" },
      { "<TAB>5", mode = { "n" }, "<cmd>BufferLineGoToBuffer 5<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 5" },
      { "<TAB>6", mode = { "n" }, "<cmd>BufferLineGoToBuffer 6<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 6" },
      { "<TAB>7", mode = { "n" }, "<cmd>BufferLineGoToBuffer 7<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 7" },
      { "<TAB>8", mode = { "n" }, "<cmd>BufferLineGoToBuffer 8<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 8" },
      { "<TAB>9", mode = { "n" }, "<cmd>BufferLineGoToBuffer 9<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 9" },
	  { "<TAB>0", mode = { "n" }, "<cmd>BufferLineGoToBuffer 10<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 10" },
      { "<Leader>1", mode = { "n" }, "<cmd>BufferLineGoToBuffer 1<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 1" },
      { "<Leader>2", mode = { "n" }, "<cmd>BufferLineGoToBuffer 2<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 2" },
      { "<Leader>3", mode = { "n" }, "<cmd>BufferLineGoToBuffer 3<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 3" },
      { "<Leader>4", mode = { "n" }, "<cmd>BufferLineGoToBuffer 4<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 4" },
      { "<Leader>5", mode = { "n" }, "<cmd>BufferLineGoToBuffer 5<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 5" },
      { "<Leader>6", mode = { "n" }, "<cmd>BufferLineGoToBuffer 6<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 6" },
      { "<Leader>7", mode = { "n" }, "<cmd>BufferLineGoToBuffer 7<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 7" },
      { "<Leader>8", mode = { "n" }, "<cmd>BufferLineGoToBuffer 8<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 8" },
      { "<Leader>9", mode = { "n" }, "<cmd>BufferLineGoToBuffer 9<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 9" },
	  { "<Leader>10", mode = { "n" }, "<cmd>BufferLineGoToBuffer 10<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Buffer 10" },
      { "<Leader>bn", mode = { "n" }, "<cmd>BufferLineCycleNext<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Next Buffer" },
      { "<Leader>bp", mode = { "n" }, "<cmd>BufferLineCyclePrev<cr>", noremap = true, silent = true, nowait = true, desc = "bufferline: Goto Prev Buffer" },
    },
  },
}
