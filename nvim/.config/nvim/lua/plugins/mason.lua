return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- language servers
        "lua-language-server",
        -- formatters
        "stylua",
        "prettier"
        -- debuggers
        -- "debugpy",
      },
    },
  },
}
