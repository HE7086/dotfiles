require('plugins.lsp.bash')
require('plugins.lsp.clangd')
-- require('plugins.lsp.haskell')
require('plugins.lsp.lua')
require('plugins.lsp.pyright')
require('plugins.lsp.texlab')
require('plugins.lsp.rust')
require('plugins.lsp.cmake')

-- auto show diagnostic hover
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
}
)
vim.cmd('autocmd CursorHold * lua vim.diagnostic.get()')
vim.cmd('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')

local nmap = require('util.keymap').nmap

nmap('gD', '<CMD>lua vim.lsp.buf.declaration()<CR>')
nmap('gd', '<CMD>lua vim.lsp.buf.definition()<CR>')
nmap('gt', '<CMD>lua vim.lsp.buf.type_definition()<CR>')
nmap('gi', '<CMD>lua vim.lsp.buf.implementation()<CR>')
nmap('gr', '<CMD>lua vim.lsp.buf.references()<CR>')
nmap('K', '<CMD>lua vim.lsp.buf.hover()<CR>')
nmap('<C-k>', '<CMD>lua vim.lsp.buf.signature_help()<CR>')
nmap('g[', '<CMD>lua vim.diagnostic.goto_prev()<CR>')
nmap('g]', '<CMD>lua vim.diagnostic.goto_next()<CR>')
nmap('<F18>', '<CMD>lua vim.lsp.buf.rename()<CR>') -- shift F6 for terminal
nmap('<S-F6>', '<CMD>lua vim.lsp.buf.rename()<CR>') -- shift F6 for gui
nmap('<A-CR>', '<CMD>lua vim.lsp.buf.code_action()<CR>')
nmap('<space><space>', '<CMD>lua vim.lsp.buf.formatting()<CR>')
nmap('<space>e', '<CMD>lua vim.diagnostic.open_float()<CR>')
