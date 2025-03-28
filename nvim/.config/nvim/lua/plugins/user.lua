return {
  { "tpope/vim-fugitive" },
  -- { "navarasu/onedark.nvim" },
  -- { "olimorris/onedarkpro.nvim" },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    opts = {},
  },

  -- {
  --   "goolord/alpha-nvim",
  --   opts = require("alpha.themes.startify").config,
  --   config = false,
  -- },
  {
    "folke/snacks.nvim",
    opts = {
      image = { enabled = false },
      dashboard = {
        autokeys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
        preset = {
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "s", desc = "Restore Session", action = "session" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        sections = {
          { section = "header" },
          { icon = " ", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", limit = 10, section = "recent_files", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },

  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },

  { "HE7086/sudoedit.nvim" },

  -- {
  --   "OXY2DEV/markview.nvim",
  --   ft = "markdown",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },

  -- { -- not maintained anymore?
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function()
  --     require("lazy").load({ plugins = { "markdown-preview.nvim" } })
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },

  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      opts.direction = "float"
    end,
  },

  {
    "max397574/better-escape.nvim",
    enabled = false,
  },
}
