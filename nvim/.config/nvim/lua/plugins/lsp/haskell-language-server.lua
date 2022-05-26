-- pacman -S haskell-language-server
require('lspconfig').hls.setup {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
