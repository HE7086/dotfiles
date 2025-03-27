return {
  "AstroNvim/astrocore",
  opts = {
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
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
      g = {
        -- vim.g.<key>
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
      },
      i = {
        ["<F7>"] = false,
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
            if new_showtabline ~= vim.opt.showtabline then
              vim.opt.showtabline = new_showtabline
            end
          end,
        },
      },
      alpha_i = {
        {
          event = "Filetype",
          pattern = "alpha",
          desc = "Open a unnamed buffer",
          callback = function(event)
            vim.keymap.set("n", "i", "<Cmd>enew!<CR>", { buffer = event.buf })
          end,
        },
      },
    },
    commands = {
      W = {
        "w",
        desc = "write",
      },
    },
  },
}
