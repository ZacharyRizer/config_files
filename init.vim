" --------------------------------------------------------------------------- ==>
" ------------------------------ Plug-Ins ----------------------------------- ==>
" --------------------------------------------------------------------------- ==>

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'vimwiki/vimwiki'

Plug 'christoomey/vim-tmux-navigator'         " ==> Tmux-Vim integration <==
Plug 'RyanMillerC/better-vim-tmux-resizer'
Plug 'benmills/vimux'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'

Plug 'ZacharyRizer/statusline', {'branch': 'main'}
Plug 'ZacharyRizer/my_dracula'
Plug 'ZacharyRizer/vim-yankstack'

call plug#end()
call yankstack#setup()

" --------------------------------------------------------------------------- ==>
" -------------------------- General Settings ------------------------------- ==>
" --------------------------------------------------------------------------- ==>

set clipboard=unnamedplus                 " Copy paste between vim and everything else
set cmdheight=2                           " More space for displaying messages
set completeopt=menuone,noinsert,noselect " Hanldes how the completion menus function
set expandtab                             " Converts tabs to spaces
set hidden                                " Required to keep multiple buffers open
set ignorecase smartcase                  " Smart searching in regards to case
set inccommand=nosplit                    " Interactive substitution
set lazyredraw                            " Help with screen redraw lag
set listchars=tab:»\ ,trail:·,precedes:<,extends:>,eol:↲,nbsp:␣
set mouse=a                               " Enable your mouse
set nobackup noswapfile nowritebackup     " This is recommended by coc
set noerrorbells                          " Stop those annoying bells
set noshowmode                            " Airline takes care of showing modes
set nowrap                                " Display long lines as just one line
set number relativenumber                 " Line numbers
set pumblend=15                           " Transparency for floating windows
set scrolloff=10                          " 10 lines are above and below cursor
set shortmess+=c                          " Don't pass messages to |ins-completion-menu|.
set sidescrolloff=10                      " Keep 5 columns on either side of the cursor
set signcolumn=yes                        " So error/git diagnostics don't cause a column shift
set shiftwidth=2 softtabstop=2 tabstop=2  " Insert 2 spaces for a tab
set splitbelow splitright                 " Splits will automatically be below and to the right
set termguicolors                         " Enable gui colors
set timeoutlen=250                        " By default timeoutlen is 1000 ms
set undodir=~/.vim/undodir                " Creates directory to store undos
set undofile                              " Returns name of undo file
set updatetime=100                        " Faster completion
set wildignorecase                        " Ignore Case in wildmenu
set wildmode=longest:full,full            " Bash like completion in command model
set wildoptions+=pum                      " Wildmenu completion happens in a popup

" help menu opens vertically
cnoreabbrev h vert h

augroup AUTO_COMMANDS
    autocmd!
    autocmd BufWinEnter,FocusGained,VimEnter,WinEnter, * setlocal cursorline
    autocmd FocusLost,WinLeave * setlocal nocursorline
    autocmd BufEnter * set fo-=c fo-=r fo-=o
    autocmd BufNewFile ~/vimwiki/diary/*.md :silent 0r !~/vimwiki/bin/generate-vimwiki-diary-template
    autocmd BufWritePre * %s/\s\+$//e
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 350})
    autocmd VimResized * :wincmd =
augroup END

augroup FileSpecifics
    autocmd!
    autocmd FileType go setlocal shiftwidth=4 softtabstop=4 tabstop=4
    autocmd FileType haskell setlocal shiftwidth=4 softtabstop=4 tabstop=4
    autocmd FileType python setlocal shiftwidth=4 softtabstop 4 tabstop=4
augroup END

colorscheme dracula     " ==> my fork of this theme

" --------------------------------------------------------------------------- ==>
" -------------------------- Basic Key Mappings ----------------------------- ==>
" --------------------------------------------------------------------------- ==>

let g:mapleader = " "
inoremap <C-c> <Esc>
nnoremap <C-c> :nohl<CR>
nnoremap <leader>` :source $MYVIMRC<CR>

" unmapping a few keys that annoy me
nnoremap K <nop>
nnoremap Q <nop>
nnoremap <Space> <nop>

" easy word replace and */# searching stay in place
nnoremap c* *Ncgn
nnoremap *  *N
nnoremap #  #N
vnoremap *  y/\V<C-R>=escape(@",'/\')<CR><CR>N
vnoremap #  y?\V<C-R>=escape(@",'/\')<CR><CR>N

" better tabbing
vnoremap < <gv
vnoremap > >gv
nnoremap < <<
nnoremap > >>

" more intuitive yanking
map Y y$
vmap y y`>

" easy buffer delete and close
nnoremap <leader>d   :bd<cr>
nnoremap <leader>dd  :bd!<cr>
nnoremap <leader>wo  :%bd <bar> e# <bar> normal `" <cr>

" --------------------------------------------------------------------------- ==>
" -------------------------- plugin key mappings ---------------------------- ==>
" --------------------------------------------------------------------------- ==>

" FZF setup
let g:fzf_buffers_jump = 1
let g:fzf_layout = {'window': { 'width': 0.9, 'height': 0.8 }}
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': ['--preview', '([[ -f {} ]] && (bat --style=numbers --color=always {} )) || ([[ -d {} ]] && (tree -C {} | less))']}, <bang>0)

" Telescope
nnoremap <Leader>c :lua require('telescope.builtin').commands()<CR>
nnoremap <Leader>f :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>g :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ")})<CR>
nnoremap <Leader>G :lua require('telescope.builtin').live_grep()<CR>
nnoremap <Leader>h :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>H :lua require('telescope.builtin').oldfiles()<CR>

lua << EOF
require('telescope').setup{
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending",
    width = 0.85,
  }
}
require('telescope').load_extension('fzy_native')
EOF

" Treesitter setup for highlight
lua require'nvim-treesitter.configs'.setup { ensure_installed = "all", highlight = { enable = true } }

" Undo tree
nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 40
let g:undotree_WindowLayout = 3

" Vim-Commentary
nnoremap <space>/ :Commentary<cr>
vnoremap <space>/ :Commentary<cr>

" Vim-RSI ==> disable meta-key bindings
let g:rsi_no_meta = 1

" VimWiki
let g:vimwiki_global_ext = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_table_mappings = 0
nmap <C-n> <Plug>VimwikiNextLink
nmap <C-p> <Plug>VimwikiPrevLink

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

inoremap <silent><expr> <c-space> coc#refresh()

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

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" ==> coc-explorer
nmap <C-e> :CocCommand explorer<CR>

" ==> coc-fzf
let g:coc_fzf_preview_toggle_key = 'ctrl-/'
let g:coc_fzf_preview = 'down:50%'
let g:coc_fzf_opts = []
nnoremap <Leader>la :<C-u>CocFzfList actions<CR>
nnoremap <Leader>lc :<C-u>CocFzfList commands<CR>
nnoremap <Leader>ld :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <Leader>ls :<C-u>CocFzfList outline<CR>


" ==> coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)

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

" ---------------------------- ==> Vimux <== -------------------------------- "

let g:VimuxOrientation = "h"
let g:VimuxHeight = "35"
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :w<CR> <bar> :VimuxRunLastCommand<CR>
map <Leader>vz :VimuxZoomRunner<CR>

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
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_persistence = 1

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
