local noremap = require('util.keymap').noremap
noremap('n', '<space>/', ':LeaderfLine<CR>')
noremap('n', '<space>f', ':LeaderfFile<CR>')
noremap('n', '<space>b', ':LeaderfBuffer<CR>')

local g = vim.g

g.Lf_WindowPosition = 'popup'
g.Lf_PreviewInPopup = 1
g.Lf_StlSeparator = {
    left = '',
    right = '',
}

g.Lf_FollowLinks = 1
