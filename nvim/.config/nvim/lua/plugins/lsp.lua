return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      -- nil_ls = {},

      -- nix profile install nixpkgs#nixd
      nixd = {},
      clangd = {
        on_new_config = function(new_config, root_dir)
          local build_dir = root_dir .. "/build"
          local cmake_file = root_dir .. "/CMakeLists.txt"
          if vim.fn.isdirectory(build_dir) == 1 and vim.fn.filereadable(cmake_file) then
            new_config.cmd = { "clangd", "--experimental-modules-support" }
          else
            new_config.cmd = { "clangd" }
          end
        end,
      },
    },
  },
}
