local M = {}

function M.map(mode, lhs, rhs, opts)
    opts = opts or {noremap = false, silent = mode ~= 'c'}
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function M.nmap(lhs, rhs, opts)
    M.map('n', lhs, rhs, opts)
end

function M.noremap(mode, lhs, rhs, opts)
    opts = opts or {noremap = true, silent = mode ~= 'c'}
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function M.noremap_all(lhs, rhs, opts)
    opts = opts or {noremap = true, silent = true}
    vim.api.nvim_set_keymap('', lhs, rhs, opts)
    vim.api.nvim_set_keymap('!', lhs, rhs, opts)
end

return M
