-- pacman -S bash-language-server
require('lspconfig').bashls.setup {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
}