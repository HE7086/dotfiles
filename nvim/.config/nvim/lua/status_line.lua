local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {}

-- highlight groups
M.colors = {
    active   = "%#MyStatusLine#",
    inactive = "%#MyStatuslineNC#",
    mode     = "%#MyStatusLineMode#",
    git      = "%#MyStatusLineGit#",
    filetype = "%#MyStatusLineFiletype#",
    line_col = "%#MyStatusLineLineCol#",
}

-- if current window is less than N column
function M.short_mode(width)
    return width > vim.api.nvim_win_get_width(0)
end

-- string representation of current mode
function M.mode()
    -- mode table
    local modes = setmetatable({
        ["n"]    = { "Normal", "N" };
        ["no"]   = { "N-Pending", "N-P" };
        ["v"]    = { "Visual", "V" };
        ["V"]    = { "V-Line", "V-L" };
        ["\x16"] = { "V-Block", "V-B" };
        ["s"]    = { "Select", "S" };
        ["S"]    = { "S-Line", "S-L" };
        ["\x13"] = { "S-Block", "S-B" };
        ["i"]    = { "Insert", "I" };
        ["ic"]   = { "Insert", "I" };
        ["R"]    = { "Replace", "R" };
        ["Rv"]   = { "V-Replace", "V-R" };
        ["c"]    = { "Command", "C" };
        ["cv"]   = { "Vim-Ex", "V-E" };
        ["ce"]   = { "Ex", "E" };
        ["r"]    = { "Prompt", "P" };
        ["rm"]   = { "More", "M" };
        ["r?"]   = { "Confirm", "C" };
        ["!"]    = { "Shell", "S" };
        ["t"]    = { "Terminal", "T" };
    }, {
        __index = function()
            return { "Unknown", "U" }
        end
    })

    local current_mode = vim.api.nvim_get_mode().mode
    if M.short_mode(80) then
        return string.format(" %-3s ", modes[current_mode][2])
    else
        return string.format(" %-7s ", modes[current_mode][1]):upper()
    end
end

-- get git status, when long enough also file modification status
function M.git_status()
    -- use fallback because it doesn"t set this variable on the initial `BufEnter`
    local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }

    if signs.head == "" then
        return ""
    elseif M.short_mode(80) then
        return string.format("%s", signs.head)
    elseif M.short_mode(100) then
        return string.format("  %s  ", signs.head)
    else
        local str = " "
        if signs.added and signs.added ~= 0 then
            str = str .. "+" .. signs.added .. " "
        end
        if signs.changed and signs.changed ~= 0 then
            str = str .. "~" .. signs.changed .. " "
        end
        if signs.removed and signs.removed ~= 0 then
            str = str .. "-" .. signs.removed .. " "
        end
        if str ~= " " then
            str = str .. "| "
        end
        return str .. " " .. signs.head .. " "
    end
end

-- get filename information. when lsp is loading, show that instead
function M.filename_lsp()
    local message = vim.lsp.util.get_progress_messages()
    if #message > 0 then
        local lsp = message[#message]
        local name = lsp.name or ""
        local msg = lsp.message or ""
        local percentage = lsp.percentage or 0
        local title = lsp.title or ""
        return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
    end
    if M.short_mode(100) then
        return " %<%r%f%m "
    else
        return " %<%r%F%m "
    end
end

-- get buffer number
function M.bufnum()
    if M.short_mode(80) then
        return ""
    else
        return "[%n] "
    end
end

--get misc filetype info
function M.ft_misc()
    local fe = vim.bo.fileencoding
    local ff = vim.bo.ff

    local msg = ""

    -- only show info when not standard unix
    if M.short_mode(80) then
        return ""
    elseif fe ~= "utf-8" and fe ~= "" then
        msg = msg .. "[" .. fe .. "] "
    elseif ff ~= "unix" and fe ~= "" then
        msg = msg .. "[" .. ff .. "] "
    end
    return msg
end

-- get filetype with icons
function M.filetype()
    local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
    local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })

    if vim.bo.filetype == "" then
        return ""
    elseif M.short_mode(80) then
        return string.format("%s", vim.bo.filetype)
    else
        return string.format(" %s %s ", icon, vim.bo.filetype)
    end
end

-- get line and column info
function M.line_col()
    if M.short_mode(80) then
        return "%l:%c"
    else
        return " %4l :%3c "
    end
end

-- active color scheme
function M.set_active()
    return table.concat({
        M.colors.active,
        M.colors.mode .. M.mode(),
        M.colors.git .. M.git_status(),
        M.colors.inactive,
        "%=", M.filename_lsp(), "%=",
        M.bufnum(), M.ft_misc(),
        M.colors.filetype .. M.filetype(),
        M.colors.line_col .. M.line_col()
    })
end

-- inactive color scheme
function M.set_inactive()
    return M.colors.inactive .. "%= %F %="
end

augroup("MyStatusLine", { clear = true })
autocmd({ "WinEnter", "BufEnter", "BufWritePost" }, {
    group = "MyStatusLine",
    pattern = "*",
    callback = function()
        vim.wo.statusline = M.set_active()
    end,
})
autocmd("User", {
    group = "MyStatusLine",
    pattern = {"LspProgressUpdate", "LspRequest", "GitSignsUpdate" },
    callback = function()
        vim.wo.statusline = M.set_active()
        -- automatically clears lsp message in 2 seconds
        vim.defer_fn(function()
            vim.wo.statusline = M.set_active()
        end, 2000)
    end,
})
autocmd({ "WinLeave", "BufLeave" }, {
    group = "MyStatusLine",
    pattern = "*",
    callback = function()
        vim.wo.statusline = M.set_inactive()
    end,
})
local timer = vim.loop.new_timer()
timer:start(2000, 0, vim.schedule_wrap(function()
    vim.wo.statusline = M.set_active()
end))

-------------------- color scheme --------------------

function M.MyStatusLineColorScheme()
    local hi = vim.api.nvim_set_hl
    hi(0, "MyStatusline", { bg = "#abb2bf", fg = "#4b5263" })
    hi(0, "MyStatuslineNC", { bg = "#4b5263", fg = "#abb2bf" })
    hi(0, "MyStatusLineMode", { bg = "#98c379", fg = "#181a1f", bold = true })
    hi(0, "MyStatusLineGit", { bg = "#d19a66", fg = "#181a1f" })
    hi(0, "MyStatusLineFiletype", { bg = "#61afef", fg = "#181a1f" })
    hi(0, "MyStatusLineLineCol", { bg = "#c678dd", fg = "#181a1f" })
end

-- automatically load the status line
augroup("MyStatusLineColor", { clear = true })
autocmd("ColorScheme", {
    group = "MyStatusLineColor",
    pattern = "*",
    callback = M.MyStatusLineColorScheme
})

return M
