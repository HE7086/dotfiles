return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "bash",
      "csv",
      "diff",
      "html",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "toml",
      "vim",
      "xml",
      "yaml",

      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
    })
  end,
}
