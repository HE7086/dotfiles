vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("LU", function()
  require("astrocore").update_packages()
  vim.api.nvim_command("TSUpdate")
end, {})
