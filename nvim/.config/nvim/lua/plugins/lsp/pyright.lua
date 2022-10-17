-- pacman -S pyright
require('lspconfig').pyright.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}
