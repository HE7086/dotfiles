local path = require("plenary.path")

local M = {}

function M.run_file()
    local runners = setmetatable({
        ["c"] = function(dir, file, exe)
            return string.format("cd %s && gcc %s && %s", dir, file, exe, path.joinpath(dir, exe))
        end,
        ["cpp"] = function(dir, file, exe)
            return string.format("cd %s && g++ -std=c++23 -lfmt %s && %s", dir, file, exe, path.joinpath(dir, exe))
        end,
        ["rust"] = function(dir, file, exe)
            return string.format("cd %s && rustc %s && %s", dir, file, exe, path.joinpath(dir, exe))
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
            return path.exists(path.joinpath(folder, 'Cargo.toml'))
        end,
    }, {
        __index = function()
            return false
        end,
    })
    local runners = setmetatable({
        ["rust"] = "cargo run",
    }, { __index = nil })

    local cwd = nil
    for _, e in pairs(workingDirectory) do
        if (is_project[filetype](e)) then
            cwd = e
        end
    end
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
