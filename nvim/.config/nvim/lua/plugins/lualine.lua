return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local icons = LazyVim.config.icons
    local sudoedit = require("sudoedit")
    opts.options.component_separators = { left = "|", right = "|" }
    opts.options.section_separators = { left = "", right = "" }
    opts.sections.lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      LazyVim.lualine.root_dir(),
      {
        LazyVim.lualine.pretty_path(),
        separator = { left = "", right = "" },
        padding = { left = 1, right = 0 },
        cond = function()
          return not sudoedit.detected(vim.api.nvim_get_current_buf())
        end,
      },
      {
        function()
          return sudoedit.get_filename()
        end,
        separator = { left = "", right = "" },
        padding = { left = 1, right = 0 },
        cond = function()
          return sudoedit.detected(vim.api.nvim_get_current_buf())
        end,
      },
      {
        "'✏️'", -- TODO: find better icon
        color = { fg = "orange" },
        separator = { left = "", right = "" },
        padding = 0,
        cond = function()
          return vim.bo.modified
        end,
      },
      {
        "'[R]'",
        color = { fg = "red" },
        padding = 0,
        cond = function()
          return vim.uv.getuid() == 0
        end,
      },
      {
        "'[S]'",
        color = { fg = "red" },
        padding = 0,
        cond = function()
          return sudoedit.detected(vim.api.nvim_get_current_buf())
        end,
      },
    }
    opts.sections.lualine_y = {
      {
        "filetype",
        separator = { left = "", right = "" },
        padding = { left = 1, right = 1 },
        on_click = function()
          vim.schedule(vim.cmd.LspInfo)
        end,
      },
      {
        "fileformat",
        cond = function()
          return vim.o.fileformat ~= "unix"
        end,
        separator = { left = "", right = "" },
        padding = { left = 1, right = 1 },
      },
      {
        "encoding",
        cond = function()
          return vim.o.encoding ~= "utf-8"
        end,
        separator = { left = "", right = "" },
        padding = { left = 1, right = 1 },
      },
    }
    opts.sections.lualine_z = { { "location", padding = { left = 1, right = 1 } } }
  end,
}
