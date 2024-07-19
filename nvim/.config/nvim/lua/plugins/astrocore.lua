return {
  "AstroNvim/astrocore",
  opts = {
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "auto",
        wrap = false,

        scrolloff = 5,
        sidescrolloff = 8,
        showtabline = 1,
      },
      g = { -- vim.g.<key>
      },
    },
    mappings = {
      n = {
        L = {
          function()
            require("astrocore.buffer").nav(vim.v.count1)
          end,
          desc = "Next buffer",
        },
        H = {
          function()
            require("astrocore.buffer").nav(-vim.v.count1)
          end,
          desc = "Previous buffer",
        },

        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              require("astrocore.buffer").close(bufnr)
            end)
          end,
          desc = "Pick to close",
        },
        ["<Leader>b"] = { desc = "Buffers" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
    autocmds = {
      autohidetabline = {
        {
          event = "User",
          pattern = "AstroBufsUpdated",
          desc = "Hide tabline when only one buffer and one tab",
          group = "autohidetabline",
          callback = function()
            local new_showtabline = #vim.t.bufs > 1 and 2 or 1
            if new_showtabline ~= vim.opt.showtabline:get() then
              vim.opt.showtabline = new_showtabline
            end
          end,
        },
      },
    },
  },
}
