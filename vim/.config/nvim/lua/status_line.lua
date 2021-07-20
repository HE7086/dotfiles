local fn = vim.fn
local api = vim.api

-- highlight groups
local colors = {
    active        = '%#StatusLine#',
    inactive      = '%#StatuslineNC#',
    mode          = '%#StatusLineMode#',
    git           = '%#StatusLineGit#',
    filetype      = '%#StatusLineFiletype#',
    line_col      = '%#StatusLineLineCol#',
}

-- if current window is less than N column
local function short_mode(width)
    return width > api.nvim_win_get_width(0)
end

-- string representation of current mode
local function mode()
    -- mode table
    local modes = setmetatable({
        ['n']    = {'Normal',    'N'};
        ['no']   = {'N-Pending', 'N-P'} ;
        ['v']    = {'Visual',    'V' };
        ['V']    = {'V-Line',    'V-L' };
        ['\x16'] = {'V-Block',   'V-B'};
        ['s']    = {'Select',    'S'};
        ['S']    = {'S-Line',    'S-L'};
        ['\x13'] = {'S-Block',   'S-B'};
        ['i']    = {'Insert',    'I'};
        ['ic']   = {'Insert',    'I'};
        ['R']    = {'Replace',   'R'};
        ['Rv']   = {'V-Replace', 'V-R'};
        ['c']    = {'Command',   'C'};
        ['cv']   = {'Vim-Ex',    'V-E'};
        ['ce']   = {'Ex',        'E'};
        ['r']    = {'Prompt',    'P'};
        ['rm']   = {'More',      'M'};
        ['r?']   = {'Confirm',   'C'};
        ['!']    = {'Shell',     'S'};
        ['t']    = {'Terminal',  'T'};
    }, { __index = function() return {'Unknown', 'U'} end })

    local current_mode = api.nvim_get_mode().mode
    if short_mode(80) then
        return string.format(' %-3s ', modes[current_mode][2])
    else
        return string.format(' %-7s ', modes[current_mode][1]):upper()
    end
end

-- get git status, when long enough also file modification status
local function git_status()
    -- use fallback because it doesn't set this variable on the initial `BufEnter`
    local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}

    if signs.head == '' then
        return ''
    elseif short_mode(80) then
        return string.format('%s', signs.head)
    elseif short_mode(100) then
        return string.format('  %s ', signs.head)
    else
        return string.format(
            ' +%s ~%s -%s |  %s ',
            signs.added, signs.changed, signs.removed, signs.head
        )
    end
end

-- get filename information. when lsp is loading, show that instead
local function filename_lsp()
    local lsp = vim.lsp.util.get_progress_messages()[1]
    if lsp then
        local name = lsp.name or ""
        local msg = lsp.message or ""
        local percentage = lsp.percentage or 0
        local title = lsp.title or ""
        return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
    end
    if short_mode(100) then
        return " %<%r%f%m "
    else
        return " %<%r%F%m "
    end
end

-- get filetype with icons
local function filetype()
    local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
    local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })

    if vim.bo.filetype == '' then
        return ''
    elseif short_mode(80) then
        return string.format('%s', vim.bo.filetype)
    else
        return string.format(' %s %s ', icon, vim.bo.filetype)
    end
end

-- get line and column info
local function line_col()
    if short_mode(80) then
        return '%l:%c'
    else
        return ' %4l : %3c '
    end
end

-- active color scheme
local function set_active()
    return table.concat({
        colors.active,
        colors.mode .. mode(),
        colors.git .. git_status(),
        colors.inactive,
        "%=", filename_lsp(), "%=",
        colors.filetype .. filetype(),
        colors.line_col .. line_col()
    })
end

-- inactive color scheme
local function set_inactive()
    return colors.inactive .. '%= %F %='
end

-- explorer color scheme
local function set_explorer()
    local title = colors.mode .. '   '
    local title_alt = colors.mode_alt

    return table.concat({ colors.active, title, title_alt })
end

Statusline = function(current_state)
    local state = setmetatable({
        ['active']   = set_active(),
        ['inactive'] = set_inactive(),
        ['explorer'] = set_explorer(),
    }, { __index = function() return set_active() end })
    return state[current_state]
end

api.nvim_exec([[
augroup Statusline
au!
au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
augroup END
]], false)


-------------------- color scheme --------------------

local function set_hl(group, options)
    local bg = options.bg == nil and '' or 'guibg=' .. options.bg
    local fg = options.fg == nil and '' or 'guifg=' .. options.fg
    local gui = options.gui == nil and '' or 'gui=' .. options.gui
    local link = options.link or false
    local target = options.target

    if not link then
        vim.cmd(string.format('hi %s %s %s %s', group, bg, fg, gui))
    else
        vim.cmd(string.format('hi! link', group, target))
    end
end

OverrideColorscheme = function()
    local highlights = {
        {'StatusLine',         {bg = '#4b5263', fg = '#abb2bf'}},
        {'StatuslineNC',       {bg = '#abb2bf', fg = '#4b5263'}},
        {'StatusLineMode',     {bg = '#98c379', fg = '#181a1f'}},
        {'StatusLineGit',      {bg = '#d19a66', fg = '#181a1f'}},
        {'StatusLineFiletype', {bg = '#61afef', fg = '#181a1f'}},
        {'StatusLineLineCol',  {bg = '#c678dd', fg = '#181a1f'}},
    }
    for _, highlight in pairs(highlights) do
        set_hl(highlight[1], highlight[2])
    end
end

-- automatically override colourscheme
vim.api.nvim_exec([[
augroup NewColor
au!
au ColorScheme one call v:lua.OverrideColorscheme()
augroup END
]], false)
