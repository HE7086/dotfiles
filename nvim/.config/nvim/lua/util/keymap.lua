local Keymap = {}

function Keymap.map(mode, lhs, rhs, opts)
    opts = opts or {noremap = false, silent = mode ~= 'c'}
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function Keymap.nmap(lhs, rhs, opts)
    Keymap.map('n', lhs, rhs, opts)
end

function Keymap.noremap(mode, lhs, rhs, opts)
    opts = opts or {noremap = true, silent = mode ~= 'c'}
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function Keymap.noremap_all(lhs, rhs, opts)
    opts = opts or {noremap = true, silent = true}
    vim.api.nvim_set_keymap('', lhs, rhs, opts)
    vim.api.nvim_set_keymap('!', lhs, rhs, opts)
end

return Keymap
