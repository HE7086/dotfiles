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
}
