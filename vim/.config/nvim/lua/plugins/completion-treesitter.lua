vim.g.completion_chain_complete_list = {
    default = {
        default = {
            { complete_items = { 'lsp', 'ts', 'snippet' }},
            { mode = 'file' }
        }
    }
}
