require('gitsigns').setup{
    numhl = false,
    linehl = false,
    current_line_blame = false,
    watch_index = {
        interval = 2000,
        follow_files = true
    },
    update_debounce = 500,
    word_diff = false,
    use_internal_diff = true,
}
