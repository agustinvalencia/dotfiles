local core_lsp = require("core.lsp")

return {
    on_attach = core_lsp.on_attach,
    capabilities = core_lsp.capabilities,

    settings = {
        ["rust-analyzer"] = {
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
                command = "check",
            },
        },
    },
}
