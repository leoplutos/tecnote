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
  status_line_fg  = '#1c1c1c',
  status_line_bg  = '#f0f0f0',
  inactive_left_fg   = '#fafafa',
  inactive_left_bg   = '#d0d0d0',
  inactive_middle_fg = '#d0d0d0',
  inactive_middle_bg = '#f0f0f0',
  inactive_right_fg  = '#fafafa',
  inactive_right_bg  = '#d0d0d0',
}

return {
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
