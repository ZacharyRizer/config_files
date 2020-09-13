" --------------------------------------------------------------------------- "
" -------------------------- General Settings ------------------------------- "
" --------------------------------------------------------------------------- "

syntax enable                             " Enables syntax highlighing
set autoindent                            " Makes indenting smart
set clipboard=unnamedplus                 " Copy paste between vim and everything else
set colorcolumn=80                        " Show indicator at 80 chars
set cmdheight=2                           " More space for displaying messages
set expandtab                             " Converts tabs to spaces
set hidden                                " Required to keep multiple buffers open multiple buffers
set ignorecase incsearch smartcase        " more intelligent search
set mouse=a                               " Enable your mouse
set nobackup noswapfile                   " This is recommended by coc
set noerrorbells                          " Stop those annoying bells
set noshowmode                            " Airline takes care of showing modes
set nowrap                                " Display long lines as just one line
set number relativenumber                 " Line numbers
set shiftwidth=2                          " Change the number of space characters inserted for indentation
set shortmess+=c                          " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                        " So COC diagnostics don't cause a column shift
set smarttab                              " Auto selects tab size based on surrounding tabs
set softtabstop=2                         " Insert 4 spaces for a tab
set splitbelow splitright                 " Splits will automatically be below and to the right
set termguicolors                         " Enable gui colors
set timeoutlen=250                        " By default timeoutlen is 1000 ms
set undodir=~/.vim/undodir                " Creates directory to store undos
set undofile                              " Returns name of undo file
set updatetime=50                         " Faster completion
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
Plug 'junegunn/vim-slash'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

Plug 'christoomey/vim-tmux-navigator'         " ==> Tmux-Vim integration <==
Plug 'RyanMillerC/better-vim-tmux-resizer'
Plug 'benmills/vimux'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
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

" Shift-y like D and C <==> C-c for ESC insert
let g:mapleader = " "
map Y y$
inoremap <C-c> <Esc>

" close current split
nnoremap <A-d> <C-w>c

" help menu opens vertically
cnoreabbrev h vert h

" better tabbing and moving blocks of code
vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Easy comments
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>

" --------------------------------------------------------------------------- "
" ----------------------------- Theme Config -------------------------------- "
" --------------------------------------------------------------------------- "

augroup dracula_customization
  au!
  autocmd ColorScheme dracula hi DraculaComment gui=italic
augroup END

colorscheme dracula

" vim-airline tab and theme config
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#ignore_bufadd_pat='!|startify|undotree'
nnoremap <Leader>d :bd<CR>
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5

" --------------------------------------------------------------------------- "
" -------------------------- Plugin Key Mappings ---------------------------- "
" --------------------------------------------------------------------------- "

" vim-slash --- center current search result on the screen and blink
if has('timers')
  noremap <expr> <plug>(slash-after) 'zz'.slash#blink(3, 100)
endif

" Toggle undo tree
nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
let g:undotree_RelativeTimestamp = 0
let g:undotree_SetFocusWhenToggle = 1

" Ranger
let g:rnvimr_ex_enable = 1        " Ranger replaces netrw
let g:rnvimr_enable_bw = 1        " wipe Nvim buffers when deleted in Ranger
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': float2nr(round(0.8 * &columns)),
            \ 'height': float2nr(round(0.8 * &lines)),
            \ 'col': float2nr(round(0.1 * &columns)),
            \ 'row': float2nr(round(0.1 * &lines)),
            \ 'style': 'minimal' }
nmap <Leader>r :RnvimrToggle<CR>

" FZF settings
nnoremap <C-t>  :FZF<CR>
nnoremap <leader>g  :Rg<CR>
nnoremap <leader>b  :Buffers<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'border': 'sharp' } }

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

" ==> Vimux <== "
let g:VimuxOrientation = "h"
let g:VimuxHeight = "35"
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction
" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <Leader>vs "vy :call VimuxSlime()<CR>

" --------------------------------------------------------------------------- "
" ------------------------------ COC Config --------------------------------- "
" --------------------------------------------------------------------------- "

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gt <Plug>(coc-type-definition)
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

" -----------------------------------------------------------------------------
" <=== ------------- COC Extension Specific Commands --------------------- ===>
" -----------------------------------------------------------------------------

" ==> coc-yank -- show yank list
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" ==> coc-Prettier command -- format on save
command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <silent><expr> <C-space> coc#refresh()

" ==> coc-pairs auto indent on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" ==> coc-snippets -- function like vscode snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" ==> coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)

" -----------------------------------------------------------------------------
" <=== ---------------------- Startify Config ---------------------------- ===>
" -----------------------------------------------------------------------------

" Session storage location
let g:startify_session_dir = '~/.config/nvim/session'
" keybind to open startify
nnoremap <leader><CR> :Startify<CR>

" structure of start screen
let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   Files'] },
            \ { 'type': 'dir',       'header': ['   Current Project Directory '. getcwd()] },
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
