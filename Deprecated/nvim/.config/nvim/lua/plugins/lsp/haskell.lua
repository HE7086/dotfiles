-- pacman -S haskell-language-server
require('lspconfig').hls.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}
