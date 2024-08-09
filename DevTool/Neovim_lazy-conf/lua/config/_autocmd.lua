--配置路径为 %LOCALAPPDATA%\nvim\lua
-- 自动命令注册

-- auto change root
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ctx)
    local root_path = vim.fs.root(ctx.buf, vim.g.g_s_rootmarkers)
    if root_path and root_path ~= "." and root_path ~= vim.fn.getcwd() then
      ---@diagnostic disable-next-line: undefined-field
      vim.cmd.cd(root_path)
      vim.notify("Set CWD to " .. root_path)
    end
  end,
})

