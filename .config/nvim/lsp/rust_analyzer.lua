return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = require("lspconfig.util").root_pattern("Cargo.toml"),
  settings = {
    ["rust-analyzer"] = {
      -- It is recommended to enable these settings for a better experience
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        -- You can choose to have diagnostics checked on save.
        -- The default is "check", which is generally what you want.
        command = "check",
      },
    },
  },
}
