-- pacman -S clangd
require('lspconfig').clangd.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}
