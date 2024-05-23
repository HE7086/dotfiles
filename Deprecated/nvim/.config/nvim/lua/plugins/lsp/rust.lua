-- pacman -S rust_analyzer
require('lspconfig').rust_analyzer.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}
