require('nvim-treesitter.configs').setup {
    -- ensure_installed = "maintained",
    ensure_installed = {
        'bash',
        'bibtex',
        'c',
        'cmake',
        'comment',
        'cpp',
        'html',
        'json',
        'kotlin',
        'latex',
        'lua',
        'make',
        'python',
        'rust',
        'toml',
        'vim',
        'yaml',
    },
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
