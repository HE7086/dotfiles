local path = require("util.path")
local find = require("util.functional").find

-- run code in terminal
-- vim.cmd([[
-- augroup AutoRunCode
-- autocmd!
-- autocmd BufRead,BufNewFile *.sh nnoremap <F22> :w<CR>:tabnew | term zsh %<CR>
-- autocmd BufRead,BufNewFile *.hs nnoremap <F22> :w<CR>:tabnew | term ghci %<CR>
-- autocmd BufRead,BufNewFile *.c nnoremap <F22> :w<CR>:tabnew | term clang % -o test.out && ./test.out<CR>
-- autocmd BufRead,BufNewFile *.cpp nnoremap <F22> :w<CR>:tabnew | term clang++ -std=c++20 % -o test.out && ./test.out<CR>
-- autocmd BufRead,BufNewFile *.py nnoremap <F22> :w<CR>:tabnew | term python %<CR>
-- autocmd BufRead,BufNewFile *.cprf nnoremap <F22> :w<CR>:tabnew | term cyp <C-R>=expand('%:r')<CR>.cthy % <CR>
-- autocmd BufRead,BufNewFile *.rs nnoremap <F22> :w<CR>:tabnew | term cargo run<CR>
-- augroup END
-- ]])

local M = {}

function M.run_file()
    local runners = setmetatable({
        ["c"] = function(dir, file, exe)
            return string.format("cd %s && gcc %s -o %s && %s", dir, file, exe, path.join(dir, exe))
        end,
        ["cpp"] = function(dir, file, exe)
            return string.format("cd %s && g++ -march=native -lfmt %s -o %s && %s", dir, file, exe, path.join(dir, exe))
        end,
        ["rust"] = function(dir, file, exe)
            return string.format("cd %s && rustc %s -o %s && %s", dir, file, exe, path.join(dir, exe))
        end,
        ["python"] = "python",
        ["haskell"] = "runhaskell",
        ["sh"] = "bash",
    }, { __index = nil, })

    local dir = vim.fn.expand("%:h")
    local file = vim.fn.expand("%")
    local exe = vim.fn.expand("%:r")
    local filetype = vim.bo.filetype
    local runner = runners[filetype]
    local command = nil

    if type(runner) == "string" then
        command = runner .. " " .. vim.fn.expand("%:p")
    elseif type(runner) == "function" then
        command = runner(dir, file, exe)
    else
        return
    end

    vim.api.nvim_command("tabnew | terminal " .. command)
end

function M.run_project()
    local filetype = vim.bo.filetype
    local workingDirectory = vim.lsp.buf.list_workspace_folders()
    local is_project = setmetatable({
        ["rust"] = function(folder)
            return path.exists(path.join(folder, 'Cargo.toml'))
        end,
    }, {
        __index = function()
            return false
        end,
    })
    local runners = setmetatable({
        ["rust"] = "cargo run",
    }, { __index = nil })

    local cwd = find(workingDirectory, is_project[filetype])
    if cwd then
        vim.api.nvim_command(string.format("tabnew | terminal cd %s && %s", cwd, runners[filetype]))
        return true
    end

    return false
end

function M.run()
    if not M.run_project() then
        M.run_file()
    end
end

return M
