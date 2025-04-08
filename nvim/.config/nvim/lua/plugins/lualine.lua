return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local icons = LazyVim.config.icons
    local sudoedit = require("sudoedit")
    opts.options.component_separators = { left = "|", right = "|" }
    opts.options.section_separators = { left = "", right = "" }
    opts.sections.lualine_b = {
      { "branch" },
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
    }
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
    opts.sections.lualine_x = {
      Snacks.profiler.status(),
      -- stylua: ignore
      {
        function() return require("noice").api.status.command.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        color = function() return { fg = Snacks.util.color("Statement") } end,
      },
      -- stylua: ignore
      {
        function() return require("noice").api.status.mode.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        color = function() return { fg = Snacks.util.color("Constant") } end,
      },
      -- stylua: ignore
      {
        function() return "  " .. require("dap").status() end,
        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
        color = function() return { fg = Snacks.util.color("Debug") } end,
      },
      -- stylua: ignore
      {
        require("lazy.status").updates,
        cond = require("lazy.status").has_updates,
        color = function() return { fg = Snacks.util.color("Special") } end,
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
