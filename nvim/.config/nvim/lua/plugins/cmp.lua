local cmp = require("cmp")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },

    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),

        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
    }, {
        { name = "buffer" },
    }),

    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -1,
            side_padding = 1,
        },
    },

    formatting = {
        fields = { "abbr", "kind" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
                preset = "codicons",
                symbol_map = {
                    Snippet = "\u{EAC4}"
                },
                mode = "symbol_text",
                maxwidth = 50
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = strings[1] .. "  " .. strings[2]

            return kind
        end,
    },
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { {
        name = "buffer",
    } },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

cmp.setup({
    view = {
        entries = "custom", -- "native"
    },
    experimental = {
        ghost_text = true,
    },
})

local hi = vim.api.nvim_set_hl

hi(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
hi(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

hi(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
hi(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

hi(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
hi(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })

hi(0, "CmpItemKindField", { fg = "#B5585F", bg = "NONE" })
hi(0, "CmpItemKindProperty", { link = "CmpItemKindField" })
hi(0, "CmpItemKindEvent", { link = "CmpItemKindField" })

hi(0, "CmpItemKindText", { fg = "#9FBD73", bg = "NONE" })
hi(0, "CmpItemKindEnum", { link = "CmpItemKindText" })
hi(0, "CmpItemKindKeyword", { link = "CmpItemKindText" })

hi(0, "CmpItemKindConstant", { fg = "#D4BB6C", bg = "NONE" })
hi(0, "CmpItemKindConstructor", { link = "CmpItemKindConstant" })
hi(0, "CmpItemKindReference", { link = "CmpItemKindConstant" })

hi(0, "CmpItemKindFunction", { fg = "#A377BF", bg = "NONE" })
hi(0, "CmpItemKindStruct", { link = "CmpItemKindFunction" })
hi(0, "CmpItemKindClass", { link = "CmpItemKindFunction" })
hi(0, "CmpItemKindModule", { link = "CmpItemKindFunction" })
hi(0, "CmpItemKindOperator", { link = "CmpItemKindFunction" })

hi(0, "CmpItemKindVariable", { fg = "#7E8294", bg = "NONE" })
hi(0, "CmpItemKindFile", { link = "CmpItemKindVariable" })

hi(0, "CmpItemKindUnit", { fg = "#D4A959", bg = "NONE" })
hi(0, "CmpItemKindSnippet", { link = "CmpItemKindUnit" })
hi(0, "CmpItemKindFolder", { link = "CmpItemKindUnit" })

hi(0, "CmpItemKindMethod", { fg = "#6C8ED4", bg = "NONE" })
hi(0, "CmpItemKindValue", { link = "CmpItemKindMethod" })
hi(0, "CmpItemKindEnumMember", { link = "CmpItemKindMethod" })

hi(0, "CmpItemKindInterface", { fg = "#58B5A8", bg = "NONE" })
hi(0, "CmpItemKindColor", { link = "CmpItemKindInterface" })
hi(0, "CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
