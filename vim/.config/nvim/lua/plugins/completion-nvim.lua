local map = require('util.keymap').map

vim.cmd [[autocmd BufEnter * lua require('completion').on_attach()]]
vim.o.completeopt='menuone,noinsert,noselect'


-- actually nvim-lspconfig configuration
vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

map('i', '<Tab>',   '<Plug>(completion_smart_tab)')
map('i', '<S-Tab>', '<Plug>(completion_smart_s_tab)')

map('n', 'gD',     '<CMD>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd',     '<CMD>lua vim.lsp.buf.definition()<CR>')
map('n', 'K',      '<CMD>lua vim.lsp.buf.hover()<CR>')
map('n', 'gi',     '<CMD>lua vim.lsp.buf.implementation()<CR>')
map('n', '<C-k>',  '<CMD>lua vim.lsp.buf.signature_help()<CR>')
map('n', 'gr',     '<CMD>lua vim.lsp.buf.references()<CR>')
map('n', 'g[',     '<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', 'g]',     '<CMD>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<F18>',  '<CMD>lua vim.lsp.buf.rename()<CR>') -- shift F6
map('n', '<A-CR>', '<CMD>lua vim.lsp.buf.code_action()<CR>')
