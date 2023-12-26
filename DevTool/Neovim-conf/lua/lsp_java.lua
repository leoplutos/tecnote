--lsp_java.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--Java的Lsp特殊设定，支持jar/class文件的内容显示
--设定参考 https://github.com/mfussenegger/nvim-jdtls/blob/master/lua/jdtls.lua

--支持jdt://协议
vim.cmd [[
  au BufReadCmd jdt://* lua open_classfile(vim.fn.expand('<amatch>'))
  au BufReadCmd *.class lua open_classfile(vim.fn.expand("<amatch>"))
]]

--- Open `jdt://` uri or decompile class contents and load them into the buffer
---
--- nvim-jdtls by defaults configures a `BufReadCmd` event which uses this function.
--- You shouldn't need to call this manually.
---
---@param fname string
function open_classfile(fname)
  local uri
  local use_cmd
  if vim.startswith(fname, "jdt://") then
    uri = fname
    use_cmd = false
  else
    uri = vim.uri_from_fname(fname)
    use_cmd = true
    if not vim.startswith(uri, "file://") then
      return
    end
  end
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].modifiable = true
  vim.bo[buf].swapfile = false
  vim.bo[buf].buftype = 'nofile'
  -- This triggers FileType event which should fire up the lsp client if not already running
  vim.bo[buf].filetype = 'java'
  local timeout_ms = 5000
  vim.wait(timeout_ms, function()
    return next(vim.lsp.get_clients({ name = "jdtls", bufnr = buf })) ~= nil
  end)
  --local client = vim.lsp.get_clients({ name = "jdtls", bufnr = buf })[1]
  local client = vim.lsp.get_active_clients()[1]
  assert(client, 'Must have a `jdtls` client to load class file or jdt uri')

  local content
  local function handler(err, result)
    assert(not err, vim.inspect(err))
    content = result
    local normalized = string.gsub(result, '\r\n', '\n')
    local source_lines = vim.split(normalized, "\n", { plain = true })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, source_lines)
    vim.bo[buf].modifiable = false
  end

  if use_cmd then
    local command = {
      command = "java.decompile",
      arguments = { uri }
    }
    execute_command(command, handler)
  else
    local params = {
      uri = uri
    }
    --vim.notify(vim.inspect(client))
    --vim.notify(vim.inspect(params))
    --vim.notify(vim.inspect(handler))
    --vim.notify(vim.inspect(buf))
    client.request("java/classFileContents", params, handler, buf)
  end
  -- Need to block. Otherwise logic could run that sets the cursor to a position
  -- that's still missing.
  vim.wait(timeout_ms, function() return content ~= nil end)
end
