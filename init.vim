" --------------------------------------------------------------------------- ==>
" ------------------------------ Plug-Ins ----------------------------------- ==>
" --------------------------------------------------------------------------- ==>

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'Yggdroot/indentLine'                    " ==> indent guides
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'maxbrunsfeld/vim-yankstack'
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

" --------------------------------------------------------------------------- ==>
" -------------------------- General Settings ------------------------------- ==>
" --------------------------------------------------------------------------- ==>

call yankstack#setup()                    " this has to be called before set clipboard
set clipboard=unnamedplus                 " Copy paste between vim and everything else
set cmdheight=2                           " More space for displaying messages
set expandtab                             " Converts tabs to spaces
set foldexpr=nvim_treesitter#foldexpr()   " Folding decided by treesitter
set foldlevelstart=100                    " Start unfolded
set foldmethod=expr                       " Fold based on sytax
set hidden                                " Required to keep multiple buffers open
set inccommand=nosplit                    " Interactive substitution
set mouse=a                               " Enable your mouse
set nobackup noswapfile nowritebackup     " This is recommended by coc
set noerrorbells                          " Stop those annoying bells
set noshowmode                            " Airline takes care of showing modes
set nowrap                                " Display long lines as just one line
set number relativenumber                 " Line numbers
set pumblend=15                           " Transparency for floating windows
set scrolloff=5                           " 5 lines are above and below cursor
set shiftwidth=4                          " Change the number of space characters inserted for indentation
set shortmess+=c                          " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                        " So error/git diagnostics don't cause a column shift
set softtabstop=4 tabstop=4               " Insert 4 spaces for a tab
set splitbelow splitright                 " Splits will automatically be below and to the right
set termguicolors                         " Enable gui colors
set timeoutlen=250                        " By default timeoutlen is 1000 ms
set undodir=~/.vim/undodir                " Creates directory to store undos
set undofile                              " Returns name of undo file
set updatetime=100                        " Faster completion
set wildignorecase                        " Ignore Case in wildmenu
set wildmode=longest:full,full            " Bash like completion in command model
set wildoptions+=pum                      " Wildmenu completion happens in a popup

" Remove auto commentinging new line
au BufEnter * set fo-=c fo-=r fo-=o

" help menu opens vertically
cnoreabbrev h vert h

" highlight text when yanked
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 350})
augroup END

" --------------------------------------------------------------------------- ==>
" -------------------------- Basic Key Mappings ----------------------------- ==>
" --------------------------------------------------------------------------- ==>

let g:mapleader = " "
map Y y$
inoremap <C-c> <Esc>
nnoremap <leader>` :source $MYVIMRC<CR>

" unmapping a few keys that annoy me
nnoremap K <nop>
nnoremap Q <nop>

" better tabbing and moving blocks of code
vnoremap < <gv
vnoremap > >gv
vnoremap K :m '<-2<cr>gv=gv
vnoremap J :m '>+1<cr>gv=gv

" easy comments
nnoremap <space>/ :Commentary<cr>
vnoremap <space>/ :Commentary<cr>

" tab/buffer manipulation
nnoremap <leader>d   :bd<cr>
nnoremap <leader>dd  :bd!<cr>
nnoremap <TAB>       :bnext<cr>
nnoremap <S-TAB>     :bprevious<cr>
nnoremap <leader>wo  :%bd <bar> e# <bar> normal `" <cr>
nmap <leader>1 <plug>AirlineSelectTab1
nmap <leader>2 <plug>AirlineSelectTab2
nmap <leader>3 <plug>AirlineSelectTab3
nmap <leader>4 <plug>AirlineSelectTab4
nmap <leader>5 <plug>AirlineSelectTab5

" --------------------------------------------------------------------------- ==>
" ----------------------------- Theme Config -------------------------------- ==>
" --------------------------------------------------------------------------- ==>

augroup dracula_customization
  au!
  autocmd colorscheme dracula hi draculacomment gui=italic
augroup end

colorscheme dracula

" vim-airline tab and theme config
let g:airline_theme ='dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#ignore_bufadd_pat ='!|startify|undotree'

" --------------------------------------------------------------------------- ==>
" -------------------------- plugin key mappings ---------------------------- ==>
" --------------------------------------------------------------------------- ==>

" FZF setup
let g:fzf_layout = {'window': { 'width': 0.9, 'height': 0.8 }}
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg<Space>
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': ['--preview', '([[ -f {} ]] && (bat --style=numbers --color=always {} )) || ([[ -d {} ]] && (tree -C {} | less))']}, <bang>0)

" Indent Guide settings
let g:indent_blankline_char = "¦"
let g:indentLine_fileType = ['cs', 'css', 'cpp', 'html', 'javascript', 'json', 'python', 'typescript']

" Loupe Clear Highlight
let g:LoupeVeryMagic=0
nmap <C-c> <Plug>(LoupeClearHighlight)

" Treesitter setup for highlight
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = { enable = true },
}
EOF

" Undo tree
nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 35

" Vim-Rooter ==> if root isn't found, use current directory
let g:rooter_change_directory_for_non_project_files = 'current'

" Vim-RSI ==> disable meta-key bindings
let g:rsi_no_meta = 1

" Yankstack
nmap <A-n> <Plug>yankstack_substitute_newer_paste
imap <A-n> <Plug>yankstack_substitute_newer_paste
vmap <A-n> <Plug>yankstack_substitute_newer_paste

" --------------------------------------------------------------------------- ==>
" ------------------------------ COC Config --------------------------------- ==>
" --------------------------------------------------------------------------- ==>

" basic completion mappings
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Show documentation
nnoremap <silent>gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn  <Plug>(coc-rename)
nmap <leader>cs  :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" ==> coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)

" ==> coc-explorer
nmap <C-e> :CocCommand explorer<CR>

" ==> coc-fzf -- 'list-diagnostics' & 'list-symbols'
nnoremap <Leader>ld :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <Leader>ls :<C-u>CocFzfList outline<CR>
let g:coc_fzf_preview_toggle_key = 'ctrl-/'
let g:coc_fzf_preview = 'down:50%'
let g:coc_fzf_opts = []

" ==> coc-pairs auto indent on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" --------------------------------------------------------------------------- ==>
" -------------------------- Tmux Vim Integration---------------------------- ==>
" --------------------------------------------------------------------------- ==>

" Tmux-Vim navigator
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
let g:tmux_navigator_disable_when_zoomed = 1
" change windows from any mode
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
inoremap <silent> <C-h> <Esc> :TmuxNavigateLeft<cr>
inoremap <silent> <C-j> <Esc> :TmuxNavigateDown<cr>
inoremap <silent> <C-k> <Esc> :TmuxNavigateUp<cr>
inoremap <silent> <C-l> <Esc> :TmuxNavigateRight<cr>
vnoremap <silent> <C-h> <Esc> :TmuxNavigateLeft<cr>
vnoremap <silent> <C-j> <Esc> :TmuxNavigateDown<cr>
vnoremap <silent> <C-k> <Esc> :TmuxNavigateUp<cr>
vnoremap <silent> <C-l> <Esc> :TmuxNavigateRight<cr>

" Tmux-Vim Resizer
let g:tmux_resizer_no_mappings = 1
" resize windows
nnoremap <silent> <A-h> :TmuxResizeLeft<cr>
nnoremap <silent> <A-j> :TmuxResizeDown<cr>
nnoremap <silent> <A-k> :TmuxResizeUp<cr>
nnoremap <silent> <A-l> :TmuxResizeRight<cr>

" close current split for both Tmux and Vim
nnoremap <A-d> <C-w>c

" ---------------------------- ==> Vimux <== -------------------------------- "
let g:VimuxOrientation = "h"
let g:VimuxHeight = "30"
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :w<CR> <bar> :VimuxRunLastCommand<CR>

" If text is selected, save it in the v buffer and send that buffer it to tmux
function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction
vmap <Leader>vs "vy :call VimuxSlime()<CR>

" --------------------------------------------------------------------------- ==>
" ---------------------------- Startify Config ------------------------------ ==>
" --------------------------------------------------------------------------- ==>

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
let g:startify_custom_header = 'startify#pad(startify#fortune#cowsay())'
