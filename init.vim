syntax on

set expandtab
set hlsearch
set hidden
set ignorecase
set incsearch
set noerrorbells
set nobackup
set noswapfile
set nowrap
set nu relativenumber
set scrolloff=8
set shiftwidth=4
set smartcase
set smartindent
set tabstop=4 softtabstop=4
set undodir=~/.vim/undodir
set undofile

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}

Plug 'joshdick/onedark.vim'
Plug 'sainnhe/gruvbox-material'

call plug#end()

if (has('termguicolors'))
  set termguicolors
endif

colorscheme onedark 
hi Normal ctermbg=16 guibg=#000000

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

" Map Y to act like yank until EOL, rather than act as yy,
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting search
nnoremap <C-L> :nohl<CR><C-L>
