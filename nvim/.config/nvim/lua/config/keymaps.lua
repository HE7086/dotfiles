local map = LazyVim.safe_keymap_set

-- map({ "n" }, "<Leader>o", function()
--   if vim.bo.filetype == "snacks_picker_list" then
--     vim.cmd.wincmd("p")
--   else
--     Snacks.explorer()
--   end
-- end, { desc = "focus explorer", expr = true, silent = true })

vim.api.nvim_create_user_command("W", "w", {})
map({ "n" }, "ZZ", "<CMD>wqa<CR>")
