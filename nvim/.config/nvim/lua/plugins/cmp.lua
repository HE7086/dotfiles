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

    -- window = {
    --     completion = {
    --         winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
    --         col_offset = -3,
    --         side_padding = 0,
    --     },
    -- },

    -- formatting = {
    --     fields = { "kind", "abbr", "menu" },
    --     format = function(entry, vim_item)
    --         local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
    --         local strings = vim.split(kind.kind, "%s", { trimempty = true })
    --         kind.kind = " " .. strings[1] .. " "
    --         kind.menu = "    (" .. strings[2] .. ")"

    --         return kind
    --     end,
    -- },
})
-- local t = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- cmp.setup({
--     snippet = {
--         expand = function(args)
--             vim.fn["UltiSnips#Anon"](args.body)
--         end,
--     },
--     mapping = {
--         ["<Tab>"] = cmp.mapping({
--             c = function(fallback)
--             	if cmp.visible() then
--             		cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
--             	else
--             		-- cmp.complete()
--             		fallback()
--             	end
--             end,
--             i = function(fallback)
--                 if cmp.visible() then
--                     cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
--                 elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
--                     vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
--                 else
--                     fallback()
--                 end
--             end,
--             s = function(fallback)
--                 if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
--                     vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
--                 else
--                     fallback()
--                 end
--             end,
--         }),
--         ["<S-Tab>"] = cmp.mapping({
--             c = function()
--                 if cmp.visible() then
--                     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
--                 else
--                     cmp.complete()
--                 end
--             end,
--             i = function(fallback)
--                 if cmp.visible() then
--                     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
--                 elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
--                     return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
--                 else
--                     fallback()
--                 end
--             end,
--             s = function(fallback)
--                 if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
--                     return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
--                 else
--                     fallback()
--                 end
--             end,
--         }),
--         ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
--         ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
--         ["<C-n>"] = cmp.mapping({
--             c = function()
--                 if cmp.visible() then
--                     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
--                 else
--                     vim.api.nvim_feedkeys(t("<Down>"), "n", true)
--                 end
--             end,
--             i = function(fallback)
--                 if cmp.visible() then
--                     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
--                 else
--                     fallback()
--                 end
--             end,
--         }),
--         ["<C-p>"] = cmp.mapping({
--             c = function()
--                 if cmp.visible() then
--                     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
--                 else
--                     vim.api.nvim_feedkeys(t("<Up>"), "n", true)
--                 end
--             end,
--             i = function(fallback)
--                 if cmp.visible() then
--                     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
--                 else
--                     fallback()
--                 end
--             end,
--         }),
--         ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--         ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
--         ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
--         ["<CR>"] = cmp.mapping({
--             i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
--             c = function(fallback)
--                 if cmp.visible() then
--                     cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
--                 else
--                     fallback()
--                 end
--             end,
--         }),
--     },
--     sources = cmp.config.sources({
--         { name = "nvim_lsp" },
--         { name = "ultisnips" },
--     }, {
--         { name = "buffer" },
--     }),
-- })

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
hi(0, "CmpItemAbbrDeprecated", { fg = "#808080", bg = "NONE", strikethrough = true })
hi(0, "CmpItemAbbrMatch", { fg = "#569CD6", bg = "NONE" })
hi(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
hi(0, "CmpItemKindVariable", { fg = "#9CDCFE", bg = "NONE" })
hi(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
hi(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
hi(0, "CmpItemKindFunction", { fg = "#C586C0", bg = "NONE" })
hi(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
hi(0, "CmpItemKindKeyword", { fg = "#D4D4D4", bg = "NONE" })
hi(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
hi(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

-- hi(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
-- hi(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

-- hi(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
-- hi(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
-- hi(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
-- hi(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

-- hi(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
-- hi(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
-- hi(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

-- hi(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
-- hi(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
-- hi(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

-- hi(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
-- hi(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
-- hi(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

-- hi(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
-- hi(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
-- hi(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
-- hi(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
-- hi(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

-- hi(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
-- hi(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

-- hi(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
-- hi(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
-- hi(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

-- hi(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
-- hi(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
-- hi(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

-- hi(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
-- hi(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
-- hi(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })

-- vim.cmd([[
-- " gray
-- highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
-- " blue
-- highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
-- highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
-- " light blue
-- highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
-- highlight! link CmpItemKindInterface CmpItemKindVariable
-- highlight! link CmpItemKindText CmpItemKindVariable
-- " pink
-- highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
-- highlight! link CmpItemKindMethod CmpItemKindFunction
-- " front
-- highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
-- highlight! link CmpItemKindProperty CmpItemKindKeyword
-- highlight! link CmpItemKindUnit CmpItemKindKeyword
-- ]])

