-- paru -S cmake-lanuage-server
require('lspconfig').cmake.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}
