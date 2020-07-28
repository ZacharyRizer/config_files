" -----------------------------------------------------------------------------
" -------------------------- General Settings ---------------------------------
" -----------------------------------------------------------------------------
  

syntax enable                           " Enables syntax highlighing
set noerrorbells                        " Stop those annoying bells
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set cmdheight=2                         " More space for displaying messages
set mouse=a                             " Enable your mouse
set splitbelow splitright               " Splits will automatically be below and to the right
set tabstop=4 softtabstop=4             " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set number relativenumber               " Line numbers
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs 
set nobackup nowritebackup noswapfile   " This is recommended by coc
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set updatetime=100                      " Faster completion
set timeoutlen=100                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else
set incsearch smartcase hlsearch        " more intelligent search

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


" -----------------------------------------------------------------------------
" ------------------------------ Plug-Ins -------------------------------------
" -----------------------------------------------------------------------------


call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'

call plug#end()


" -----------------------------------------------------------------------------
" -------------------------- Basic Key Mappings -------------------------------
" -----------------------------------------------------------------------------


" set leader key
let g:mapleader = " "

" Shift-y like D and C <==> C-L to clear hlsearch <==> C-c for ESC
map Y y$
nnoremap <C-L> :nohl<CR><C-L>
inoremap <C-c> <Esc>

" TAB and Shift TAB to cycle buffers
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" better window management
nnoremap <Leader>= :vertical resize +25<CR>
nnoremap <Leader>- :vertical resize -25<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>


" -----------------------------------------------------------------------------
" ----------------------------- Theme Config ----------------------------------
" -----------------------------------------------------------------------------


" onedark.vim override: Don't set a background color when running in a terminal;
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
endif

hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

colorscheme onedark 

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" Switch to your current theme
let g:airline_theme = 'onedark'
