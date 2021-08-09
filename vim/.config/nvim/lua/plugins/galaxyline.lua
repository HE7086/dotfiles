local colors = require('galaxyline.theme').default

local color_mode = setmetatable({
    ['n']    = {colors.green,   'Normal',    'N'},
    ['no']   = {colors.green,   'N-Pending', 'N-P'},
    ['v']    = {colors.blue,    'Visual',    'V'},
    ['V']    = {colors.blue,    'V-Line',    'V-L'},
    ['\x16'] = {colors.blue,    'V-Block',   'V-B'},
    ['s']    = {colors.red,     'Select',    'S'},
    ['S']    = {colors.red,     'S-Line',    'S-L'},
    ['\x13'] = {colors.red,     'S-Block',   'S-B'},
    ['i']    = {colors.orange,  'Insert',    'I'},
    ['ic']   = {colors.orange,  'Insert',    'I'},
    ['R']    = {colors.magenta, 'Replace',   'R'},
    ['Rv']   = {colors.magenta, 'V-Replace', 'V-R'},
    ['c']    = {colors.cyan,    'Command',   'C'},
    ['cv']   = {colors.cyan,    'Vim-Ex',    'V-E'},
    ['ce']   = {colors.cyan,    'Ex',        'E'},
    ['r']    = {colors.violet,  'Prompt',    'P'},
    ['rm']   = {colors.violet,  'More',      'M'},
    ['r?']   = {colors.violet,  'Confirm',   'C'},
    ['!']    = {colors.violet,  'Shell',     'S'},
    ['t']    = {colors.violet,  'Terminal',  'T'},
}, { __index = function() return {colors.yellow, 'Unkonwn', 'U'} end })

require('galaxyline').section.left[1] = {
    ViMode = {
        provider = function()
            return string.format('  %-7s', color_mode[vim.fn.mode()][2]:upper())
        end,
        highlight = {colors.fg, colors.bg, 'bold'},
        separator = ' ',
        separator_highlight = {colors.fg, colors.bg, 'bold'}
    }
}

require('galaxyline').section.left[2] = {
    GitStatus = {
        provider = function()
            local vcs = require('galaxyline.provider_vcs')
            local str = ' ' .. vcs.get_git_branch() .. ' '
            if vcs.diff_add() then
                str = str .. ' +' .. vcs.diff_add()
            end
            if vcs.diff_modified() then
                str = str .. ' ~' .. vcs.diff_modified()
            end
            if vcs.diff_remove() then
                str = str .. ' -' .. vcs.diff_remove()
            end
            return str
        end,
        highlight = {colors.fg, colors.bg, 'bold'},
        separator = ' ',
        condition = require('galaxyline.condition').check_git_workspace
    }
}

---------------------------------------------
-------------------- mid --------------------
---------------------------------------------

require('galaxyline').section.mid[1] = {
    FileName_LSP = {
        provider = function()
            local lsp_msg = vim.lsp.util.get_progress_messages()[1]
            if lsp_msg then
                local name = lsp_msg.name or ''
                local msg = lsp_msg.message or ''
                local percentage = lsp_msg.percentage or 0
                local title = lsp_msg.title or ''
                return string.format(' %s: %s %s (%s%%) ', name, title, msg, percentage)
            else
                local str = string.format("[%s] %s", vim.fn.bufnr(''), vim.fn.expand('%:t'))
                if vim.bo.readonly or vim.bo.filetype == 'help' then
                    str = str .. ' [RO]'
                elseif vim.bo.modified then
                    str = str .. ' [+]'
                end
                return str
            end
        end,
        separator = ' ',
    }
}

-----------------------------------------------
-------------------- right --------------------
-----------------------------------------------

require('galaxyline').section.right[1] = {
    LSPStatus = {
        provider = function()
            local diag = require('galaxyline.provider_diagnostic')
            local str = ''
            if diag.get_diagnostic_error() then
                str = str .. ' x' .. diag.get_diagnostic_error()
            end
            if diag.get_diagnostic_warn() then
                str = str .. ' !' .. diag.get_diagnostic_warn()
            end
            if diag.get_diagnostic_hint() then
                str = str .. ' *' .. diag.get_diagnostic_hint()
            end
            if diag.get_diagnostic_info() then
                str = str .. ' ?' .. diag.get_diagnostic_info()
            end
            return str
        end,
        highlight = {colors.fg, colors.bg, 'bold'},
        separator = ' ',
        separator_highlight = {colors.fg, colors.bg, 'bold'},
        condition = require('galaxyline.condition').check_active_lsp
    },
}

require('galaxyline').section.right[2] = {
    FileMisc = {
        provider = function()
            return string.format(' %s %s ', vim.bo.fenc, vim.bo.fileformat)
        end,
        condition = function()
            return vim.bo.fenc ~= 'utf-8' or vim.bo.fileformat ~= 'unix'
        end,
        highlight = {colors.fg, colors.bg, 'bold'},
        separator = ' ',
        separator_highlight = {colors.fg, colors.bg, 'bold'},
    }
}

require('galaxyline').section.right[3] = {
    FileStatus = {
        provider = function()
            local icon = require('nvim-web-devicons').get_icon(
                vim.fn.expand('%:t'), vim.fn.expand('%:e'), {default = true})
            return icon .. ' ' .. vim.bo.filetype:upper()
        end,
        highlight = {colors.fg, colors.bg, 'bold'},
        separator = ' ',
        separator_highlight = {colors.fg, colors.bg, 'bold'},
    },
}

require('galaxyline').section.right[4] = {
    LineColumn = {
        provider = function()
            return string.format('%4d :%3d ', vim.fn.line('.'), vim.fn.col('.'))
        end,
        highlight = {colors.fg, colors.bg, 'bold'},
        separator = ' ',
        separator_highlight = {colors.fg, colors.bg, 'bold'},
    }
}
