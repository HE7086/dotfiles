local M = {}

local get_path_separator = function()
    if vim.fn.has("win32") == 1 or vim.fn.has("win32unix") then
        return "/"
    else
        return "\\"
    end
end

M.path_separator = get_path_separator()

M.split = function(path)
    local pattern = string.format("([^%s]+)", M.path_separator)
    local result = {}

    for str in string.gmatch(path, pattern) do
        table.insert(result, str)
    end

    return result
end

M.join = function(...)
    local args = { ... }
    if #args == 0 then
        return ""
    end

    local result = {}

    if args[1]:sub(1, 1) == M.path_separator then
        -- empty object for abs path
        table.insert(result, '')
    end

    for _, arg in ipairs(args) do
        for _, part in ipairs(M.split(arg)) do
            table.insert(result, part)
        end
    end

    return table.concat(result, M.path_separator)
end

M.exists = function(path)
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    end
    return false
end

return M
