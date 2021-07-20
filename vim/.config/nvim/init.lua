local cmd = vim.cmd -- execute vim script
local fn = vim.fn   -- invoke vim function

local g = vim.g     -- global variables

local o = vim.o     -- editor option
local wo = vim.wo   -- window option
local bo = vim.bo   -- buffer option

local noremap = require('util.keymap').noremap
local noremap_all = require('util.keymap').noremap_all
local execute = vim.api.nvim_command

-- auto install packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', '--depth=1', install_path})
  execute 'packadd packer.nvim'
  -- run PackerInstall to install plugins
end
cmd [[packadd packer.nvim]] -- enable packer.nvim
cmd 'autocmd BufWritePost plugin.lua source <afile> | PackerCompile' -- auto compile when plugin config updates

-- encoding
o.fileencodings = 'utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1'

-- numbers
wo.number = true
wo.relativenumber = true

-- tab and indent
bo.expandtab = true
o.smarttab = true
bo.autoindent = true
bo.smartindent = true
o.shiftround = true
bo.shiftwidth = 4
bo.tabstop = 4
bo.softtabstop = 4

-- search
o.ignorecase = true
o.smartcase = true
o.showmatch = true
o.hlsearch = true
o.incsearch = true

-- command
o.showcmd = true
o.inccommand = 'nosplit'
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
o.listchars = 'eol:¶,tab:>_,trail:·,extends:¦,precedes:¦,space:·,nbsp:␣'
o.cursorline = true
execute([[
augroup AutoCursorline
    autocmd InsertEnter * setlocal nocursorline
    autocmd InsertLeave * setlocal cursorline
augroup END
]])

-- statusline
o.laststatus = 2
o.showtabline = 1

-- syntax highlighting
cmd 'syntax enable'
cmd 'filetype plugin indent on'

-- clipboard and yank
o.clipboard = 'unnamedplus'
cmd 'autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- wrapping and folding
o.wrap = false
o.foldenable = false
-- auto wrap in plain-text files + keymaps
execute([[
augroup AutoTextWrap
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex setlocal wrap
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex setlocal linebreak
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap j gj
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap k gk
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap L g$
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap H g^
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap j gj
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap k gk
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap L g$
    autocmd BufRead,BufNewFile *.txt,*.md,*.tex vnoremap H g^
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
cmd 'autocmd TermOpen term://* startinsert'

-- misc
o.hidden = true
o.mouse = 'a'
o.lazyredraw = true
o.updatetime = 500

-------------------- Default Keymaps --------------------
noremap('n', '<space><CR>', ':nohlsearch<CR>')
noremap('', 'H', '^')
noremap('', 'L', '$')

noremap('i', '(<CR>', '(<CR><CR>)<UP><END>')
noremap('i', '[<CR>', '[<CR><CR>]<UP><END>')
noremap('i', '{<CR>', '{<CR><CR>}<UP><END>')

-- avoid misinput
noremap_all('Q', '<nop>')  -- disable Ex mode entirely
noremap_all('gQ', '<nop>')
noremap_all('<F1>', '<ESC>')
cmd ':command! -nargs=0 W w'

-- run code in terminal
execute([[
augroup AutoRunCode
    autocmd BufRead,BufNewFile *.sh nnoremap <F22> :w<CR>:term zsh %<CR>
    autocmd BufRead,BufNewFile *.hs nnoremap <F22> :w<CR>:term ghci %<CR>
    autocmd BufRead,BufNewFile *.c nnoremap <F22> :w<CR>:term clang % -o test.out && ./test.out<CR>
    autocmd BufRead,BufNewFile *.cpp nnoremap <F22> :w<CR>:term clang++ -std=c++2a % -o test.out && ./test.out<CR>
    autocmd BufRead,BufNewFile *.py nnoremap <F22> :w<CR>:term python %<CR>
    autocmd BufRead,BufNewFile *.cprf nnoremap <F22> :w<CR>:term cyp <C-R>=expand('%:r')<CR>.cthy % <CR>
augroup END
]])

-------------------- Hand Crafted Plugins --------------------
require('status_line')

-------------------- Plugins --------------------
require('plugin')

-------------------- Plugins Settings --------------------
cmd 'colorscheme one' -- colorscheme

-------------------- END OF SETTINGS --------------------
execute('nohlsearch')
