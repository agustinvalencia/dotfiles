local core_lsp = require("core.lsp")

return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  capabilities = core_lsp.capabilities,
  on_attach = core_lsp.on_attach,

  -- filetypes and root detection are optional; native loader usually handles it
  -- filetypes = { "rust" },
  -- root_markers = { "Cargo.toml", "rust-project.json", ".git" },

  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = { buildScripts = { enable = true } },
      procMacro = { enable = true },
      checkOnSave = { command = "check" },
      inlayHints = { 
        typeHints = { enable = false },
        parameterHints = { enable = false },
        chainingHints = { enable = false },
        lifetimeElisionHints = { enable = false }
    },
      lens = { enable = true },
    },
  },
}
