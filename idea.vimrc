set laststatus=2

set smartindent
set autoindent

set novisualbell

set number
set relativenumber
" search options
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

set showcmd
set showmode
set mouse=a

set scrolloff=5
set sidescrolloff=1

set clipboard=unnamed

set surround
set multiple-cursors
set commentary

noremap <F6> :set nu! rnu!<CR>
nnoremap <right> >>
nnoremap <left> <<
vnoremap <right> >gv
vnoremap <left> <gv

inoremap <A-h> <left>    
inoremap <A-j> <down>    
inoremap <A-k> <up>    
inoremap <A-l> <right> 

nnoremap == :action ReformatCode<CR>
nnoremap <up> :action MoveLineUp<CR>
nnoremap <down> :action MoveLineDown<CR>

nmap <A-c> gcc
vmap <A-c> gc

nnoremap <space><CR> :nohlsearch<CR>
nnoremap \\r <ESC>:source ~/.ideavimrc<CR>
