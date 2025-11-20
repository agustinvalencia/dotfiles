local core_lsp = require("core.lsp")
local cfgdir = vim.fn.stdpath("config")
return {
  cmd = { "ltex-ls" },
  on_attach = core_lsp.on_attach,
  capabilities = core_lsp.capabilities,
  filetypes = {
    "tex",
    "markdown",
    "mdx",
    -- "typst",
    "gitcommit",
    "text",
  },

  root_markers = {
    ".git",
    "latexindent.yaml",
    ".latexmkrc",
    -- "typst.toml",
    ".marksman.toml",
  },

  settings = {
    ltex = {
      language = "en-GB",
      additionalRules = {
        motherTongue = "es-ES",
        -- enablePickyRules = true, -- uncomment if you want stricter checks
      },
      latex = {
        commands = {
          ["\\cite{}"] = "ignore",
        },
      },
      -- External dictionary files: LTeX expects entries with a leading ':'
      -- It will read and (via code actions) append to these files as needed.
      dictionary = {
        ["en-GB"] = { ":" .. cfgdir .. "/ltex/en-GB.txt" },
        ["es-ES"] = { ":" .. cfgdir .. "/ltex/es-ES.txt" },
        ["sv-SE"] = { ":" .. cfgdir .. "/ltex/sv-SE.txt" },
      },
      -- Trim some noisy rules for tech writing (tune to taste)
      disabledRules = {
        ["en-GB"] = { "EN_UNPAIRED_BRACKETS", "COMMA_PARENTHESIS_WHITESPACE", "OXFORD_SPELLING_Z_NOT_S" },
      },
    },
  },
}
