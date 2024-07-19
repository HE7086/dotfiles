return {
  { "tpope/vim-fugitive" },
  -- { "navarasu/onedark.nvim" },
  -- { "olimorris/onedarkpro.nvim" },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup()
    end,
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
    "max397574/better-escape.nvim",
    enabled = false,
  },

  {
    "HE7086/code-runner.nvim",
    cmd = "CodeRunnerRun",
    dependencies = {
      "akinsho/toggleterm.nvim",
    },
    opts = {},
    keys = {
      { "<F22>", "<Cmd>CodeRunnerRun<Cr>", desc = "Run Code" },
    },
  },
}
