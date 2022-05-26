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
        ["<CR>"] = cmp.mapping.confirm({ select = true}),
    },

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
    }, {
        { name = "buffer" },
    }),
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

cmp.setup.cmdline("/", {
    completion = { autocomplete = false },
    sources = {
        { name = "buffer",
            -- options = { keyword_pattern = [=[[^[:blank:]].*]=] }
        }
    },
})

cmp.setup.cmdline(":", {
    completion = { autocomplete = false },
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

cmp.setup({
    view = {
        entries = "native",
    },
    experimental = {
        ghost_text = true,
    },
})

vim.cmd([[
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
