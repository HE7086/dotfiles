-- pacman -S rust_analyzer
require('lspconfig').zls.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}
