--配置路径为 %LOCALAPPDATA%\nvim\lua
-- 加载azy.nvim插件设置
--https://github.com/folke/lazy.nvim
--https://lazy.folke.io/

-- 启动 lazy.nvim
local lazypath = vim.g.lazy_nvim_path
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = vim.g.github_url .. "/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--depth=1", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 设定 lazy.nvim
require("lazy").setup({
  spec = {
    -- 导入插件（在plugins目录下的lua会全部导入）
    { import = "plugins" },
  },
  -- 在此处配置任何其他设置。有关更多详细信息，请参阅文档。
  -- 插件安装路径
  root = vim.g.lazy_nvim_root,
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
  lockfile = vim.g.lazy_nvim_root .. "/lazy-lock.json",
  git = {
    log = { "-1" }, -- show the last 1 commits
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = vim.g.github_url .."/%s.git",
  },
  pkg = {
    enabled = false,
    cache = vim.g.lazy_nvim_root .. "/pkg-cache.lua",
  },
  rocks = {
    root = vim.g.lazy_nvim_root .. "/lazy-rocks",
    server = "https://nvim-neorocks.github.io/rocks-binaries/",
  },
  -- 安装插件时将使用的配色方案。
  install = { colorscheme = { "tokyonight", "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
  readme = {
    root = vim.g.lazy_nvim_root .. "/readme",
  },
  state = vim.g.lazy_nvim_root .. "/state.json", -- state info for checker and other thing
})

--设定快捷键
vim.keymap.set('n', '<leader>lz', '<cmd>Lazy<cr>', {noremap = true, desc = "Lazy.nvim Home"})
