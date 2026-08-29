return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      dim_inactive = false,

      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },

      on_colors = function(c)
        -- VS Code Dark+ / settings.json
        c.bg = "#1e1e1e"
        c.bg_dark = "#181818"
        c.bg_float = "#252526"
        c.bg_popup = "#252526"
        c.bg_sidebar = "#1e1e1e"
        c.bg_statusline = "#252629"

        c.fg = "#d4d4d4"
        c.fg_dark = "#c5c8c6"
        c.fg_gutter = "#6c8086"
        c.comment = "#5f6167"

        c.blue = "#64afef"
        c.blue0 = "#4fc1ff"
        c.blue1 = "#569cd6"
        c.blue2 = "#9cdcfe"
        c.cyan = "#00e8ef"
        c.green = "#96e072"
        c.green1 = "#809980"
        c.magenta = "#c586c0"
        c.orange = "#f39c12"
        c.red = "#ff0000"
        c.yellow = "#ffff00"

        c.bg_highlight = "#292e42"
        c.selection = "#264f78"
        c.border = "#535973"
      end,

      on_highlights = function(hl, c)
        local bg = "#1e1e1e"
        local fg = "#d4d4d4"
        local comment = "#5f6167"
        local keyword = "#64afef"
        local keyword_control = "#c586c0"
        local func = "#96e072"
        local string = "#809980"
        local number = "#00e8ef"
        local variable = "#c5c8c6"
        local parameter = "#4d8a94"
        local property = "#4ec9b0"
        local type_color = "#4fc1ff"
        local class_color = "#9cdcfe"
        local interface_color = "#dd50dd"
        local enum_color = "#cc81ba"
        local enum_member = "#8ddaf8"
        local struct_color = "#ee5d43"
        local namespace = "#e6e6fa"

        -- Editor UI
        hl.Normal = { fg = fg, bg = bg }
        hl.NormalNC = { fg = fg, bg = bg }
        hl.NormalFloat = { fg = fg, bg = "#252526" }
        hl.FloatBorder = { fg = "#535973", bg = "#252526" }

        hl.LineNr = { fg = "#6c8086" }
        hl.CursorLineNr = { fg = "#ffff00", bold = false }
        hl.CursorLine = { bg = "#292e42" }
        hl.CursorColumn = { bg = "#292e42" }
        hl.ColorColumn = { bg = "#242424" }

        hl.Visual = { bg = "#264f78" }
        hl.VisualNOS = { bg = "#3a3d41" }

        hl.Cursor = { fg = "#000000", bg = "#00ffff" }
        hl.TermCursor = { fg = "#000000", bg = "#00ffff" }

        hl.Search = { fg = "#000000", bg = "#ffff00" }
        hl.CurSearch = { fg = "#000000", bg = "#00ff00" }
        hl.IncSearch = { fg = "#000000", bg = "#00ff00" }

        hl.Whitespace = { fg = "#e3e4e2" }
        hl.NonText = { fg = "#434853" }
        hl.SpecialKey = { fg = "#808080" }
        hl.WinSeparator = { fg = "#3e3e3e" }

        hl.Pmenu = { fg = fg, bg = "#252526" }
        hl.PmenuSel = { fg = fg, bg = "#04395e" }
        hl.PmenuBorder = { fg = "#535973", bg = "#252526" }
        hl.PmenuSbar = { bg = "#2e2e2e" }
        hl.PmenuThumb = { bg = "#585c66" }

        hl.StatusLine = { fg = "#cecece", bg = "#252629" }
        hl.StatusLineNC = { fg = "#808080", bg = "#252629" }

        hl.DiagnosticError = { fg = "#ff0000" }
        hl.DiagnosticWarn = { fg = "#ffff00" }
        hl.DiagnosticInfo = { fg = "#0db9d7" }
        hl.DiagnosticHint = { fg = "#1abc9c" }

        hl.DiagnosticVirtualTextError = { fg = "#ff4b4b", bg = "#362c3d" }
        hl.DiagnosticVirtualTextWarn = { fg = "#e0af30", bg = "#373640" }
        hl.DiagnosticVirtualTextInfo = { fg = "#0db9d7", bg = "#22374b" }
        hl.DiagnosticVirtualTextHint = { fg = "#1abc9c", bg = "#233745" }

        -- Traditional Vim syntax
        hl.Comment = { fg = comment, italic = false }
        hl.Constant = { fg = "#569cd6" }
        hl.String = { fg = string }
        hl.Character = { fg = string }
        hl.Number = { fg = number }
        hl.Float = { fg = number }
        hl.Boolean = { fg = number }

        hl.Identifier = { fg = variable }
        hl.Function = { fg = func }

        hl.Statement = { fg = keyword }
        hl.Conditional = { fg = keyword_control }
        hl.Repeat = { fg = keyword_control }
        hl.Label = { fg = keyword }
        hl.Operator = { fg = "#c586c0" }
        hl.Keyword = { fg = keyword }
        hl.Exception = { fg = keyword_control }

        hl.PreProc = { fg = keyword }
        hl.Include = { fg = keyword }
        hl.Define = { fg = func }
        hl.Macro = { fg = func }

        hl.Type = { fg = type_color }
        hl.StorageClass = { fg = keyword }
        hl.Structure = { fg = struct_color }
        hl.Typedef = { fg = type_color }
        hl.Special = { fg = property }

        -- Tree-sitter
        hl["@comment"] = { fg = comment, italic = false }
        hl["@comment.documentation"] = { fg = comment, italic = false }

        hl["@string"] = { fg = string }
        hl["@string.documentation"] = { fg = string }
        hl["@string.escape"] = { fg = "#d7ba7d" }
        hl["@string.regexp"] = { fg = "#646695" }
        hl["@character"] = { fg = string }

        hl["@number"] = { fg = number }
        hl["@number.float"] = { fg = number }
        hl["@boolean"] = { fg = number }

        hl["@variable"] = { fg = variable }
        hl["@variable.builtin"] = { fg = keyword }
        hl["@variable.parameter"] = { fg = parameter }
        hl["@variable.member"] = { fg = property }
        hl["@property"] = { fg = property }

        hl["@function"] = { fg = func }
        hl["@function.call"] = { fg = func }
        hl["@function.method"] = { fg = func }
        hl["@function.method.call"] = { fg = func }
        hl["@function.macro"] = { fg = func }
        hl["@constructor"] = { fg = class_color }

        hl["@keyword"] = { fg = keyword }
        hl["@keyword.function"] = { fg = keyword }
        hl["@keyword.return"] = { fg = keyword_control }
        hl["@keyword.conditional"] = { fg = keyword_control }
        hl["@keyword.repeat"] = { fg = keyword_control }
        hl["@keyword.exception"] = { fg = keyword_control }
        hl["@keyword.import"] = { fg = keyword }
        hl["@keyword.operator"] = { fg = keyword_control }

        hl["@operator"] = { fg = "#c586c0" }

        hl["@type"] = { fg = type_color }
        hl["@type.builtin"] = { fg = keyword }
        hl["@type.definition"] = { fg = type_color }

        hl["@constant"] = { fg = "#569cd6" }
        hl["@constant.builtin"] = { fg = keyword }
        hl["@module"] = { fg = namespace }
        hl["@module.builtin"] = { fg = keyword }
        hl["@attribute"] = { fg = property }

        hl["@tag"] = { fg = "#569cd6" }
        hl["@tag.attribute"] = { fg = "#9cdcfe" }
        hl["@tag.delimiter"] = { fg = "#808080" }

        -- JSON / JSONC: match VS Code Dark+
        -- JSON keys are property names, not ordinary strings.
        hl["@property.json"] = { fg = "#9cdcfe" }
        hl["@property.jsonc"] = { fg = "#9cdcfe" }
        hl["@string.special.key.json"] = { fg = "#9cdcfe" }
        hl["@string.special.key.jsonc"] = { fg = "#9cdcfe" }

        -- JSON string values keep the customized Dark+ green.
        hl["@string.json"] = { fg = string }
        hl["@string.jsonc"] = { fg = string }
        hl["@number.json"] = { fg = number }
        hl["@number.jsonc"] = { fg = number }
        hl["@boolean.json"] = { fg = "#569cd6" }
        hl["@boolean.jsonc"] = { fg = "#569cd6" }
        hl["@constant.builtin.json"] = { fg = "#569cd6" }
        hl["@constant.builtin.jsonc"] = { fg = "#569cd6" }

        -- Braces, brackets, commas and colons.
        hl["@punctuation.bracket.json"] = { fg = fg }
        hl["@punctuation.bracket.jsonc"] = { fg = fg }
        hl["@punctuation.delimiter.json"] = { fg = fg }
        hl["@punctuation.delimiter.jsonc"] = { fg = fg }


        -- TOML: match the customized VS Code Dark+ colors
        -- [section.name]
        hl["@type.toml"] = { fg = "#f39c12" }
        hl["@type.builtin.toml"] = { fg = "#f39c12" }
        hl["@namespace.toml"] = { fg = "#f39c12" }
        hl["@module.toml"] = { fg = "#f39c12" }
        hl["@property.toml"] = { fg = "#4fc1ff" }
        hl["@string.special.key.toml"] = { fg = "#4fc1ff" }

        -- key = value
        hl["@variable.toml"] = { fg = "#4fc1ff" }
        hl["@field.toml"] = { fg = "#4fc1ff" }
        hl["@attribute.toml"] = { fg = "#4fc1ff" }

        -- values
        hl["@string.toml"] = { fg = "#809980" }
        hl["@number.toml"] = { fg = "#00e8ef" }
        hl["@number.float.toml"] = { fg = "#00e8ef" }
        hl["@boolean.toml"] = { fg = "#569cd6" }
        hl["@constant.builtin.toml"] = { fg = "#569cd6" }
        hl["@comment.toml"] = { fg = "#5f6167", italic = false }

        -- punctuation
        hl["@punctuation.bracket.toml"] = { fg = "#d4d4d4" }
        hl["@punctuation.delimiter.toml"] = { fg = "#d4d4d4" }
        hl["@operator.toml"] = { fg = "#d4d4d4" }


        -- YAML / Docker Compose: match the customized VS Code Dark+ colors
        -- Mapping keys
        hl["@property.yaml"] = { fg = "#4fc1ff" }
        hl["@field.yaml"] = { fg = "#4fc1ff" }
        hl["@variable.yaml"] = { fg = "#4fc1ff" }
        hl["@string.special.key.yaml"] = { fg = "#4fc1ff" }

        -- Scalar values
        hl["@string.yaml"] = { fg = "#809980" }
        hl["@string.special.yaml"] = { fg = "#809980" }
        hl["@number.yaml"] = { fg = "#00e8ef" }
        hl["@number.float.yaml"] = { fg = "#00e8ef" }
        hl["@boolean.yaml"] = { fg = "#569cd6" }
        hl["@constant.builtin.yaml"] = { fg = "#569cd6" }
        hl["@constant.yaml"] = { fg = "#809980" }

        -- Anchors, aliases and tags
        hl["@label.yaml"] = { fg = "#ce9178" }
        hl["@attribute.yaml"] = { fg = "#ce9178" }
        hl["@type.yaml"] = { fg = "#ce9178" }
        hl["@tag.yaml"] = { fg = "#ce9178" }

        -- Comments and punctuation
        hl["@comment.yaml"] = { fg = "#5f6167", italic = false }
        hl["@operator.yaml"] = { fg = "#d4d4d4" }
        hl["@punctuation.bracket.yaml"] = { fg = "#d4d4d4" }
        hl["@punctuation.delimiter.yaml"] = { fg = "#d4d4d4" }
        hl["@punctuation.special.yaml"] = { fg = "#ce9178" }

        -- LSP semantic tokens
        hl["@lsp.type.variable"] = { fg = fg }
        hl["@lsp.type.parameter"] = { fg = parameter }
        hl["@lsp.type.typeParameter"] = { fg = parameter }
        hl["@lsp.type.property"] = { fg = property }
        hl["@lsp.type.interface"] = { fg = interface_color }
        hl["@lsp.type.class"] = { fg = class_color }
        hl["@lsp.type.type"] = { fg = class_color }
        hl["@lsp.type.enum"] = { fg = enum_color }
        hl["@lsp.type.enumMember"] = { fg = enum_member }
        hl["@lsp.type.struct"] = { fg = struct_color }
        hl["@lsp.type.function"] = { fg = func }
        hl["@lsp.type.method"] = { fg = func }
        hl["@lsp.type.macro"] = { fg = func }
        hl["@lsp.type.namespace"] = { fg = namespace }
        hl["@lsp.type.decorator"] = { fg = property }
        hl["@lsp.type.annotation"] = { fg = property }
        hl["@lsp.type.keyword"] = { fg = "#569cd6" }
        hl["@lsp.type.number"] = { fg = number }
        hl["@lsp.type.string"] = { fg = string }
        hl["@lsp.type.regexp"] = { fg = "#646695" }

        -- Java-specific details from settings.json
        hl["@keyword.conditional.java"] = { fg = keyword_control }
        hl["@keyword.repeat.java"] = { fg = keyword_control }
        hl["@keyword.exception.java"] = { fg = keyword_control }
        hl["@keyword.return.java"] = { fg = keyword_control }
        hl["@keyword.operator.java"] = { fg = keyword_control }
        hl["@keyword.import.java"] = { fg = keyword }
        hl["@type.builtin.java"] = { fg = keyword }
        hl["@attribute.java"] = { fg = property }

        -- JavaScript / TypeScript / JSX / TSX
        -- VS Code Dark+ uses light blue for JSX component/tag names,
        -- pale blue for attributes, green for strings, and cyan/blue for identifiers.
        for _, lang in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact", "jsx", "tsx" }) do
          hl["@tag." .. lang] = { fg = "#4fc1ff" }
          hl["@tag.builtin." .. lang] = { fg = "#4fc1ff" }
          hl["@tag.attribute." .. lang] = { fg = "#9cdcfe" }
          hl["@tag.delimiter." .. lang] = { fg = "#808080" }
          hl["@constructor." .. lang] = { fg = "#4fc1ff" }

          hl["@variable." .. lang] = { fg = "#d4d4d4" }
          hl["@variable.member." .. lang] = { fg = "#9cdcfe" }
          hl["@variable.parameter." .. lang] = { fg = "#9cdcfe" }
          hl["@property." .. lang] = { fg = "#9cdcfe" }

          hl["@function." .. lang] = { fg = "#dcdCAA" }
          hl["@function.call." .. lang] = { fg = "#dcdCAA" }
          hl["@function.method." .. lang] = { fg = "#dcdCAA" }
          hl["@function.method.call." .. lang] = { fg = "#dcdCAA" }

          hl["@keyword." .. lang] = { fg = "#569cd6" }
          hl["@keyword.function." .. lang] = { fg = "#569cd6" }
          hl["@keyword.return." .. lang] = { fg = "#c586c0" }
          hl["@keyword.conditional." .. lang] = { fg = "#c586c0" }
          hl["@keyword.repeat." .. lang] = { fg = "#c586c0" }
          hl["@keyword.operator." .. lang] = { fg = "#c586c0" }
          hl["@operator." .. lang] = { fg = "#d4d4d4" }

          hl["@string." .. lang] = { fg = "#809980" }
          hl["@number." .. lang] = { fg = "#00e8ef" }
          hl["@boolean." .. lang] = { fg = "#569cd6" }
          hl["@type." .. lang] = { fg = "#4fc1ff" }
          hl["@type.builtin." .. lang] = { fg = "#569cd6" }
        end

        -- Explicit captures used by recent nvim-treesitter TSX grammars
        hl["@tag.tsx"] = { fg = "#4fc1ff" }
        hl["@tag.builtin.tsx"] = { fg = "#4fc1ff" }
        hl["@tag.attribute.tsx"] = { fg = "#9cdcfe" }
        hl["@tag.delimiter.tsx"] = { fg = "#808080" }
        hl["@constructor.tsx"] = { fg = "#4fc1ff" }
        hl["@property.tsx"] = { fg = "#9cdcfe" }


        -- TOML: match the customized VS Code Dark+ colors
        -- [section.name]
        hl["@type.toml"] = { fg = "#f39c12" }
        hl["@type.builtin.toml"] = { fg = "#f39c12" }
        hl["@namespace.toml"] = { fg = "#f39c12" }
        hl["@module.toml"] = { fg = "#f39c12" }
        hl["@property.toml"] = { fg = "#4fc1ff" }
        hl["@string.special.key.toml"] = { fg = "#4fc1ff" }

        -- key = value
        hl["@variable.toml"] = { fg = "#4fc1ff" }
        hl["@field.toml"] = { fg = "#4fc1ff" }
        hl["@attribute.toml"] = { fg = "#4fc1ff" }

        -- values
        hl["@string.toml"] = { fg = "#809980" }
        hl["@number.toml"] = { fg = "#00e8ef" }
        hl["@number.float.toml"] = { fg = "#00e8ef" }
        hl["@boolean.toml"] = { fg = "#569cd6" }
        hl["@constant.builtin.toml"] = { fg = "#569cd6" }
        hl["@comment.toml"] = { fg = "#5f6167", italic = false }

        -- punctuation
        hl["@punctuation.bracket.toml"] = { fg = "#d4d4d4" }
        hl["@punctuation.delimiter.toml"] = { fg = "#d4d4d4" }
        hl["@operator.toml"] = { fg = "#d4d4d4" }


        -- YAML / Docker Compose: match the customized VS Code Dark+ colors
        -- Mapping keys
        hl["@property.yaml"] = { fg = "#4fc1ff" }
        hl["@field.yaml"] = { fg = "#4fc1ff" }
        hl["@variable.yaml"] = { fg = "#4fc1ff" }
        hl["@string.special.key.yaml"] = { fg = "#4fc1ff" }

        -- Scalar values
        hl["@string.yaml"] = { fg = "#809980" }
        hl["@string.special.yaml"] = { fg = "#809980" }
        hl["@number.yaml"] = { fg = "#00e8ef" }
        hl["@number.float.yaml"] = { fg = "#00e8ef" }
        hl["@boolean.yaml"] = { fg = "#569cd6" }
        hl["@constant.builtin.yaml"] = { fg = "#569cd6" }
        hl["@constant.yaml"] = { fg = "#809980" }

        -- Anchors, aliases and tags
        hl["@label.yaml"] = { fg = "#ce9178" }
        hl["@attribute.yaml"] = { fg = "#ce9178" }
        hl["@type.yaml"] = { fg = "#ce9178" }
        hl["@tag.yaml"] = { fg = "#ce9178" }

        -- Comments and punctuation
        hl["@comment.yaml"] = { fg = "#5f6167", italic = false }
        hl["@operator.yaml"] = { fg = "#d4d4d4" }
        hl["@punctuation.bracket.yaml"] = { fg = "#d4d4d4" }
        hl["@punctuation.delimiter.yaml"] = { fg = "#d4d4d4" }
        hl["@punctuation.special.yaml"] = { fg = "#ce9178" }

        -- LSP semantic tokens can override Tree-sitter in TypeScript/TSX.
        hl["@lsp.type.class.typescriptreact"] = { fg = "#4fc1ff" }
        hl["@lsp.type.interface.typescriptreact"] = { fg = "#4fc1ff" }
        hl["@lsp.type.property.typescriptreact"] = { fg = "#9cdcfe" }
        hl["@lsp.type.variable.typescriptreact"] = { fg = "#d4d4d4" }
        hl["@lsp.type.parameter.typescriptreact"] = { fg = "#9cdcfe" }
        hl["@lsp.type.function.typescriptreact"] = { fg = "#dcdCAA" }
        hl["@lsp.type.method.typescriptreact"] = { fg = "#dcdCAA" }
        hl["@lsp.type.enumMember.typescriptreact"] = { fg = "#4fc1ff" }

        -- Markdown close to the VS Code screenshot
        hl["@markup.heading.1.markdown"] = { fg = "#4fc1ff", bold = true }
        hl["@markup.heading.2.markdown"] = { fg = "#4fc1ff", bold = true }
        hl["@markup.heading.3.markdown"] = { fg = "#4fc1ff", bold = true }
        hl["@markup.heading.4.markdown"] = { fg = "#4fc1ff", bold = true }
        hl["@markup.heading.5.markdown"] = { fg = "#4fc1ff", bold = true }
        hl["@markup.heading.6.markdown"] = { fg = "#4fc1ff", bold = true }
        hl["@markup.list.markdown"] = { fg = "#64afef" }
        hl["@markup.raw.markdown_inline"] = { fg = "#ce9178" }
        hl["@markup.raw.block.markdown"] = { fg = fg }
        hl["@markup.link.label.markdown_inline"] = { fg = "#4fc1ff" }
        hl["@markup.link.url.markdown_inline"] = { fg = "#4fc1ff", underline = true }

        -- Common LazyVim plugin groups
        hl.SnacksIndent = { fg = "#333844" }
        hl.SnacksIndentScope = { fg = "#585c66" }
        hl.SnacksPickerBorder = { fg = "#535973", bg = "#252526" }
        hl.SnacksPickerNormal = { fg = fg, bg = "#252526" }

        hl.TelescopeNormal = { fg = fg, bg = "#252526" }
        hl.TelescopeBorder = { fg = "#535973", bg = "#252526" }
        hl.TelescopeSelection = { fg = fg, bg = "#04395e" }

        hl.CmpItemAbbr = { fg = fg }
        hl.CmpItemAbbrMatch = { fg = "#4fc1ff", bold = true }
        hl.CmpItemAbbrMatchFuzzy = { fg = "#4fc1ff" }
        hl.CmpItemMenu = { fg = "#808080" }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
