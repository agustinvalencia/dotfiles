local core_lsp = require("core.lsp")
return {
    cmd = 'typescript-language-server',
    filetype = {'typescript', 'javascript'},
    on_attach = core_lsp.on_attach,
    capabilities = core_lsp.capabilities,
}
