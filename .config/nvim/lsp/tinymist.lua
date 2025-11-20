local core_lsp = require("core.lsp")
return {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    on_attach = core_lsp.on_attach,
    capabilities = core_lsp.capabilities,
    settings = {
        formatterMode = "typstyle",
        formatterPrintWidth = 100,
        formatterIndentSize = 4,
        semanticTokens = "enable",
        exportTarget = "paged",
        exportPdf = "onType",
    },
}
