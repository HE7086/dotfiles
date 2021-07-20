require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained",
    -- ignore_install = { "javascript" },
    highlight = {
        enable = true,
        -- disable = { "c", "rust" },
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    }
}
