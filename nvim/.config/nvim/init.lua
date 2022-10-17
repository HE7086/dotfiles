local fn = vim.fn -- invoke vim function

local g = vim.g -- global variables

local o = vim.o -- editor option

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
vim.cmd([[
augroup AutoCursorline
autocmd!
autocmd InsertEnter * setlocal nocursorline
autocmd InsertLeave * setlocal cursorline
augroup END
]])

-- statusline
o.laststatus = 2
o.showtabline = 1
o.cmdheight = 0 -- nvim 0.8

-- syntax highlighting
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- clipboard and yank
o.clipboard = o.clipboard .. "unnamedplus"
vim.cmd([[
augroup YankHighLight
autocmd!
autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = true, timeout=300}
augroup END
]])

-- wrapping and folding
o.wrap = false
o.foldenable = false
-- auto wrap in plain-text files + keymaps
vim.cmd([[
augroup AutoTextWrap
autocmd!
autocmd BufRead,BufNewFile *.txt,*.md,*.tex setlocal wrap
autocmd BufRead,BufNewFile *.txt,*.md,*.tex setlocal linebreak
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap j gj
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap k gk
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap gj j
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap gk k
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap L g$
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap H g^
autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap j gj
autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap k gk
autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap gj j
autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap gk k
autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap L g$
autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap H g^
autocmd BufRead,BufNewFile *.tex setlocal ft=tex
augroup END
]])

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
vim.cmd([[
augroup TerminalAutoInsert
autocmd!
autocmd TermOpen term://* startinsert
augroup END
]])

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
vim.cmd(":command! -nargs=0 W w")

-------------------- Hand Crafted Plugins --------------------
require("neovide")
require("status_line")
require("code_runner")
noremap("n", "<F22>", "<CMD>lua require('code_runner').run()<CR>")
noremap("n", "<S-F10>", "<CMD>lua require('code_runner').run()<CR>")

map("n", "Q", "<CMD>lua Close_Floating_Windows()<CR>")
-- close all the floating windows
Close_Floating_Windows = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative ~= "" then
            vim.api.nvim_win_close(win, false)
        end
    end
end

function ToggleLightMode()
    if vim.o.background == "light" then
        vim.o.background = "dark"
        vim.cmd("color one")
    else
        vim.o.background = "light"
        vim.cmd("color github")
    end
end

vim.cmd(":command! -nargs=0 LM lua ToggleLightMode()")
noremap("n", "<F10>", [[<CMD>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]])

-------------------- Plugins --------------------

-- auto install packer.nvim
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", "--depth=1", install_path })
    -- run PackerInstall to install plugins
    vim.cmd("packadd packer.nvim")
    -- first time will generate a lot of errors, just ignore
    require("plugins").compile()
    require("plugins").install()
end

vim.cmd("packadd packer.nvim") -- enable packer.nvim
vim.cmd([[ 
augroup PackerAutoCompile
autocmd!
autocmd BufWritePost plugin.lua source <afile> | PackerCompile
augroup END
]]) -- auto compile when plugin config updates

require("plugins")

-------------------- Plugins Settings --------------------
vim.cmd(":command! -nargs=0 Format format")

-- auto switch to light theme in terminal
-- if os.getenv("COLORFGBG") == "15;0" then
--     vim.cmd("setlocal bg=light")
-- end

-------------------- END OF SETTINGS --------------------
vim.cmd("nohlsearch")
