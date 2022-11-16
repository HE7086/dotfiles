local noremap = require('util.keymap').noremap
local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup {
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
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}
telescope.load_extension('fzf')

noremap('n', '<F2>', function()
    require('telescope').extensions.file_browser.file_browser()
end)
noremap('n', '<F3>', function()
    require('telescope.builtin').buffers()
end)
noremap('n', '<space>/', function()
    require('telescope.builtin').live_grep { grep_open_files = true }
end)
