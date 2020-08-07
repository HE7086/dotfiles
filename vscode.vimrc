scriptencoding utf-8
set nocompatible

" auto install for first time
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Use colours and encoding
set encoding=utf-8
" set termguicolors
" set t_Co=256

" Always show statusline
set laststatus=2
set showtabline=1
set showmode

" use vim packages in ~/.vim
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath

set autoread
set autowrite
" colors and syntax
syntax enable
syntax on
filetype on
filetype plugin on

"set cursorline cursorcolumn

" scrolling settings
set nofoldenable
set sidescroll=1
set sidescrolloff=8
set scrolloff=5
" tab and indent settings
filetype indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab
set autoindent
set smartindent

" no bells
set noerrorbells
set novisualbell

set number
set relativenumber
set showcmd
" set mouse=a

" searching settings
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
" auto completion menu
set wildmenu
set wildignorecase

set lazyredraw

set nolist
set listchars=eol:¶,tab:>_,trail:·,extends:¦,precedes:¦,space:·,nbsp:␣

" word wrap only for text files
set nowrap
" autocmd BufRead,BufNewFile *.txt,*.md,*.tex setlocal wrap

"------------------------------------------------
" Key bindings
"------------------------------------------------
" better movement for plain text editing while wraping
" autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap j gj
" autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap k gk
" autocmd BufRead,BufNewFile *.md,*.markdown inoremap ``` ```<CR>```<up>
" normal/visual mod: Alt + hjkl -> move/indent line
nnoremap <A-h> <<
nnoremap <A-l> >>
vnoremap <A-h> <gv
vnoremap <A-l> >gv
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv
" insert/command mod: Alt + hjkl -> move cursor
noremap! <A-h> <left>
noremap! <A-j> <down>
noremap! <A-k> <up>
noremap! <A-l> <right>
" Alt + 0/1/2 -> line begin/start of text/end
noremap <A-1> 0
noremap <A-2> ^
noremap <A-3> $
" use system clip board accordingly
set clipboard+=unnamedplus
" noremap <A-y> "*y
" noremap <A-p> "*p
" noremap <A-Y> "+y
" noremap <A-P> "+p

" temporarily disable highlighting for searach
nnoremap <silent> <space><CR> :nohlsearch<CR>
" toggle line number for copying
" nnoremap <F6> :set nu! rnu!<CR>
" toggle wrap
" nnoremap <F7> :set wrap!<CR>
" toggle list - show all characters
" nnoremap <F8> :set list!<CR>
" Format the hole file and delete space at the end of line
" nnoremap <silent> =-= mmgg=G'm
" nnoremap <silent> =--= mmgg=G:%s/\s\+$//<CR>'m
" Save without exit
nnoremap ZS :w<CR>
" Abort all changes
nnoremap QQ :edit!<CR>
" open NerdTree
" nnoremap <F2> :NERDTreeToggle<CR>
" Commentary toggle, must be recursive
nmap <A-c> gccj
vmap <A-c> gc
" insert the current date and time
inoremap <silent> <insert>date <C-R>=strftime('%c')<CR>
autocmd TermOpen term://* startinsert

"------------------------------------------------
" vim-plug settings
"------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
" Editor Functionality
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'terryma/vim-multiple-cursors'
Plug 'Konfekt/vim-CtrlXA'
Plug 'junegunn/vim-peekaboo'
call plug#end()
