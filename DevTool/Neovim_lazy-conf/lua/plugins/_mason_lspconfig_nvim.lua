return {
  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    version = "*",
    event = "VeryLazy",
    priority = 52,
    opts = {
    },
    config = function()
      --加载插件
      require("mason-lspconfig").setup{
        --ensure_installed = { "lua_ls", "rust_analyzer" },
        ensure_installed = {},
        automatic_installation = false,
        handlers = nil,
      }

      -- 设定自动补全的全功能（不设定这个选中函数没有后面的括号）
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local java_debug_jar_path = vim.g.mason_nvim_root ..  '/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'

      require("mason-lspconfig").setup_handlers {
        --默认注册器，不要动
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end,
        -- 自定义注册LSP服务
        -- Lua
        ["lua_ls"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                }
              }
            }
          }
        end,
        -- Java
        ["jdtls"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.jdtls.setup {
            init_options = {
              bundles = {
                --让jdtls加载java-debug插件
                java_debug_jar_path,
              },
              workspaceFolders = lspconfig.util.path.join(vim.loop.os_homedir(), '.cache/jdtls/workspace'),
              extendedClientCapabilities = {
                classFileContentsSupport = true,
                generateToStringPromptSupport = true,
                hashCodeEqualsPromptSupport = true,
                advancedExtractRefactoringSupport = true,
                advancedOrganizeImportsSupport = true,
                generateConstructorsPromptSupport = true,
                generateDelegateMethodsPromptSupport = true,
                moveRefactoringSupport = true,
                overrideMethodsPromptSupport = true,
                executeClientCommandSupport = true,
                resolveAdditionalTextEditsSupport = true,
                inferSelectionSupport = {
                  "extractMethod",
                  "extractVariable",
                  "extractConstant",
                  "extractVariableAllOccurrence"
                },
              },
              settings = {
                java = {
                  configuration = {
                    updateBuildConfiguration = "interactive",
                    maven = {
                      userSettings = vim.g.user_home .. '/.m2/settings.xml',
                      globalSettings = vim.g.java_maven_conf_path,
                    },
                  },
                  eclipse = {
                    downloadSources = true,
                  },
                  maven = {
                    downloadSources = true,
                    updateSnapshots = true,
                  },
                  implementationsCodeLens = {
                    enabled = false,
                  },
                  referencesCodeLens = {
                    enabled = false,
                  },
                  references = {
                    includeAccessors = true,
                    includeDecompiledSources = true,
                  },
                  contentProvider = {
                    preferred = 'fernflower',
                  },
                  import = {
                    maven = {
                      enabled = true,
                    },
                    gradle = {
                      enabled = true,
                    },
                  },
                  inlayhints = {
                    parameterNames = {
                      enabled = true,
                    },
                  },
                  sources = {
                    organizeImports = {
                      starThreshold = 9999,
                      staticStarThreshold = 9999,
                    },
                  },
                  showBuildStatusOnStart = {
                    enabled = true,
                  },
                  signatureHelp = {
                    enabled = true,
                  },
                  codeGeneration = {
                    toString = {
                      template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                    },
                    useBlocks = true,
                  },
                },
              },
            },
            capabilities = capabilities,
            root_dir = vim.fs.dirname(vim.fs.find({'pom.xml', 'gradlew', 'mvnw'}, { upward = true })[1]);
          }
        end,
        -- Python
        ["pyright"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.pyright.setup {
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  diagnosticMode = 'openFilesOnly',
                  typeCheckingMode = 'basic',
                  --stubPath = 'src/com',
                },
              },
            },
            capabilities = capabilities,
            root_dir = vim.fs.dirname(vim.fs.find({'.venv', 'pyproject.toml'}, { upward = true })[1]);
          }
        end,
        -- Golang
        ["gopls"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.gopls.setup {
            init_options = {
              usePlaceholders = true,
            },
            settings = {
              gopls = {
                allExperiments = true,
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
                codelenses = {
                  generate = true,
                  regenerate_cgo = true,
                  test = true,
                  vendor = true,
                  tidy = true,
                  upgrade_dependency = true,
                  gc_details = true,
                },
                annotations = {
                  bounds = true,
                  inline = true,
                  escape = true,
                  --nil = true,
                },
                usePlaceholders = true,
                matcher = 'Fuzzy',
                completionBudget = '500ms',
                importShortcut = 'Definition',
                symbolMatcher = 'Fuzzy',
                symbolStyle = 'Dynamic',
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                directoryFilters = { '-node_modules', '-data' },
              },
            },
            single_file_support = true,
            capabilities = capabilities,
            root_dir = vim.fs.dirname(vim.fs.find({'go.mod', 'go.work'}, { upward = true })[1]);
          }
        end,
        -- Rust
        ["rust_analyzer"] = function ()
          local lspconfig = require("lspconfig")
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
            capabilities = capabilities,
            root_dir = vim.fs.dirname(vim.fs.find({'Cargo.toml'}, { upward = true })[1]);
          }
        end,
        -- CSharp
        ["csharp_ls"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.csharp_ls.setup {
            capabilities = capabilities,
            root_dir = vim.fs.root(0, function(name, path) return name:match('%.sln$') ~= nil end);
          }
        end,
        -- Vue
        ["volar"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.volar.setup {
            init_options = {
              vue = {
                hybridMode = false,
              },
            },
            --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            filetypes = { 'vue' },
            capabilities = capabilities,
            root_dir = vim.fs.dirname(vim.fs.find({'package.json', 'tsconfig.json', 'jsconfig.json'}, { upward = true })[1]);
          }
        end,
        -- Javascript/Typescript
        ["tsserver"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.tsserver.setup {
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact'},
            capabilities = capabilities,
            root_dir = vim.fs.dirname(vim.fs.find({'package.json', 'tsconfig.json', 'jsconfig.json'}, { upward = true })[1]);
          }
        end,
      }
    end,
    keys = {
    },
  }
}
