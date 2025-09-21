return {
  { "tpope/vim-fugitive" },
  { "HE7086/sudoedit.nvim" },
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },
  {
    "nvim-mini/mini.pairs",
    opts = {
      skip_unbalanced = false,
    },
  },
  {
    "nvim-mini/mini.surround",
    version = "*",
    opts = {
      mappings = {
        add = "ys", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding

        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },

  -- {
  --   "kylechui/nvim-surround",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
}
