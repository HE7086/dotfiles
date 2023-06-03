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
vim.api.nvim_create_augroup("lspCursorHold", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = "lspCursorHold",
    pattern = "*",
    callback = function()
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "lspCursorHold",
            pattern = "*",
            callback = function()
                vim.diagnostic.get()
            end
        })
        -- vim.api.nvim_create_autocmd("CursorHoldI", {
        --     group = "lspCursorHold",
        --     pattern = "*",
        --     callback = function()
        --         vim.lsp.buf.signature_help()
        --     end
        -- })
    end
})

local nmap = require('util.keymap').nmap

nmap('gD', vim.lsp.buf.declaration)
nmap('gd', vim.lsp.buf.definition)
nmap('gt', vim.lsp.buf.type_definition)
nmap('gi', vim.lsp.buf.implementation)
nmap('gr', vim.lsp.buf.references)
nmap('K', vim.lsp.buf.hover)
nmap('<C-k>', vim.lsp.buf.signature_help)
nmap('g[', vim.diagnostic.goto_prev)
nmap('g]', vim.diagnostic.goto_next)
nmap('<F18>', vim.lsp.buf.rename) -- shift F6 for terminal
nmap('<S-F6>', vim.lsp.buf.rename) -- shift F6 for gui
nmap('<A-CR>', vim.lsp.buf.code_action)
nmap('<space><space>', function() vim.lsp.buf.format { async = true } end)
nmap('<space>e', vim.diagnostic.open_float)
nmap('<F4>', '<CMD>LspStart<CR>')
