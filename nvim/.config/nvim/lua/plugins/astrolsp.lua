return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      autoformat = true,
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
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
      timeout_ms = 1000,
    },
    servers = {
      -- "clangd"
      "rust_analyzer",
    },
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    handlers = {},
    autocmds = {
      lsp_document_highlight = {
        cond = "textDocument/documentHighlight",
        {
          event = { "CursorHold", "CursorHoldI" },
          desc = "Document Highlighting",
          callback = function()
            vim.lsp.buf.document_highlight()
          end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function()
            vim.lsp.buf.clear_references()
          end,
        },
      },
    },
    mappings = {
      n = {
        gl = {
          function()
            vim.diagnostic.open_float()
          end,
          desc = "Hover diagnostics",
        },
        ["<F18>"] = {
          function()
            vim.lsp.buf.rename()
          end,
          desc = "Rename",
        },
        ["<A-CR>"] = {
          function()
            vim.lsp.buf.code_action()
          end,
          desc = "Code actions",
        },
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
    on_attach = function() end,
  },
}
