return {
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
    },
    config = function()

      --自定义是tab还是space
      local function LuaLineTabSpaceIndent()
        local space_pat = [[\v^ +]]
        local tab_pat = [[\v^\t+]]
        local space_indent = vim.fn.search(space_pat, 'nwc')
        local tab_indent = vim.fn.search(tab_pat, 'nwc')
        local mixed = (space_indent > 0 and tab_indent > 0)
        local mixed_same_line
        if not mixed then
          mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
          mixed = mixed_same_line > 0
        end
        if not mixed then return '' end
        if mixed_same_line ~= nil and mixed_same_line > 0 then
           return 'MixedLine:'..mixed_same_line
        end
        local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
        local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
        if space_indent_cnt > tab_indent_cnt then
          return 'MixedLine:'..tab_indent
        else
          return 'MixedLine:'..space_indent
        end
      end

      local lch_lualine_colors = {
        mode_normal_fg  = '#000010',
        mode_normal_bg  = '#78a2f3',
        mode_insert_fg  = '#000010',
        mode_insert_bg  = '#ffff00',
        mode_visual_fg  = '#000010',
        mode_visual_bg  = '#00ff87',
        mode_replace_fg = '#ffffff',
        mode_replace_bg = '#d70000',
        mode_command_fg = '#000010',
        mode_command_bg = '#b8bb26',
        file_name_fg    = '#c3cef7',
        file_name_bg    = '#292e41',
        status_line_fg  = '#dfffe3',
        status_line_bg  = '#444444',
        inactive_left_fg   = '#5c6370',
        inactive_left_bg   = '#282c34',
        inactive_middle_fg = '#5c6370',
        inactive_middle_bg = '#2c323d',
        inactive_right_fg  = '#5c6370',
        inactive_right_bg  = '#282c34',
      }
      local custom_gruvbox = require'lualine.themes.gruvbox'
      custom_gruvbox = {
        normal = {
          a = { fg = lch_lualine_colors.mode_normal_fg, bg = lch_lualine_colors.mode_normal_bg, gui = 'bold' },
          b = { fg = lch_lualine_colors.file_name_fg, bg = lch_lualine_colors.file_name_bg },
          c = { fg = lch_lualine_colors.status_line_fg, bg = lch_lualine_colors.status_line_bg },
        },
        insert = {
          a = { fg = lch_lualine_colors.mode_insert_fg, bg = lch_lualine_colors.mode_insert_bg, gui = 'bold' },
          b = { fg = lch_lualine_colors.file_name_fg, bg = lch_lualine_colors.file_name_bg },
          c = { fg = lch_lualine_colors.status_line_fg, bg = lch_lualine_colors.status_line_bg },
        },
        visual = {
          a = { fg = lch_lualine_colors.mode_visual_fg, bg = lch_lualine_colors.mode_visual_bg, gui = 'bold' },
          b = { fg = lch_lualine_colors.file_name_fg, bg = lch_lualine_colors.file_name_bg },
          c = { fg = lch_lualine_colors.status_line_fg, bg = lch_lualine_colors.status_line_bg },
        },
        replace = {
          a = { fg = lch_lualine_colors.mode_replace_fg, bg = lch_lualine_colors.mode_replace_bg, gui = 'bold' },
          b = { fg = lch_lualine_colors.file_name_fg, bg = lch_lualine_colors.file_name_bg },
          c = { fg = lch_lualine_colors.status_line_fg, bg = lch_lualine_colors.status_line_bg },
        },
        command = {
          a = { fg = lch_lualine_colors.mode_command_fg, bg = lch_lualine_colors.mode_command_bg, gui = 'bold' },
          b = { fg = lch_lualine_colors.file_name_fg, bg = lch_lualine_colors.file_name_bg },
          c = { fg = lch_lualine_colors.status_line_fg, bg = lch_lualine_colors.status_line_bg },
        },
        inactive = {
          a = { fg = lch_lualine_colors.inactive_left_fg, bg = lch_lualine_colors.inactive_left_bg },
          b = { fg = lch_lualine_colors.inactive_middle_fg, bg = lch_lualine_colors.inactive_middle_bg },
          c = { fg = lch_lualine_colors.inactive_right_fg, bg = lch_lualine_colors.inactive_right_bg },
        },
      }

      --加载插件
      require('lualine').setup {
        options = {
          theme = custom_gruvbox,
          component_separators = '|',
          section_separators = { left = vim.g.statusTabLineSeparatorBubbleLeft, right = vim.g.statusTabLineSeparatorBubbleRight },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              separator = { left = vim.g.statusTabLineSeparatorBubbleRight, right = vim.g.statusTabLineSeparatorBubbleLeft },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_b = {
            {
              'filename',
              file_status = true,
              newfile_status = true,
              path = 3,
              symbols = {
                --modified = '●',
                modified = '[+]',
                --readonly = '[-]',
                readonly = vim.g.fileReadOnlyIcon,
                unnamed = '[NoName]',
                newfile = '[NoName]',
              },
            },
            {
              'diagnostics',
            },
          },
          --lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {},
          lualine_x = {
            {
              function()
                -- 使用lsp-progress.nvim
                return require('lsp-progress').progress({
                  max_size = 80,
                  format = function(messages)
                    local active_clients = vim.lsp.get_active_clients()
                    if #messages > 0 then
                      return table.concat(messages, " ")
                    end
                    local client_names = {" [LSP]"}
                    for _, client in ipairs(active_clients) do
                      if client and client.name ~= "" then
                        --table.insert(client_names, 1, client.name)
                        table.insert(client_names, client.name)
                      end
                    end
                    return table.concat(client_names, " : ")
                  end,
                })
              end,
              padding = { left = 2, right = 2 },
              color = { fg = '#f39c12', bg = '#444444', gui = 'bold' }
            },
            {
              'overseer',
            },
            {
              LuaLineTabSpaceIndent,
              padding = { left = 2, right = 2 }
            },
            {
              'fileformat',
              --color = { fg = '#ff0000' },
              symbols = {
                --unix = '', -- e712
                unix = '', -- ubuntu f31b
                --unix = '', -- debian e77d
                dos = '',  -- e70f
                mac = '',  -- e711
              },
              padding = { left = 2, right = 2 }
            },
            {
              'encoding',
              padding = { left = 2, right = 2 }
            },
            {
              'filetype',
              icon = { align = 'right' },
              padding = { left = 2, right = 2 }
            },
          },
          lualine_y = {
            {
              'progress',
              separator = { left = vim.g.statusTabLineSeparatorBubbleRight },
              padding = { left = 2, right = 2 },
            },
          },
          lualine_z = {
            {
              'location',
              color = { gui = 'bold' },
              separator = { left = vim.g.statusTabLineSeparatorBubbleRight, right = vim.g.statusTabLineSeparatorBubbleLeft },
              padding = { left = 1, right = 1 },
            },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {
          'quickfix',
          --'nvim-tree',
          'symbols-outline',
          'toggleterm',
        },
      }

    end,
  },
}
