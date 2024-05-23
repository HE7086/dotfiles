-- pacman -S bash-language-server
require('lspconfig').bashls.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}
