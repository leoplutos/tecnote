--statusbar.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--lualine.nvim插件设置
--bufferline.nvim插件设置
--https://github.com/nvim-lualine/lualine.nvim
--https://github.com/akinsho/bufferline.nvim

-- 加载插件
vim.cmd('packadd lualine.nvim')
vim.cmd('packadd bufferline.nvim')

--自定义Lsp状态显示
local function LuaLineLspStatus()
  local lspMsgLable = ''
  if vim.g.g_use_nerdfont == 0 then
    lspMsgLable = '  LSP : '
  else
    lspMsgLable = ' ' .. vim.g.lspTitleIcon .. '  LSP : '
  end
  local lspMsgContent = ''
  if vim.fn.exists('*GetLspStatus') == 1 then
    lspMsgContent = vim.fn.GetLspStatus()
    if vim.g.g_use_nerdfont == 0 then
    else
      if lspMsgContent == 'running' then
        lspMsgContent = vim.g.lspStatusOk
      else
      end
    end
  else
    if vim.g.g_use_nerdfont == 0 then
      lspMsgContent = '❌'
    else
      lspMsgContent = vim.g.lspStatusNg
    end
  end
  return lspMsgLable .. lspMsgContent
end

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

--启动lualine
require('lualine').setup {
  options = {
    --theme = lch_lualine_theme,
    --lch是自定义主题，需要手动复制文件
    theme = 'lch',
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
        LuaLineLspStatus,
        padding = { right = 2 },
        color = { fg = '#f7f7f0', bg = '#545c7c' }
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

--启动bufferline
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
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    --slant：斜式，slope：坡式，thick：厚，thin：瘦
    separator_style = "slope",
  },
}

--添加快捷键绑定
vim.cmd([[
noremap <Leader>q :call CloseTab()<CR>
"在关闭Tab的同时关闭Buffer，并且关闭所有其他无用的Buffer
function! CloseTab() abort
  bd
  BufferLineGoToBuffer 1
endfunction
]])
vim.keymap.set('n', '<S-Space><C-w>', ':BufferLineCloseOthers<CR>', { noremap = true })
vim.keymap.set('n', '<leader>tn',     ':enew<CR>',                  { noremap = true })
vim.keymap.set('n', '<Leader>bd',     ':BufferLinePickClose<CR>',   { noremap = true })
vim.keymap.set('n', '<Leader>bo',     ':BufferLineCloseOthers<CR>', { noremap = true })
vim.keymap.set('n', '<TAB>1',         ':BufferLineGoToBuffer 1<CR>',{ noremap = true })
vim.keymap.set('n', '<TAB>2',         ':BufferLineGoToBuffer 2<CR>',{ noremap = true })
vim.keymap.set('n', '<TAB>3',         ':BufferLineGoToBuffer 3<CR>',{ noremap = true })
vim.keymap.set('n', '<TAB>4',         ':BufferLineGoToBuffer 4<CR>',{ noremap = true })
vim.keymap.set('n', '<TAB>5',         ':BufferLineGoToBuffer 5<CR>',{ noremap = true })
vim.keymap.set('n', '<TAB>6',         ':BufferLineGoToBuffer 6<CR>',{ noremap = true })
vim.keymap.set('n', '<TAB>7',         ':BufferLineGoToBuffer 7<CR>',{ noremap = true })
vim.keymap.set('n', '<TAB>8',         ':BufferLineGoToBuffer 8<CR>',{ noremap = true })
vim.keymap.set('n', '<TAB>9',         ':BufferLineGoToBuffer 9<CR>',{ noremap = true })
vim.keymap.set('n', '<TAB>0',         ':BufferLineGoToBuffer 10<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>1',      ':BufferLineGoToBuffer 1<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>2',      ':BufferLineGoToBuffer 2<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>3',      ':BufferLineGoToBuffer 3<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>4',      ':BufferLineGoToBuffer 4<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>5',      ':BufferLineGoToBuffer 5<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>6',      ':BufferLineGoToBuffer 6<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>7',      ':BufferLineGoToBuffer 7<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>8',      ':BufferLineGoToBuffer 8<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>9',      ':BufferLineGoToBuffer 9<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>0',      ':BufferLineGoToBuffer 10<CR>',{ noremap = true })
vim.keymap.set('n', '<Leader>bn',     ':BufferLineCycleNext<CR>',    { noremap = true })
vim.keymap.set('n', '<Leader>bp',     ':BufferLineCyclePrev<CR>',    { noremap = true })
--vim.keymap.set('n', '<Leader>bf',     ':BufferLineMoveNext<CR>',    { noremap = true })
--vim.keymap.set('n', '<Leader>bl',     ':BufferLineMovePrev<CR>',    { noremap = true })
