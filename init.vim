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
set updatetime=250                      " Faster completion
set timeoutlen=250                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else
set incsearch ignorecase smartcase      " more intelligent search
set noshowmode                          " Airline takes care of showing modes
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
" Tab completion for command mode
set wildmenu 
set wildignorecase
set wildmode=longest:full


" -----------------------------------------------------------------------------
" ------------------------------ Plug-Ins -------------------------------------
" -----------------------------------------------------------------------------


call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" ranger.vim needs bclose.vim as dependency
Plug 'francoiscabrol/ranger.vim' 
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

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
nnoremap <TAB>      :bnext<CR>
nnoremap <S-TAB>    :bprevious<CR>
nnoremap <Leader>w  :bd<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Easy comments
nnoremap <space>/ :Commentary<CR> 
vnoremap <space>/ :Commentary<CR>

" better window management
nnoremap <M-l> :vertical resize +25<CR>
nnoremap <M-h> :vertical resize -25<CR>
nnoremap <M-k> :resize +10<CR>
nnoremap <M-j> :resize -10<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" FZF key maps -- ripgrep : fzf : fzf~ 
nnoremap <leader>g  :Rg<CR>
nnoremap <leader>f  :FZF<CR>
nnoremap <leader>fh :FZF~<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" Ranger config - make ranger replace netrw and toggle explorer with E
let g:ranger_map_keys = 0
map <leader>e :Ranger<CR>
let g:ranger_replace_netrw = 1


" -----------------------------------------------------------------------------
" ----------------------------- Theme Config ----------------------------------
" -----------------------------------------------------------------------------


" onedark.vim override: Don't set a background color when running in a terminal;
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#D5D8DF", "cterm": "145", "cterm16" : "7" }
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

" vim-airline tab and theme config
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'onedark'


" -----------------------------------------------------------------------------
" ------------------------------ COC Config -----------------------------------
" -----------------------------------------------------------------------------

" Use <TAB> or <cr> to confirm completion
if exists('*complete_info')
  inoremap <expr> <TAB> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" -----------------------------------------------------------------------------
" <=== ------------- COC Extension Specific Commands --------------------- ===>
" -----------------------------------------------------------------------------

" Prettier command to format current buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" coc-yank list
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
