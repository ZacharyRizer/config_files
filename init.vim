" --------------------------------------------------------------------------- "
" -------------------------- General Settings ------------------------------- "
" --------------------------------------------------------------------------- "

set clipboard=unnamedplus                 " Copy paste between vim and everything else
set colorcolumn=80                        " Show indicator at 80 chars
set cmdheight=2                           " More space for displaying messages
set expandtab                             " Converts tabs to spaces
set hidden                                " Required to keep multiple buffers open multiple buffers
set inccommand=nosplit                    " interactive substitution
set mouse=a                               " Enable your mouse
set nobackup noswapfile nowritebackup     " This is recommended by coc
set noerrorbells                          " Stop those annoying bells
set noshowmode                            " Airline takes care of showing modes
set nowrap                                " Display long lines as just one line
set number relativenumber                 " Line numbers
set shiftwidth=2                          " Change the number of space characters inserted for indentation
set shortmess+=c                          " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                        " So error/git diagnostics don't cause a column shift
set softtabstop=2                         " Insert 4 spaces for a tab
set splitbelow splitright                 " Splits will automatically be below and to the right
set termguicolors                         " Enable gui colors
set timeoutlen=250                        " By default timeoutlen is 1000 ms
set undodir=~/.vim/undodir                " Creates directory to store undos
set undofile                              " Returns name of undo file
set updatetime=150                        " Faster completion
set wildignorecase wildmode=longest:full  " 'bash' like completion in command mode

" Remove auto commentinging new line
au BufEnter * set fo-=c fo-=r fo-=o

" --------------------------------------------------------------------------- "
" ------------------------------ Plug-Ins ----------------------------------- "
" --------------------------------------------------------------------------- "

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'   " allows semantic hstatementsighlighting in C++
Plug 'sheerun/vim-polyglot'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'wincent/loupe'

Plug 'christoomey/vim-tmux-navigator'         " ==> Tmux-Vim integration <==
Plug 'RyanMillerC/better-vim-tmux-resizer'
Plug 'benmills/vimux'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'

Plug 'vim-airline/vim-airline'                 " ==> theme related plugins <==
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ryanoasis/vim-devicons'

call plug#end()
" --------------------------------------------------------------------------- "
" -------------------------- Basic Key Mappings ----------------------------- "
" --------------------------------------------------------------------------- "

" leader key, preferred escape, source rc file
let g:mapleader = " "
inoremap <C-c> <Esc>
nnoremap <leader>` :source $MYVIMRC<CR>

" close current split
nnoremap <A-d> <C-w>c

" help menu opens vertically
cnoreabbrev h vert h

" better tabbing and moving blocks of code
vnoremap < <gv
vnoremap > >gv
vnoremap K :m '<-2<cr>gv=gv
vnoremap J :m '>+1<cr>gv=gv

" Easy comments
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>

" tab/buffer manipulation
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>D :bd!<CR>
nnoremap <Leader>[ :bprevious<CR>
nnoremap <Leader>] :bnext<CR>
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5

" --------------------------------------------------------------------------- "
" ----------------------------- Theme Config -------------------------------- "
" --------------------------------------------------------------------------- "

augroup dracula_customization
  au!
  autocmd ColorScheme dracula hi DraculaComment gui=italic
augroup END

colorscheme dracula

" vim-airline tab and theme config
let g:airline_theme ='dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#ignore_bufadd_pat ='!|startify|undotree'

" --------------------------------------------------------------------------- "
" -------------------------- Plugin Key Mappings ---------------------------- "
" --------------------------------------------------------------------------- "

" Loupe Clear Highlight
let g:LoupeVeryMagic=0
nmap <C-c> <Plug>(LoupeClearHighlight)

" Toggle undo tree
nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
let g:undotree_RelativeTimestamp = 1
let g:undotree_SetFocusWhenToggle = 1

" FZF settings
nnoremap <C-t>  :FZF<CR>
nnoremap <leader>f  :GFiles<CR>
nnoremap <leader>g  :Rg<CR>
nnoremap <leader>b  :Buffers<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'border': 'sharp' } }

" vim-rooter ==> if root isn't found, use current directory
let g:rooter_change_directory_for_non_project_files = 'current'

" --------------------------------------------------------------------------- "
" -------------------------- Tmux Vim Integration---------------------------- "
" --------------------------------------------------------------------------- "

" Tmux-Vim navigator
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
" change windows from any mode
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-p> :TmuxNavigatePrevious<cr>
inoremap <silent> <A-h> <Esc> :TmuxNavigateLeft<cr>
inoremap <silent> <A-j> <Esc> :TmuxNavigateDown<cr>
inoremap <silent> <A-k> <Esc> :TmuxNavigateUp<cr>
inoremap <silent> <A-l> <Esc> :TmuxNavigateRight<cr>
inoremap <silent> <A-p> <Esc> :TmuxNavigatePrevious<cr>
vnoremap <silent> <A-h> <Esc> :TmuxNavigateLeft<cr>
vnoremap <silent> <A-j> <Esc> :TmuxNavigateDown<cr>
vnoremap <silent> <A-k> <Esc> :TmuxNavigateUp<cr>
vnoremap <silent> <A-l> <Esc> :TmuxNavigateRight<cr>
vnoremap <silent> <A-p> <Esc> :TmuxNavigatePrevious<cr>

" Tmux-Vim Resizer
let g:tmux_resizer_no_mappings = 1
" resize windows
nnoremap <silent> <A-Left> :TmuxResizeLeft<cr>
nnoremap <silent> <A-Down> :TmuxResizeDown<cr>
nnoremap <silent> <A-Up> :TmuxResizeUp<cr>
nnoremap <silent> <A-Right> :TmuxResizeRight<cr>

" ---------------------------- ==> Vimux <== -------------------------------- "
let g:VimuxOrientation = "h"
let g:VimuxHeight = "35"
map <Leader>vp :w<CR> <bar> :VimuxPromptCommand<CR>
map <Leader>vl :w<CR> <bar> :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

" If text is selected, save it in the v buffer and send that buffer it to tmux
function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction
vmap <Leader>vs "vy :call VimuxSlime()<CR>

" for C++ projects, build from cmake, then run binary
function! CPP_Build_Run()
  call VimuxOpenRunner()
  call VimuxSendText("cmake --build build ; bin/* ")
  call VimuxSendKeys("Enter")
endfunction
map <F5> :w<CR> <bar> :call CPP_Build_Run()<CR>

" --------------------------------------------------------------------------- "
" ------------------------------ COC Config --------------------------------- "
" --------------------------------------------------------------------------- "

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" -----------------------------------------------------------------------------
" <=== ------------- COC Extension Specific Commands --------------------- ===>
" -----------------------------------------------------------------------------

" ==> coc-yank -- show yank list
map Y y$
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" ==> coc-pairs auto indent on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" ==> coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)

" ==> coc-explorer
nmap <space>e :CocCommand explorer<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" -----------------------------------------------------------------------------
" <=== ---------------------- Startify Config ---------------------------- ===>
" -----------------------------------------------------------------------------

nnoremap <Leader><CR> :Startify<CR>
" if all buffers are closed, open Startify
autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif

" session management
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_persistence = 1
nnoremap <Leader>s :SSave! <CR>

" structure of start screen
let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   Files'] },
            \ { 'type': 'sessions',  'header': ['   Sessions'] },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] }
            \ ]

" few common files
let g:startify_bookmarks = [
            \ { 'c': '~/.config/nvim/coc-settings.json' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 't': '~/.tmux.conf' },
            \ { 'z': '~/.zshrc' }
            \ ]

" custom header
let g:startify_custom_header = [
            \ ' ______   ______     ______     ______   ______     __   __        ______   ______     ______     __  __    ',
            \ '/\  == \ /\  == \   /\  __ \   /\__  _\ /\  __ \   /\ "-.\ \      /\  == \ /\  __ \   /\  ___\   /\ \/ /    ',
            \ '\ \  _-/ \ \  __<   \ \ \/\ \  \/_/\ \/ \ \ \/\ \  \ \ \-.  \     \ \  _-/ \ \  __ \  \ \ \____  \ \  _"-.  ',
            \ ' \ \_\    \ \_\ \_\  \ \_____\    \ \_\  \ \_____\  \ \_\\"\_\     \ \_\    \ \_\ \_\  \ \_____\  \ \_\ \_\ ',
            \ '  \/_/     \/_/ /_/   \/_____/     \/_/   \/_____/   \/_/ \/_/      \/_/     \/_/\/_/   \/_____/   \/_/\/_/ '
            \ ]
