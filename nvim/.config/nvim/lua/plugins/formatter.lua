local prettier = function()
    return {
        exe = "prettier",
        args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
        stdin = true,
    }
end

require("formatter").setup({
    logging = false,
    filetype = {
        c = {
            function()
                return {
                    exe = "clang-format",
                    args = { "-style=LLVM" },
                    stdin = true,
                }
            end,
        },
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {},
                    stdin = true,
                }
            end,
        },
        rust = {
            function()
                return {
                    exe = "rustfmt",
                    args = { "--emit=stdout" },
                    stdin = true,
                }
            end,
        },
        json = {
            function()
                return {
                    exe = "jq",
                    args = {},
                    stdin = true,
                }
            end,
        },
        python = {
            function()
                return {
                    exe = "black",
                    args = { "-" },
                    stdin = true,
                }
            end,
        },
        sh = {
            function()
                return {
                    exe = "shfmt",
                    args = { "-i", "2", "-ci", "-bn" },
                    stdin = true,
                }
            end,
        },
        lua = {
            function()
                return {
                    exe = "stylua",
                    args = { "-" },
                    stdin = true,
                }
            end,
        },
        xml = { prettier },
        toml = { prettier },
        yaml = { prettier },
        markdown = { prettier },
    },
})
