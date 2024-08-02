return {
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    version = "*",
    event = "VeryLazy",
    priority = 53,
    opts = {
    },
    config = function()

      --支持jdt://协议，以可以打开jar文件和class文件
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

      --设定浮动窗口样式
      -- none/single/double/rounded/solid/shadow
      local _border = "rounded"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = _border,
          --title = "hover"
        }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = _border,
        }
      )
      vim.diagnostic.config{
        float={border=_border}
      }
      require('lspconfig.ui.windows').default_options = {
        border = _border
      }

      -- 当前缓冲区的快捷键绑定
      vim.api.nvim_create_augroup('UserLspConfig', { clear = true })
      vim.api.nvim_clear_autocmds { group = 'UserLspConfig' }
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          vim.bo[args.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local function opts(desc)
            return { desc = "LSP: " .. desc, buffer = args.buf, noremap = true, silent = true, nowait = true }
          end
          --vim.keymap.set('n', '<Space>lo', vim.diagnostic.setloclist, opts)
          vim.keymap.set('n', '<Space>td', require('telescope.builtin').diagnostics, opts('Telescope Diagnostics'))
          vim.keymap.set('n', '<Space>lc', '<cmd>lclose<CR>', opts('Close Diagnostics'))
          vim.keymap.set({ 'n', 'v' }, '<Space>ca', vim.lsp.buf.code_action, opts('Code Action'))
          --vim.keymap.set('n', '<Space>gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', '<Space>gd', require('telescope.builtin').lsp_definitions, opts('Definitions'))
          --vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
          --vim.keymap.set('n', '<Space>gs', vim.lsp.buf.document_symbol, opts)
          vim.keymap.set('n', '<Space>ts', require('telescope.builtin').lsp_document_symbols, opts('Search Document Symbols'))
          --vim.keymap.set('n', '<Space>gS', vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set('n', '<Space>tw', require('telescope.builtin').lsp_workspace_symbols, opts('Search  Workspace Symbols'))
          vim.keymap.set('n', '<Space>ws', vim.lsp.buf.workspace_symbol, opts('Search  Workspace Symbols'))
          vim.keymap.set('n', '<Space>gr', vim.lsp.buf.references, opts('References'))
          --vim.keymap.set('n', '<Space>gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<Space>gi', require('telescope.builtin').lsp_implementations, opts('Implementations'))
          --vim.keymap.set('n', '<Space>gt', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<Space>gt', require('telescope.builtin').lsp_type_definitions, opts('Type Definitions'))
          vim.keymap.set('n', '<Space>gr', vim.lsp.buf.rename, opts('Rename'))
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts('Rename'))
          vim.keymap.set('n', '<Space>h', vim.lsp.buf.hover, opts('Hover'))
          --vim.keymap.set('n', '<C-UP>', vim.lsp.buf.references, opts)
          --vim.keymap.set('n', '<C-Down>', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<Space>fm', function()
            vim.lsp.buf.format { async = true }
          end, opts('Format'))
          vim.keymap.set('n', '<Space>gD', vim.lsp.buf.declaration, opts('Declaration'))
          vim.keymap.set('n', '<Space>gh', vim.lsp.buf.signature_help, opts('Signature Help'))
          --vim.keymap.set('n', '<Space>ic', vim.lsp.buf.incoming_calls, opts)
          vim.keymap.set('n', '<Space>ic', require('telescope.builtin').lsp_incoming_calls, opts('Incoming Calls'))
          --vim.keymap.set('n', '<Space>oc', vim.lsp.buf.outgoing_calls, opts)
          vim.keymap.set('n', '<Space>oc', require('telescope.builtin').lsp_outgoing_calls, opts('Outgoing Calls'))
          --vim.keymap.set('n', '<Space>wa', vim.lsp.buf.add_workspace_folder, opts)
          --vim.keymap.set('n', '<Space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<Space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts('List Workspace Folders'))
          vim.keymap.set('n', '<Space>ih', function()
            --vim.lsp.inlay_hint(0)
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}), {})
          end, opts('Toggle InlayHints'))

          --取得当前生效的LspClient对象
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          --开启Inlay Hints
          if vim.fn.has('nvim-0.10') == 1 then
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint(args.buf, true)
            end
          end

        --当前选中符号的高亮设定
        --需要设定updatetime为100毫秒
        vim.cmd([[
          setlocal updatetime=100
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
            "autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]])

        end,
        group = 'UserLspConfig',
      })

      --Lsp相关的高亮设定
      --:sign list 查看所有定义
      vim.fn.sign_define("DiagnosticSignError", {text=vim.g.diagnosticsErrorIcon, texthl="DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn", {text=vim.g.diagnosticsWarnIcon, texthl="DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo", {text=vim.g.diagnosticsInfoIcon, texthl="DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint", {text=vim.g.diagnosticsHintrIcon, texthl="DiagnosticSignHint"})

      -- diagnostics设定
      vim.diagnostic.config({
          virtual_text = true,
          underline = true,
          float = {
              source = "always",
          },
          severity_sort = true,
          virtual_text = {
            --prefix = "→",
            prefix = vim.g.virtualTextPrefixIcon,
            spacing = 4,
          },
          signs = true,
          update_in_insert = false,
      })

    end,
    keys = {
      --快捷键绑定
      { "<C-F2>", mode = { "n" }, '<cmd>LspInfo<cr>', noremap = true, silent = true, nowait = true, desc = "LSP: Info" },
      { "<Leader>ls", mode = { "n" }, '<cmd>LspInfo<cr>', noremap = true, silent = true, nowait = true, desc = "LSP: Info" },
      { "<Space>q", mode = { "n" }, vim.diagnostic.setloclist, noremap = true, silent = true, nowait = true, desc = "LSP: Toggle Diagnostics" },
      { "<Space>e", mode = { "n" }, vim.diagnostic.open_float, noremap = true, silent = true, nowait = true, desc = "LSP: Open Float Diagnostics" },
      { "<C-j>", mode = { "n" }, vim.diagnostic.goto_next, noremap = true, silent = true, nowait = true, desc = "LSP: Next Diagnostics" },
      { "<C-k>", mode = { "n" }, vim.diagnostic.goto_prev, noremap = true, silent = true, nowait = true, desc = "LSP: Prev Diagnostics" },
    },
  }
}
