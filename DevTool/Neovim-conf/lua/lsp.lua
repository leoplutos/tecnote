--lsp.lua
--配置路径为 %LOCALAPPDATA%\nvim\lua
--nvim-lspconfig插件设置
--https://github.com/neovim/nvim-lspconfig
--https://github.com/hrsh7th/nvim-cmp
--https://github.com/hrsh7th/cmp-nvim-lsp
--https://github.com/hrsh7th/cmp-buffer
--https://github.com/hrsh7th/cmp-path
--https://github.com/hrsh7th/cmp-cmdline
--https://github.com/uga-rosa/cmp-dictionary
--https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
--https://github.com/onsails/lspkind.nvim
--https://github.com/hrsh7th/cmp-vsnip
--https://github.com/hrsh7th/vim-vsnip
--设定参数参考 https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- 加载nvim-lspconfig插件
vim.cmd('packadd nvim-lspconfig')
-- 加载nvim-cmp插件（自动完成内核）
vim.cmd('packadd nvim-cmp')
-- 加载cmp-nvim-lsp插件（自动完成内容-LSP）
vim.cmd('packadd cmp-nvim-lsp')
-- 加载cmp-buffer插件（自动完成内容-Buffer）
vim.cmd('packadd cmp-buffer')
-- 加载cmp-path插件（自动完成内容-文件夹名和文件名）
vim.cmd('packadd cmp-path')
-- 加载cmp-cmdline插件（自动完成内容-命令模式）
vim.cmd('packadd cmp-cmdline')
-- 加载cmp-dictionary插件（自动完成内容-自定义词典）
vim.cmd('packadd cmp-dictionary')
-- 加载cmp-nvim-lsp-signature-help插件（自动完成内容-LSP符号帮助）
vim.cmd('packadd cmp-nvim-lsp-signature-help')
-- 加载lspkind.nvim插件（在代码提示中，显示分类的小图标支持）
vim.cmd('packadd lspkind.nvim')
-- 加载cmp-vsnip插件（代码片段）
vim.cmd('packadd cmp-vsnip')
vim.cmd('packadd vim-vsnip')

local lsp_cmd_path = {}
--根据OS设定LSP服务命令
if (vim.g.g_i_osflg == 1 or vim.g.g_i_osflg == 2 or vim.g.g_i_osflg == 3) then
  lsp_cmd_path.jdtls_jar_path = 'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar'
  lsp_cmd_path.jdtls_config_path = 'D:/Tools/WorkTool/Java/lsp/jdt-language-server-1.26.0-202307271613/config_win'
  lsp_cmd_path.maven_setting_path = 'D:/Tools/WorkTool/Java/apache-maven-3.9.4/conf/settings.xml'
  lsp_cmd_path.vue_lsp_cmd = 'vue-language-server.cmd'
  lsp_cmd_path.typescript_tsdk_path = 'D:/Tools/WorkTool/NodeJs/node-v18.17.1-win-x64/node_global/node_modules/typescript/lib'
  lsp_cmd_path.cobol_lsp_jar_path = 'D:/Tools/WorkTool/Cobol/cobol-language-support-1.2.1/extension/server/jar/server.jar'
  lsp_cmd_path.kotlin_lsp_cmd = 'kotlin-language-server.bat'
else
  lsp_cmd_path.jdtls_jar_path = '/home/lchuser/work/lch/tool/lsp/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar'
  lsp_cmd_path.jdtls_config_path = '/home/lchuser/work/lch/tool/lsp/jdtls/config_linux'
  lsp_cmd_path.maven_setting_path = '/usr/local/maven/apache-maven-3.9.4/conf/settings.xml'
  lsp_cmd_path.vue_lsp_cmd = 'vue-language-server'
  lsp_cmd_path.typescript_tsdk_path = '/usr/lib/node_modules/typescript/lib'
  lsp_cmd_path.cobol_lsp_jar_path = '/home/lchuser/work/lch/tool/lsp/cobol-language-support-1.2.1/extension/server/jar/server.jar'
  lsp_cmd_path.kotlin_lsp_cmd = 'kotlin-language-server'
end

--给状态栏设置的调用函数（返回LSP状态显示到状态栏）
--做一个全局dict保存每个lsp的服务状态，存在即为启动中
--内容示例 let g:nvim_lsp_runflg = {'clangd': 1, 'pylsp': 2}
--内容在LspAttach回调函数内设置
vim.cmd(
[[
let g:nvim_lsp_runflg = {}
function! GetLspStatus() abort
  if !exists('g:nvim_lsp_runflg')
    let g:nvim_lsp_runflg = {}
  endif
  "根据文件类型取得lsp服务状态
  let lspServerName = ''
  if (&ft=='c') || (&ft=='cpp') || (&ft=='objc') || (&ft=='objcpp') || (&ft=='cuda') || (&ft=='proto')
    let lspServerName = 'clangd'
  elseif (&ft=='python')
    if (g:g_python_lsp_type == 0)
      let lspServerName = 'pylsp'
    elseif (g:g_python_lsp_type == 3)
      let lspServerName = 'pyright'
    endif
  elseif (&ft=='java')
    let lspServerName = 'jdtls'
  elseif (&ft=='rust')
    let lspServerName = 'rust_analyzer'
  elseif (&ft=='go') || (&ft=='gomod') || (&ft=='gohtmltmpl') || (&ft=='gotexttmpl')
    let lspServerName = 'gopls'
  elseif (&ft=='vue')
    let lspServerName = 'volar'
  elseif (&ft=='cs') || (&ft=='solution')
    let lspServerName = 'omnisharp'
  elseif (&ft=='cobol')
    let lspServerName = 'cobol_ls'
  elseif (&ft=='javascript') || (&ft=='javascript.jsx') || (&ft=='javascriptreact') || (&ft=='typescript') || (&ft=='typescript.tsx') || (&ft=='typescriptreact')
    "let lspServerName = 'tsserver'
    let lspServerName = 'volar'
  elseif (&ft=='kotlin')
    let lspServerName = 'kotlin_language_server'
  elseif (&ft=='lua')
    let lspServerName = 'lua_ls'
  endif
  let lspStatus = ''
  if (has_key(g:nvim_lsp_runflg, lspServerName))
    let lspStatus = 'running'
  endif
  if lspStatus == ''
    if (g:g_use_nerdfont == 0)
      let lspStatus = '❌'
    else
      let lspStatus = g:lspStatusNg
    endif
  endif
  return lspStatus
endfunction
]]
)

-- nvim-lspconfig插件设定
-- 语言服务器设定
local lspconfig = require('lspconfig')
-- C/C++(clangd)设置
lspconfig.clangd.setup {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
--      '--compile-commands-dir=build',
    '-j=12',
    '--all-scopes-completion',
    '--completion-style=detailed',
    '--header-insertion=iwyu',
    '--pch-storage=memory',
    '--fallback-style=Google',
    '--function-arg-placeholders',
    '--enable-config',
    '--query-driver=gcc',
  },
  root_dir = lspconfig.util.root_pattern('.root', '.clangd', 'build.ninja', '.git');
}

if vim.g.g_python_lsp_type == 0 then
  --pylsp
  -- Python(pylsp)设置
  lspconfig.pylsp.setup {
    settings = {
      pylsp = {
        configurationSources = 'pycodestyle',
        plugins = {
          autopep8 = {
            enabled = false,
          },
          flake8 = {
            enabled = false,
          },
          pylint = {
            enabled = false,
          },
          pycodestyle = {
            enabled = true,
            ignore = {'E401', 'E402', 'E501'},
            -- maxLineLength = 100,
          },
          jedi = {
            auto_import_modules = 'gi',
            extra_paths = {'src', 'src/com', 'com'},
          },
          jedi_completion = {
            enabled = true,
            include_params = true,
            include_class_objects = false,
            include_function_objects = false,
            fuzzy = false,
            eager = false,
          },
          jedi_definition = {
            follow_imports = true,
            follow_builtin_imports = true,
          },
          jedi_hover = {
            enabled = true,
          },
          jedi_references = {
            enabled = true,
          },
          jedi_signature_help = {
            enabled = true,
          },
          jedi_symbolss = {
            enabled = true,
          },
        }
      }
    },
    root_dir = lspconfig.util.root_pattern('.root', '.env', 'setup.cfg', '.git');
  }
elseif vim.g.g_python_lsp_type == 3 then
  --pyright-langserver
  -- Python(pyright)设置
  lspconfig.pyright.setup {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
          typeCheckingMode = 'strict',
          stubPath = 'src/com',
        },
      },
    },
    root_dir = lspconfig.util.root_pattern('.root', '.env', 'setup.cfg', '.git');
  }
end
-- Java(eclipse.jdt.ls)设置
lspconfig.jdtls.setup {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.level=ALL',
    '-Dfile.encoding=UTF-8',
    '-Xmx1G',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    lsp_cmd_path.jdtls_jar_path,
    '-configuration',
    lsp_cmd_path.jdtls_config_path,
    '-data',
    lspconfig.util.path.join(vim.loop.os_homedir(), '.cache/nvim-lsp-jdtls')
  },
  init_options = {
    workspaceFolders = lspconfig.util.path.join(vim.loop.os_homedir(), '.cache/nvim-lsp-jdtls'),
    settings = {
      java = {
        configuration = {
          maven = {
            userSettings = lsp_cmd_path.maven_setting_path,
            globalSettings = lsp_cmd_path.maven_setting_path,
          },
        },
        import = {
          maven = {
            enabled = true,
          },
        },
      },
    },
  },
  root_dir = lspconfig.util.root_pattern('.root', '.classpath', 'build.xml', 'pom.xml', 'settings.gradle', 'settings.gradle.kts', 'build.gradle', 'build.gradle.kts', '.git');
}
-- Rust(rust-analyzer)设置
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      lens = {
        enable = true,
      },
      check = {
        command = 'clippy',
        extraArgs = {'--', '-A', 'clippy::needless_return'},
      },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
    },
  },
  root_dir = lspconfig.util.root_pattern('.root', 'Cargo.toml', '.git');
}
-- Go(gopls)设置
lspconfig.gopls.setup {
  cmd = {
    'gopls',
    '-remote=auto',
  },
  settings = {
    gopls = {
      -- gofumpt = true,
      analyses = {
        ST1000 = false,
        ST1003 = false,
        SA5001 = false,
        nilness = true,
        unusedwrite = true,
        unusedparams = true,
        fieldalignment = false,
        shadow = false,
        composites = false,
      },
      staticcheck = true,
      semanticTokens = true,
--[[
      ui = {
        codelenses = {
          generate = true,
          regenerate_cgo = true,
          test = true,
          vendor = true,
          tidy = true,
          upgrade_dependency = true,
          gc_details = true,
        },
        diagnostic = {
          annotations = {
            bounds = true,
            inline = true,
            escape = true,
            --nil = true,
          },
          staticcheck = true,
        },
        completion = {
          usePlaceholders = true,
          matcher = 'Fuzzy',
          completionBudget = '500ms',
        },
        navigation = {
          importShortcut = 'Definition',
          symbolMatcher = 'Fuzzy',
          symbolStyle = 'Dynamic',
        },
        semanticTokens = true,
      },
--]]
    },
  },
  root_dir = lspconfig.util.root_pattern('.root', 'go.mod', 'go.work', '.git');
}
-- Vue(volar-language-server)设置
lspconfig.volar.setup {
  filetypes = {
    'vue',
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  init_options = {
    typescript = {
      tsdk = lsp_cmd_path.typescript_tsdk_path
    }
  },
  root_dir = lspconfig.util.root_pattern('.root', 'package.json', '.git');
}
-- CSharp（OmniSharp）设置
lspconfig.omnisharp.setup {
  cmd = { 'OmniSharp', '-z', '--languageserver', '--encoding', 'utf-8', 'DotNet:enablePackageRestore=false' },
  filetypes = { 'cs' },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = false,
  organize_imports_on_format = false,
  enable_import_completion = false,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
  root_dir = lspconfig.util.root_pattern('.root', '.sln', '.csproj', '.git');
}
-- Cobol（che-che4z-lsp-for-cobol）设置
lspconfig.cobol_ls.setup {
  cmd = {
    'java',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-Dline.speparator=\r\n',
    '-jar',
    lsp_cmd_path.cobol_lsp_jar_path,
    'pipeEnabled',
  },
  filetypes = { 'cobol'},
  root_dir = lspconfig.util.root_pattern('.root', '.git');
}
-- JavaScript和TypeScript（typescript-language-server）设置
--lspconfig.tsserver.setup {
--  root_dir = lspconfig.util.root_pattern('.root', 'package.json', 'jsconfig.json', '.git');
--}
-- Kotlin（kotlin-language-server）设置
lspconfig.kotlin_language_server.setup {
  root_dir = lspconfig.util.root_pattern('.root', 'settings.gradle', '.git');
}
-- Lua（lua-language-server）设置
-- 在这里下载 https://github.com/LuaLS/lua-language-server/releases/tag/3.7.0
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  },
  root_dir = lspconfig.util.root_pattern('.root', '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git');
}
-- 快捷键绑定
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<Space>q', vim.diagnostic.setloclist)
-- vim.keymap.set('n', '<Space>q', function()
--   vim.diagnostic.setloclist()
--   vim.cmd(':lclose')
--   require('telescope.builtin').loclist()
-- end)
vim.keymap.set('n', '<C-j>', ':lnext<CR>', { noremap = true })
vim.keymap.set('n', '<C-k>', ':lprevious<CR>', { noremap = true })
vim.keymap.set('n', '<Space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<Space>gn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Space>gp', vim.diagnostic.goto_prev)

-- 当前缓冲区的快捷键绑定
vim.api.nvim_create_augroup('UserLspConfig', { clear = true })
vim.api.nvim_clear_autocmds { group = 'UserLspConfig' }
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.bo[args.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = args.buf }
    --vim.keymap.set('n', '<Space>lo', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<Space>lo', require('telescope.builtin').diagnostics, opts)
    vim.keymap.set('n', '<Space>lc', ':lclose<CR>', { noremap = true })
    vim.keymap.set({ 'n', 'v' }, '<Space>ca', vim.lsp.buf.code_action, opts)
    --vim.keymap.set('n', '<Space>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Space>gd', require('telescope.builtin').lsp_definitions, opts)
    --vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
    --vim.keymap.set('n', '<Space>gs', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<Space>gs', require('telescope.builtin').lsp_document_symbols, opts)
    --vim.keymap.set('n', '<Space>gS', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<Space>gS', require('telescope.builtin').lsp_workspace_symbols, opts)
    vim.keymap.set('n', '<Space>p', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<Space>gr', vim.lsp.buf.references, opts)
    --vim.keymap.set('n', '<Space>gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Space>gi', require('telescope.builtin').lsp_implementations, opts)
    --vim.keymap.set('n', '<Space>gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Space>gt', require('telescope.builtin').lsp_type_definitions, opts)
    vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<Space>h', vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', '<C-UP>', vim.lsp.buf.references, opts)
    --vim.keymap.set('n', '<C-Down>', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Space>fm', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', '<Space>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<Space>gh', vim.lsp.buf.signature_help, opts)
    --vim.keymap.set('n', '<Space>ic', vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set('n', '<Space>ic', require('telescope.builtin').lsp_incoming_calls, opts)
    --vim.keymap.set('n', '<Space>oc', vim.lsp.buf.outgoing_calls, opts)
    vim.keymap.set('n', '<Space>oc', require('telescope.builtin').lsp_outgoing_calls, opts)
    --vim.keymap.set('n', '<Space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<Space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    --取得当前生效的LspClient对象
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    --在全局变量g:nvim_lsp_runflg中设定内容
    local localFlg = vim.g.nvim_lsp_runflg
    localFlg[client.name] = client.id
    vim.g.nvim_lsp_runflg = localFlg
    --当前选中符号的高亮设定(废弃)
    --if client.server_capabilities.documentHighlightProvider then
    --  vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    --  vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    --  vim.api.nvim_create_autocmd("CursorHold", {
    --      callback = vim.lsp.buf.document_highlight,
    --      buffer = bufnr,
    --      group = "lsp_document_highlight",
    --      desc = "Document Highlight",
    --  })
    --  vim.api.nvim_create_autocmd("CursorMoved", {
    --      callback = vim.lsp.buf.clear_references,
    --      buffer = bufnr,
    --      group = "lsp_document_highlight",
    --      desc = "Clear All the References",
    --  })
    --end
--当前选中符号的高亮设定
--需要设定updatetime为100毫秒
    vim.cmd(
[[
setlocal updatetime=100
augroup lsp_document_highlight
  autocmd! * <buffer>
  autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
  "autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
augroup END
]]
    )

  end,
  group = 'UserLspConfig',
})

--nvim-cmp插件设定
--cmp-nvim-lsp插件设定
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
  completion = {
    keyword_length = 2,
  },
  -- 设置代码片段引擎，用于根据代码片段补全
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  -- 自动补全和补全说明窗口设定
  window = {
    --completion = cmp.config.window.bordered(),
    completion = {
       border = 'rounded',
       --winhighlight = 'Normal:Pmenu,FloatBorder:None,CursorLine:PmenuSel,Search:None',
       winhighlight = 'Normal:None,FloatBorder:None,CursorLine:PmenuSelBg,Search:None',
       zindex = 1001,
       scrolloff = 0,
       col_offset = 0,
       side_padding = 1,
       scrollbar = true
    },
    --documentation = cmp.config.window.bordered(),
    documentation = {
       border = 'rounded',
       --winhighlight = 'Normal:Pmenu,FloatBorder:None,CursorLine:PmenuSel,Search:None',
       winhighlight = 'Normal:None,FloatBorder:None,CursorLine:PmenuSelBg,Search:None',
       zindex = 1002,
       scrolloff = 0,
       col_offset = 0,
       side_padding = 1,
       scrollbar = true
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-i>'] = cmp.mapping.complete(),
    ['<C-s>'] = cmp.mapping.complete({
        config = {
          sources = {
            { name = 'vsnip' }
          }
        }
      }),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" })
  }),
  -- 补全来源
  sources = cmp.config.sources({
    { name = 'nvim_lsp', keyword_length=2, group_index = 1, priority=1 },
    { name = 'nvim_lsp_signature_help', keyword_length=2, group_index = 1, priority=2 },
    { name = 'vsnip', keyword_length=2, group_index = 1, priority=3 },
    { name = 'buffer', keyword_length=2, group_index = 2, priority=4 },
    { name = 'path', keyword_length=2, group_index = 2, priority=5 },
    { name = 'dictionary', keyword_length=2, group_index = 2, priority=6 },
  }),
  -- 设置补全显示的格式（lspkind.nvim插件）
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      before = function(entry, vim_item)
        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        return vim_item
      end
    }),
  },
})

--根据文件类型来选择补全来源
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})

-- 命令模式下输入 `/` 启用补全
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- 命令模式下输入 `:` 启用补全
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

--nvim-cmp插件的高亮设定
vim.cmd(
[[
"CmpItemAbbr - 不匹配的字符
"CmpItemAbbrDeprecated - 已弃用的不匹配的字符
"CmpItemAbbrMatch - 匹配的字符
"CmpItemAbbrMatchFuzzy - 模糊匹配的字符
"CmpItemKind - 类型（即符号种类）
"CmpItemKind%KIND_NAME%* - 特定的种类
"CmpItemMenu - 菜单字段
hi clear CmpItemAbbr
hi! link CmpItemAbbr PmenuFg
hi clear CmpItemAbbrDefault
hi! link CmpItemAbbrDefault PmenuFg
hi clear CmpItemAbbrDeprecated
hi! link CmpItemAbbrDeprecated PmenuDeprecated
hi clear CmpItemAbbrMatch
hi! link CmpItemAbbrMatch PmenuMatch
hi clear CmpItemAbbrMatchFuzzy
hi! link CmpItemAbbrMatchFuzzy PmenuMatchFuzzy
hi clear CmpItemKindDefault
hi! link CmpItemKindDefault PmenuFg
hi clear CmpItemKindKeyword
hi! link CmpItemKindKeyword Keyword
hi clear CmpItemKindVariable
hi! link CmpItemKindVariable Variables
hi clear CmpItemKindConstant
hi! link CmpItemKindConstant Constant
hi clear CmpItemKindReference
hi! link CmpItemKindReference Lifetime
hi clear CmpItemKindValue
hi! link CmpItemKindValue String
hi clear CmpItemKindCopilot
hi! link CmpItemKindCopilot Number
hi clear CmpItemKindFunction
hi! link CmpItemKindFunction Function
hi clear CmpItemKindMethod
hi! link CmpItemKindMethod Function
hi clear CmpItemKindConstructor
hi! link CmpItemKindConstructor Special
hi clear CmpItemKindClass
hi! link CmpItemKindClass Struct
hi clear CmpItemKindInterface
hi! link CmpItemKindInterface Interface
hi clear CmpItemKindStruct
hi! link CmpItemKindStruct Struct
hi clear CmpItemKindEvent
hi! link CmpItemKindEvent Struct
hi clear CmpItemKindEnum
hi! link CmpItemKindEnum Struct
hi clear CmpItemKindUnit
hi! link CmpItemKindUnit Macro
hi clear CmpItemKindModule
hi! link CmpItemKindModule ThinTitle
hi clear CmpItemKindProperty
hi! link CmpItemKindProperty Property
hi clear CmpItemKindField
hi! link CmpItemKindField Identifier
hi clear CmpItemKindTypeParameter
hi! link CmpItemKindTypeParameter Parameter
hi clear CmpItemKindEnumMember
hi! link CmpItemKindEnumMember EnumMember
hi clear CmpItemKindOperator
hi! link CmpItemKindOperator Operator
hi clear CmpItemKindSnippet
hi! link CmpItemKindSnippet Regexp
hi clear CmpItemKindText
hi! link CmpItemKindText Debug
hi clear CmpItemKindFile
hi! link CmpItemKindFile Variables
hi clear CmpItemKindFolder
hi! link CmpItemKindFolder Directory
hi clear CmpItemKindColor
hi! link CmpItemKindColor Lifetime
hi clear CmpItemMenu
hi! link CmpItemMenu Comment
]]
)

-- Snippets设定
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
--     capabilities = capabilities,
--   }
-- end

--Ctrl+F2显示LSP服务器状态
vim.keymap.set({'n'}, '<C-F2>', ':LspInfo<CR>', { noremap = true })
vim.keymap.set({'n'}, '<Leader>ls', ':LspInfo<CR>', { noremap = true })

--Lsp相关的高亮设定
--:sign list 查看所有定义
vim.cmd([[
if (g:g_use_nerdfont == 0)
  sign define DiagnosticSignError text=❌ texthl=DiagnosticSignError linehl= numhl=
  sign define DiagnosticSignWarn text=🆖 texthl=DiagnosticSignWarn linehl= numhl=
  sign define DiagnosticSignInfo text=❗ texthl=DiagnosticSignInfo linehl= numhl=
  sign define DiagnosticSignHint text=🗝 texthl=DiagnosticSignHint linehl= numhl=
else
  call sign_define("DiagnosticSignError", {"text" : g:diagnosticsErrorIcon, "texthl" : "DiagnosticSignError"})
  call sign_define("DiagnosticSignWarn", {"text" : g:diagnosticsWarnIcon, "texthl" : "DiagnosticSignWarn"})
  call sign_define("DiagnosticSignInfo", {"text" : g:diagnosticsInfoIcon, "texthl" : "DiagnosticSignInfo"})
  call sign_define("DiagnosticSignHint", {"text" : g:diagnosticsHintrIcon, "texthl" : "DiagnosticSignHint"})
endif
]])

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

-- 词典补全设定
local dict = require("cmp_dictionary")
dict.setup({
  exact = 2,
  first_case_insensitive = false,
  document = false,
  document_command = "wn %s -over",
  sqlite = false,
  max_items = -1,
  capacity = 5,
  debug = false,
})
dict.switcher({
  filetype = {
    dosbatch = "~/vimconf/dict/batch.dict",
    cmake = "~/vimconf/dict/cmake.dict",
    css = { "~/vimconf/dict/css.dict", "~/vimconf/dict/css3.dict" },
    haskell = "~/vimconf/dict/haskell.dict",
    html = { "~/vimconf/dict/html.dict", "~/vimconf/dict/css.dict", "~/vimconf/dict/css3.dict", "~/vimconf/dict/javascript.dict" },
    lua = "~/vimconf/dict/lua.dict",
    make = "~/vimconf/dict/make.dict",
    markdown = "~/vimconf/dict/text.dict",
    matlab = "~/vimconf/dict/matlab.dict",
    perl = "~/vimconf/dict/perl.dict",
    php = "~/vimconf/dict/php.dict",
    ruby = "~/vimconf/dict/ruby.dict",
    scala = "~/vimconf/dict/scala.dict",
    sh = "~/vimconf/dict/sh.dict",
    text = "~/vimconf/dict/text.dict",
    vim = "~/vimconf/dict/vim.dict",
  },
  filepath = {
    --[".*xmake.lua"] = { "/path/to/xmake.dict", "/path/to/lua.dict" },
    --["%.tmux.*%.conf"] = { "/path/to/js.dict", "/path/to/js2.dict" },
  },
  spelllang = {
    --en = "/path/to/english.dict",
  },
})

-- 代码片段设定
vim.cmd([[
let g:vsnip_snippet_dir = expand('~/AppData/Roaming/Code/User/snippets')
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" Expand
imap <expr> <C-q>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-q>'
smap <expr> <C-q>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-q>'
" Expand or jump
imap <expr> <C-w>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-w>'
smap <expr> <C-w>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-w>'
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
]])
