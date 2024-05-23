return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    formatting = {
      format_on_save = {
        enabled = false,
        allow_filetypes = {
          "sh",
        },
        ignore_filetypes = {},
      },
      disabled = {
        "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
    },
    servers = {
      "clangd"
    },
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    handlers = {},
    autocmds = {
      lsp_document_highlight = {
        cond = "textDocument/documentHighlight",
        { event = { "CursorHold", "CursorHoldI" },
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        { event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
      },
    },
    on_attach = function() end,
  },
}
