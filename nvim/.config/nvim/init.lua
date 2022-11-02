local fn = vim.fn -- invoke vim function

local g = vim.g -- global variables

local o = vim.o -- editor option

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

local map = require("util.keymap").map
local noremap = require("util.keymap").noremap
local noremap_all = require("util.keymap").noremap_all

-- encoding
o.fileencodings = "utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1"
g.ambiwidth = "double"

-- numbers
o.number = true
o.relativenumber = true

-- tab and indent
o.expandtab = true
o.smarttab = true
o.autoindent = true
o.smartindent = true
o.shiftround = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

-- search
o.ignorecase = true
o.smartcase = true
o.showmatch = true
o.hlsearch = true
o.incsearch = true

-- command
o.showcmd = true
o.inccommand = "nosplit"
o.wildmenu = true
o.wildignorecase = true

-- scrolling
o.scrolloff = 5
o.sidescroll = 1
o.sidescrolloff = 8

-- editor appearance
o.termguicolors = true
o.showmode = true
o.list = false
o.listchars = "eol:¶,tab:>_,trail:·,extends:¦,precedes:¦,space:·,nbsp:␣"
o.cursorline = true

augroup("AutoCursorline", { clear = true })
autocmd("InsertEnter", {
    group = "AutoCursorline",
    pattern = "*",
    callback = function()
        vim.wo.cursorline = false
    end,
})
autocmd("InsertLeave", {
    group = "AutoCursorline",
    pattern = "*",
    callback = function()
        vim.wo.cursorline = true
    end,
})

-- statusline
o.laststatus = 2
o.showtabline = 1

if vim.fn.has("nvim-0.8") then
    o.cmdheight = 0
else
    o.cmdheight = 1
end

-- syntax highlighting
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- clipboard and yank
o.clipboard = o.clipboard .. "unnamedplus"
augroup("YankHighLight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighLight",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank {
            on_visual = true,
            timeout = 300
        }
    end
})

-- wrapping and folding
o.wrap = false
o.foldenable = false
-- auto wrap in plain-text files + keymaps
augroup("AutoTextWrap", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
    group = "AutoTextWrap",
    pattern = { "*.txt", "*.tex", "*.md" },
    callback = function()
        vim.wo.wrap = true
        vim.wo.linebreak = true
        noremap("n", "j", "gj")
        noremap("n", "k", "gk")
        noremap("n", "gj", "j")
        noremap("n", "gk", "k")
        noremap("n", "L", "g$")
        noremap("n", "H", "g^")
        noremap("v", "j", "gj")
        noremap("v", "k", "gk")
        noremap("v", "gj", "j")
        noremap("v", "gk", "k")
        noremap("v", "L", "g$")
        noremap("v", "H", "g^")
    end
})

-- bells
o.errorbells = false
o.visualbell = false

-- backup and undofiles
o.undofile = false
o.backup = false
o.swapfile = false
o.autoread = true
o.autowrite = true

-- terminal
g.neoterm_autoscroll = 1
augroup("TerminalAutoInsert", { clear = true })
autocmd("TermOpen", {
    group = "TerminalAutoInsert",
    pattern = "term://*",
    command = "startinsert"
})

-- misc
o.hidden = true
o.mouse = "a"
o.lazyredraw = true
o.updatetime = 500
o.completeopt = "menu,menuone,noselect"

-------------------- Default Keymaps --------------------
noremap("n", "<space><CR>", ":nohlsearch<CR>")
noremap("", "H", "^")
noremap("", "L", "$")
noremap("i", "<A-h>", "<left>")
noremap("i", "<A-j>", "<down>")
noremap("i", "<A-k>", "<up>")
noremap("i", "<A-l>", "<right>")

noremap("i", "(<CR>", "(<CR><CR>)<UP><END>")
noremap("i", "[<CR>", "[<CR><CR>]<UP><END>")
noremap("i", "{<CR>", "{<CR><CR>}<UP><END>")

noremap("n", "<C-Tab>", "<CMD>tabnext<CR>")
noremap("n", "<S-C-Tab>", "<CMD>tabprevious<CR>")

-- avoid misinput
-- noremap_all('Q', '<nop>')  -- disable Ex mode entirely
noremap("", "gQ", "<nop>")
noremap_all("<F1>", "<ESC>")
command("W", "w", { nargs = 0 })

-------------------- Hand Crafted Plugins --------------------
require("neovide")
require("status_line")
require("code_runner")
noremap("n", "<F22>", "<CMD>lua require('code_runner').run()<CR>")
noremap("n", "<S-F10>", "<CMD>lua require('code_runner').run()<CR>")

map("n", "Q", "<CMD>lua Close_Floating_Windows()<CR>")
-- close all the floating windows
function Close_Floating_Windows()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative ~= "" then
            vim.api.nvim_win_close(win, false)
        end
    end
end

function ToggleLightMode()
    if vim.o.background == "light" then
        vim.o.background = "dark"
        vim.api.nvim_command("colorscheme onedark")
    else
        vim.o.background = "light"
        vim.api.nvim_command("colorscheme github")
    end
end

command("LM", "lua ToggleLightMode()", { nargs = 0 })
noremap("n", "<F10>",
    [[<CMD>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]])

-------------------- Plugins --------------------

-- auto install packer.nvim
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", "--depth=1", install_path })
    -- run PackerInstall to install plugins
    vim.api.nvim_command("packadd packer.nvim")
    -- first time will generate a lot of errors, just ignore
    require("plugins").compile()
    require("plugins").install()
end

vim.api.nvim_command("packadd packer.nvim") -- enable packer.nvim
augroup("PackerAutoCompile", { clear = true })
autocmd("BufWritePost", {
    group = "PackerAutoCompile",
    pattern = "init.lua",
    command = "source <afile> | PackerCompile"
}) -- auto compile when plugin config updates

require("plugins")

-------------------- Plugins Settings --------------------
command("Format", "format", { nargs = 0 })

-- auto switch to light theme in terminal
-- if os.getenv("COLORFGBG") == "15;0" then
--     vim.cmd("setlocal bg=light")
-- end

-------------------- END OF SETTINGS --------------------
vim.g.hlsearch = false -- does this work?
