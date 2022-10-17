-- pacman -S texlab
require('lspconfig').texlab.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}
