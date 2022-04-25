local M = {}

function M.any(table, fun)
    for _, e in pairs(table) do
        if fun(e) then
            return true
        end
    end
    return false
end

function M.all(table, fun)
    for _, e in pairs(table) do
        if not fun(e) then
            return false
        end
    end
    return true
end

function M.none(table, fun)
    for _, e in pairs(table) do
        if fun(e) then
            return false
        end
    end
    return true
end

function M.find(table, fun)
    for _, e in pairs(table) do
        if fun(e) then
            return e
        end
    end
    return nil
end

return M
