return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      -- nil_ls = {},

      -- nix profile install nixpkgs#nixd
      nixd = {},
    },
  },
}
