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
