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

  {
    "goolord/alpha-nvim",
    opts = require("alpha.themes.startify").config,
    config = false,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require("astronvim.plugins.configs.nvim-autopairs")(plugin, opts)
    end,
  },

  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },

  {
    "mrded/nvim-lsp-notify",
    opts = {
      notify = require("notify"),
    },
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
    "max397574/better-escape.nvim",
    enabled = false,
  },
}
