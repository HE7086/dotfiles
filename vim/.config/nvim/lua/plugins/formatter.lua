require('formatter').setup{
    logging = false,
    filetype = {
        -- lua = {
        --     exe = "luafmt",
        --     args = {"--indent-count", 2, "--stdin"},
        --     stdin = true,
        -- },
        c = {
            function()
                return {
                    exe = "clang-format",
                    args = {"-style=LLVM"},
                    stdin = true,
                }
            end
        },
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {},
                    stdin = true,
                }
            end
        },
        rust = {
            function()
                return {
                    exe = "rustfmt",
                    args = {"--emit=stdout"},
                    stdin = true
                }
            end
        },
    }
}
