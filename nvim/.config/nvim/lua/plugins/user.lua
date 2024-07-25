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
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
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

  {
    "max397574/better-escape.nvim",
    enabled = false,
  },
}
