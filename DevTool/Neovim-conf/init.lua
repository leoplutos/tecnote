--init.lua for neovim
--配置路径为
-- Windows：%LOCALAPPDATA%\nvim
-- Linux：/home/lchuser/work/lch/rc/nvimrc

--设置语言
--vim.api.nvim_exec('language zh_CN', true)
--vim.api.nvim_exec('language message zh_CN.UTF-8', true)

if vim.g.vscode then
  --VSCode插件设置

  vim.api.nvim_exec('filetype off', true)
  vim.api.nvim_exec('filetype plugin indent off', true)
  vim.api.nvim_exec('filetype plugin off', true)
  vim.api.nvim_exec('filetype indent off', true)
  vim.api.nvim_exec('set whichwrap+=<,>,h,l,[,]', true)

  vim.g.mapleader = "\\"
  vim.keymap.set({"n", "v"}, "J", "10j", { noremap = true })
  vim.keymap.set({"n", "v"}, "K", "10k", { noremap = true })
  vim.keymap.set({"i"}, "<C-j>", "<down>", { noremap = true })
  vim.keymap.set({"i"}, "<C-h>", "<left>", { noremap = true })
  vim.keymap.set({"i"}, "<C-a>", "<C-o>^", { noremap = true })
  vim.keymap.set({"n", "v"}, "<C-z>", "u", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>q", "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>s", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>1", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex1')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>2", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex2')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>3", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex3')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>4", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex4')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>5", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex5')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>6", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex6')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>7", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex7')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>8", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex8')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>9", "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex9')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>e", "<Cmd>call VSCodeNotify('workbench.action.focusSideBar')<CR>", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>ca", "ggVG\"+y", { noremap = true })
  vim.keymap.set({"n", "v"}, "<leader>a", "<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>", { noremap = true })

  --设定使用im-select自动切换输入法
  vim.cmd([[
  augroup VSCodeImSelectGroup
    autocmd!
    autocmd VimEnter * :silent :!D:\\Tools\\WorkTool\\Text\\im-select\\x64\\im-select.exe 1033
    autocmd InsertEnter * :silent :!D:\\Tools\\WorkTool\\Text\\im-select\\x64\\im-select.exe 2052
    autocmd InsertLeave * :silent :!D:\\Tools\\WorkTool\\Text\\im-select\\x64\\im-select.exe 1033
    autocmd VimLeave * :silent :!D:\\Tools\\WorkTool\\Text\\im-select\\x64\\im-select.exe 2052
  augroup END
  ]])

else
  --默认neovim设置

  --判断运行环境
  if (vim.fn.has('win32') == 1 or vim.fn.has('win95') == 1 or vim.fn.has('win64') == 1 or vim.fn.has('win16') == 1 or vim.fn.has('win32unix') == 1) then
    --Windows
    --加载vim的vimrc配置
    vim.cmd('source ~\\.vimrc')
    --设置package.path路径以便加载lua文件夹下的内容
    package.path = package.path ..';..\\?.lua'
  elseif (vim.fn.has('macunix') == 1) then
    --MacOS
  else
    --Linux
    --加载vim的vimrc配置
    vim.cmd('source ~/work/lch/rc/vimrc/.vimrc')
    --全局变量g:g_nvimrc_file_path（当前init.lua的所在路径）
    vim.g.g_nvimrc_file_path = vim.fn.expand("<sfile>:p:h")
    --设置package.path路径以便加载lua文件夹下的内容
    package.path = package.path ..';../?.lua'
    package.path = package.path ..';./lua/?.lua'
    package.path = package.path .. ';' .. vim.g.g_nvimrc_file_path .. '/?.lua'
    package.path = package.path .. ';' .. vim.g.g_nvimrc_file_path .. '/lua/?.lua'
    vim.o.packpath = vim.o.packpath .. ',' .. vim.g.g_nvimrc_file_path
    vim.o.packpath = vim.o.packpath .. ',' .. vim.g.g_nvimrc_file_path .. '/after'
  end

  vim.o.ambiwidth='single'

  -- 开启gui高亮
  vim.opt.termguicolors = true
  vim.opt.jumpoptions = 'stack'
  vim.g.mapleader = "\\"
  --设定neovim终端的ANCI颜色（注释掉，在lch-dark.vim中设定）
  --vim.g.terminal_color_0  = '#2e3436'
  --vim.g.terminal_color_1  = '#cc0000'
  --vim.g.terminal_color_2  = '#4e9a06'
  --vim.g.terminal_color_3  = '#c4a000'
  --vim.g.terminal_color_4  = '#3465a4'
  --vim.g.terminal_color_5  = '#75507b'
  --vim.g.terminal_color_6  = '#0b939b'
  --vim.g.terminal_color_7  = '#d3d7cf'
  --vim.g.terminal_color_8  = '#555753'
  --vim.g.terminal_color_9  = '#ef2929'
  --vim.g.terminal_color_10 = '#8ae234'
  --vim.g.terminal_color_11 = '#fce94f'
  --vim.g.terminal_color_12 = '#729fcf'
  --vim.g.terminal_color_13 = '#ad7fa8'
  --vim.g.terminal_color_14 = '#00f5e9'
  --vim.g.terminal_color_15 = '#eeeeec'

  -- 加载lua/tree.lua
  require('tree')
  -- 加载lua/webdevicons.lua
  --require('webdevicons')
  if (vim.g.g_lsp_type == 3) then
    -- 加载coc.vim - 使用coc.nvim
    local cocvim_path = vim.g.g_s_rcfilepath .. '/vimconf/init/coc.vim'
    vim.cmd('source ' .. cocvim_path)
  else
    -- 加载lua/lsp.lua - 使用内置LSP
    require('lsp')
  end
  -- 加载lua/treesitter.lua
  require('treesitter')
  -- 加载lua/outline.lua
  require('outline')
  -- 加载lua/finder.lua
  require('finder')
  -- 加载lua/indent.lua
  require('indent')
  -- 加载lua/quickmove.lua
  require('quickmove')
  -- 加载lua/statusbar.lua
  require('statusbar')
  -- 加载lua/terminal.lua
  require('terminal')
  -- 加载lua/startmenu.lua
  require('startmenu')
  -- 加载lua/debugger.lua
  require('debugger')
  -- 加载lua/imselect.lua
  require('imselect')

  -- 加载tokyonight.nvim
  --vim.cmd('packadd tokyonight.nvim')
  --vim.cmd('colorscheme tokyonight-storm')
  --vim.cmd('colorscheme tokyonight-day')

  if vim.g.neovide then
    -- GUI前端Neovide的设定
    -- vim.o.guifont = "等距更纱黑体_SC_Nerd_Font,Sarasa_Mono_SC_Nerd_Font,等距更纱黑体_SC,Sarasa_Mono_SC,更紗等幅ゴシック_J__Nerd_Font,Sarasa_Mono_J_Nerd_Font,更紗等幅ゴシック_J:h12"
    vim.o.guifont = "等距更纱黑体_SC_Nerd_Font:h12:cANSI,更紗等幅ゴシック_J_Nerd_Font:h12:cANSI,等距更纱黑体_SC:h12:cANSI,更紗等幅ゴシック_J:h12:cANSI,Inconsolata:h12:cANSI,JetBrains_Mono:h12:cANSI"
    vim.o.guifontwide = "等距更纱黑体_SC_Nerd_Font:h12:cGB2312,更紗等幅ゴシック_J_Nerd_Font:h12:cSHIFTJIS,等距更纱黑体_SC:h12:cGB2312,更紗等幅ゴシック_J:h12:cSHIFTJIS,Microsoft_YaHei:h12:cGB2312,Microsoft_YaHei_UI:h12:cGB2312,SimSun:h12:cGB2312,新宋体:h12:cGB2312,ＭＳ_ゴシック:h12:cSHIFTJIS,MS_Gothic:h12:cSHIFTJIS"
    -- 设置光标样式和高亮组
    vim.o.guicursor= "n-v-sm:block-Cursor,i-c-ci-ve:ver30-iCursor-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20-iCursor-blinkwait300-blinkon200-blinkoff150"
    vim.opt.linespace = 0
    -- vim.g.neovide_scale_factor = 1.0
    -- vim.g.neovide_padding_top = 0
    -- vim.g.neovide_padding_bottom = 0
    -- vim.g.neovide_padding_right = 0
    -- vim.g.neovide_padding_left = 0
    -- vim.g.neovide_floating_blur_amount_x = 2.0
    -- vim.g.neovide_floating_blur_amount_y = 2.0
    -- vim.g.neovide_transparency = 0.8
    -- vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_hide_mouse_when_typing = true
    -- vim.g.neovide_underline_automatic_scaling = false
    -- vim.g.neovide_theme = 'auto'
    -- vim.g.neovide_refresh_rate = 60
    -- vim.g.neovide_refresh_rate_idle = 5
    -- vim.g.neovide_no_idle = true
    vim.g.neovide_confirm_quit = true
     -- vim.g.neovide_fullscreen = true
    -- vim.g.neovide_remember_window_size = true
    -- vim.g.neovide_profiler = false
    -- vim.g.neovide_input_macos_alt_is_meta = false
    -- vim.g.neovide_input_ime = true
    -- vim.g.neovide_touch_deadzone = 6.0
    -- vim.g.neovide_touch_drag_timeout = 0.17
    -- vim.g.neovide_cursor_animation_length = 0.13
    -- vim.g.neovide_cursor_trail_size = 0.8
    -- vim.g.neovide_cursor_antialiasing = true
    -- vim.g.neovide_cursor_animate_in_insert_mode = true
    -- vim.g.neovide_cursor_animate_command_line = true
    -- vim.g.neovide_cursor_unfocused_outline_width = 0.125
    -- vim.g.neovide_cursor_vfx_mode = ""
    -- vim.g.neovide_cursor_vfx_mode = "railgun"
    -- vim.g.neovide_cursor_vfx_mode = "torpedo"
    -- vim.g.neovide_cursor_vfx_mode = "pixiedust"
    -- vim.g.neovide_cursor_vfx_mode = "sonicboom"
    -- vim.g.neovide_cursor_vfx_mode = "ripple"
    -- vim.g.neovide_cursor_vfx_mode = "wireframe"
    -- vim.g.neovide_cursor_vfx_opacity = 200.0
    -- vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
    -- vim.g.neovide_cursor_vfx_particle_density = 7.0
    -- vim.g.neovide_cursor_vfx_particle_speed = 10.0
    -- vim.g.neovide_cursor_vfx_particle_phase = 1.5
    -- vim.g.neovide_cursor_vfx_particle_curl = 1.0

    -- 添加快捷键绑定
    -- Shift+Insert：粘贴
    vim.keymap.set({"c", "i"}, "<S-Insert>", "<C-R>+", { noremap = true })
  end

end
