require('plugins.lsp.bash-language-server')
require('plugins.lsp.clangd')
-- require('plugins.lsp.haskell-language-server')
require('plugins.lsp.lua-language-server')
require('plugins.lsp.pyright')
require('plugins.lsp.texlab')

-- auto show diagnostic hover
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		underline = true,
		signs = true,
	}
)
vim.cmd 'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()'
vim.cmd 'autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()'

local map = require('util.keymap').map

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
