return {
  { "tpope/vim-fugitive" },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  { "HE7086/sudoedit.nvim" },
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },
  {
    "echasnovski/mini.pairs",
    opts = {
      skip_unbalanced = false,
    },
  },
  -- disabled plugins
  { "echasnovski/mini.animate", enabled = false },
  { "folke/flash.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      indent = { animate = { enabled = false } },
    },
  },

  -- https://github.com/LazyVim/LazyVim/issues/6039
  -- { "mason-org/mason.nvim", version = "1.11.0" },
  -- { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
}
