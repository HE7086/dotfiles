return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")
    local condition = require("astroui.status.condition")
    local hl = require("astroui.status.hl")
    local sudoedit = require("sudoedit")

    local lsp_icon = { -- lsp info icon
      provider = status.provider.str({
        str = require("astroui").get_icon("ActiveLSP", 1),
      }),
      hl = hl.get_attributes("lsp"),
      surround = {
        separator = "right",
        color = "lsp_bg",
        condition = condition.lsp_attached,
      },
      on_click = {
        name = "heirline_lsp",
        callback = function()
          vim.schedule(vim.cmd.LspInfo)
        end,
      },
      condition = condition.lsp_attached,
    }

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode({
        mode_text = { padding = { left = 1, right = 1 } },
      }),
      status.component.git_branch(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.cmd_info(),

      status.component.fill(),

      { provider = "%<" },

      { -- filename
        provider = function(self)
          return sudoedit.get_filename(self.bufnr)
        end,
      },

      -- modified
      { provider = "%m" },

      -- read only
      { provider = "%r", hl = { fg = "red" } },

      {
        fallthrough = false,
        { -- sudoedit
          provider = "[sudo]",
          hl = { fg = "red" },
          condition = function(self)
            return sudoedit.detected(self.bufnr)
          end,
        },
        { -- root user
          provider = "[root]",
          hl = { fg = "red" },
          condition = function()
            return vim.uv.getuid() == 0
          end,
        },
      },
      status.component.fill(),

      status.component.file_info({
        file_modified = false,
        file_read_only = false,
      }),
      lsp_icon,
      status.component.virtual_env(),
      status.component.treesitter({
        str = { str = " ", icon = { kind = "ActiveTS" }, padding = false },
      }),
      status.component.nav({
        percentage = false,
        scrollbar = false,
        padding = { right = 1 },
      }),
    }

    opts.winbar = false
    -- opts.winbar = { -- winbar
    --   init = function(self)
    --     self.bufnr = vim.api.nvim_get_current_buf()
    --   end,
    --   condition = function(self)
    --     return status.condition.is_active() and status.condition.lsp_attached(self.bufnr)
    --   end,
    --   status.component.breadcrumbs({ hl = status.hl.get_attributes("winbar", true) }),
    -- }

    opts.tabline = {
      {
        condition = function(self)
          self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
          self.winwidth = vim.api.nvim_win_get_width(self.winid)
          return self.winwidth ~= vim.o.columns
            and not require("astrocore.buffer").is_valid(vim.api.nvim_win_get_buf(self.winid))
        end,
        provider = function(self)
          return (" "):rep(self.winwidth + 1)
        end,
        hl = { bg = "tabline_bg" },
      },
      status.heirline.make_buflist(status.component.tabline_file_info()),
      status.component.fill({ hl = { bg = "tabline_bg" } }),
      {
        condition = function()
          return #vim.api.nvim_list_tabpages() >= 2
        end, -- only show tabs if there are more than one
        status.heirline.make_tablist({
          provider = status.provider.tabnr(),
          hl = function(self)
            return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true)
          end,
        }),
        {
          provider = status.provider.close_button({
            kind = "TabClose",
            padding = { left = 1, right = 1 },
          }),
          hl = status.hl.get_attributes("tab_close", true),
          on_click = {
            callback = function()
              require("astrocore.buffer").close_tab()
            end,
            name = "heirline_tabline_close_tab_callback",
          },
        },
      },
    }

    opts.statuscolumn = {
      init = function(self)
        self.bufnr = vim.api.nvim_get_current_buf()
      end,
      status.component.foldcolumn(),
      status.component.numbercolumn(),
      status.component.signcolumn(),
    }
    opts.opts = {
      colors = require("astroui").config.status.setup_colors(),
    }
  end,
}
