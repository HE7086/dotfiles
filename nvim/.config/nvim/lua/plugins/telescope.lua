local noremap = require('util.keymap').noremap
local actions = require('telescope.actions')

require('telescope').setup{
    pickers = {
        buffers = {
            on_complete = { function() vim.cmd 'stopinsert' end },
            mappings = {
                n = {
                    ['j'] = actions.move_selection_next,
                    ['k'] = actions.move_selection_previous,
                    ['l'] = actions.select_default + actions.center,
                    ['h'] = actions.move_to_bottom + actions.select_default + actions.center,
                }
            }
        }
    },
    extensions = {
        file_browser = {
            -- initial_mode = 'normal',
            on_complete = { function() vim.cmd 'stopinsert' end },
            mappings = {
                n = {
                    ['j'] = actions.move_selection_next,
                    ['k'] = actions.move_selection_previous,
                    ['l'] = actions.select_default + actions.center,
                    ['h'] = actions.move_to_bottom + actions.select_default + actions.center,
                }
            }
        },
    }
}

noremap('n', '<F2>', '<CMD>lua require("telescope").extensions.file_browser.file_browser()<CR>')
noremap('n', '<F3>', '<CMD>Telescope buffers<CR>')