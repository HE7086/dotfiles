scriptencoding utf-8
set nocompatible

" Use colours and encoding
set encoding=utf-8
" set termguicolors
" set t_Co=256

" Always show statusline
set laststatus=2
set showtabline=1
"set showmode

" kitty vim adapter
if $TERM == "xterm-kitty"
    let &t_ut=''
endif

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
autocmd BufRead,BufNewFile *.txt,*.md,*.tex setlocal wrap

"------------------------------------------------
" Key bindings
"------------------------------------------------
" better movement for plain text editing while wraping
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap j gj
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap k gk
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
nnoremap <A-1> 0
nnoremap <A-2> ^
nnoremap <A-3> $
" use system clip board accordingly
noremap <A-y> "*y
noremap <A-p> "*p
noremap <A-Y> "+y
noremap <A-P> "+p
" temporarily disable highlighting for searach
nnoremap <space><CR> :nohlsearch<CR>
" toggle line number for copying
nnoremap <F6> :set nu! rnu!<CR>
" toggle wrap
nnoremap <F7> :set wrap!<CR>
" toggle list - show all characters
nnoremap <F8> :set list!<CR>
" Format the hole file and delete space at the end of line
nnoremap <silent> =-= mmgg=G:%s/\s\+$//<CR>'m
" Save without exit
nnoremap ZS :w<CR>
" Abort all changes
nnoremap QQ :edit!<CR>
" open NerdTree
nnoremap <F2> :NERDTreeToggle<CR>
" Commentary toggle, must be recursive
nmap <A-c> gcc
vmap <A-c> gc
" insert the current date and time
inoremap <silent> <insert>date <C-R>=strftime('%c')<CR>

"toggle transparent background, deprecated
" let t:is_transparent = 0
" function! Toggle_transparent()
"     if t:is_transparent == 0
"         hi Normal guibg=NONE ctermbg=NONE
"         let t:is_transparent = 1
"     else
"         set background=dark
"         let t:is_tranparent = 0
"     endif
" endfunction
" nnoremap <F3> : call Toggle_transparent()<CR>


" terminal behaviour
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert

"------------------------------------------------
" vim-plug settings
"------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'rakr/vim-one'
Plug 'junegunn/fzf', { 'dir': '~/.local/fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-startify'
Plug 'Konfekt/vim-CtrlXA'
Plug 'terryma/vim-multiple-cursors'
call plug#end()

"------------------------------------------------
" Plugin settings
"------------------------------------------------
" themes
set background=dark
"colorscheme solarized
let g:airline_theme='solarized'
let g:solarized_termcolors=256
colorscheme one
"let g:airline_theme='one'
let g:one_allow_italics=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:airline_powerline_fonts=1
let g:airline_extensions=['branch']
"let g:airline_section_y='%{strlen(&fenc)?&fenc:&enc}[%{&ff}]'
let g:airline_section_z='%3p%%%4l%3c'
set guifont=Fira\ Code\ Retina

" NERDTree
let NERDTreeMapToggleHidden="zh"
let NERDTreeMapCustomOpen="<space>"
let NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }

" startify
let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   MRU']            },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]
let g:startify_bookmarks = [ {'v': '~/.config/nvim/init.vim'}, {'z': '~/.zshrc'} ]
"let g:startify_commands = [ {'Vim Help Page': 'help'} ]
let g:startify_custom_header = [
            \ "         _   _ _______   _____ _____ ___   ___   __   ",
            \ "        | | | | ____\\ \\ / /_ _|___  / _ \\ ( _ ) / /_  ",
            \ "        | |_| |  _|  \\ V / | |   / / | | |/ _ \\| '_ \\ ",
            \ "        |  _  | |___  | |  | |  / /| |_| | (_) | (_) |",
            \ "        |_| |_|_____| |_| |___|/_/  \\___/ \\___/ \\___/ ",
            \ "                     __     _____ __  __              ",
            \ "                     \\ \\   / /_ _|  \\/  |             ",
            \ "                      \\ \\ / / | || |\\/| |             ",
            \ "                       \\ V /  | || |  | |             ",
            \ "                        \\_/  |___|_|  |_|             "
            \]

" CtrlXA switch list
let g:CtrlXA_Toggles = [
            \ ['&&', '||'],
            \ ['+', '-'], ['++', '--'],
            \ ['==', '!='] , ['=~', '!~'],
            \ ['<=', '>'], ['<', '>='], ['>>', '<<'],
            \ ['true', 'false'], ['True', 'False'], ['TRUE', 'FALSE'],
            \ ['yes', 'no'], ['Yes', 'No'], ['YES', 'NO'],
            \ ['on', 'off'], ['On', 'Off'], ['ON', 'OFF'],
            \ ['up', 'down'], ['Up', 'Down'] ,['UP', 'DOWN'],
            \ ['enable', 'disable'], ['Enable', 'Disable'],
            \ ['enabled', 'disabled'], ['Enabled', 'Disabled'],
            \ ['upper', 'lower'], ['Upper', 'Lower'],
            \ ['top', 'bottom'], ['Top', 'Bottom'],
            \ ['above', 'below'], ['Above', 'Below'],
            \ ['forward', 'backward'], ['Forward', 'Backward'],
            \ ['right', 'left'], ['Right', 'Left'],
            \ ['next', 'previous'], ['Next', 'Previous'],
            \ ['first', 'last'], ['First', 'Last'],
            \ ['before', 'after'], ['Before', 'After'],
            \ ['more', 'less'], ['More', 'Less'],
            \ ['fast', 'slow'], ['Fast', 'Slow'],
            \ ['light', 'dark'] , ['Light', 'Dark'] ,
            \ ['good', 'bad'], ['Good', 'Bad'],
            \ ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'],
            \ ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'],
            \ ]
