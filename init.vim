" --------------------------------------------------------------------------- ==>
" ------------------------------ Plug-Ins ----------------------------------- ==>
" --------------------------------------------------------------------------- ==>

call plug#begin('~/.vim/plugged')

Plug 'tweekmonster/startuptime.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'Yggdroot/indentLine'                    " ==> indent guides
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'vimwiki/vimwiki'

Plug 'christoomey/vim-tmux-navigator'         " ==> Tmux-Vim integration <==
Plug 'RyanMillerC/better-vim-tmux-resizer'
Plug 'benmills/vimux'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'

Plug 'ZacharyRizer/vim', { 'as': 'dracula' }

call plug#end()

" --------------------------------------------------------------------------- ==>
" -------------------------- General Settings ------------------------------- ==>
" --------------------------------------------------------------------------- ==>

call yankstack#setup()                    " this has to be called before set clipboard
set clipboard=unnamedplus                 " Copy paste between vim and everything else
set cmdheight=2                           " More space for displaying messages
set completeopt=menuone,noinsert,noselect " Hanldes how the completion menus function
set expandtab                             " Converts tabs to spaces
set hidden                                " Required to keep multiple buffers open
set ignorecase smartcase                  " Smart searching in regards to case
set inccommand=nosplit                    " Interactive substitution
set lazyredraw                            " Help with screen redraw lag
set mouse=a                               " Enable your mouse
set nobackup noswapfile nowritebackup     " This is recommended by coc
set noerrorbells                          " Stop those annoying bells
set noshowmode                            " Airline takes care of showing modes
set nowrap                                " Display long lines as just one line
set number relativenumber                 " Line numbers
set pumblend=15                           " Transparency for floating windows
set scrolloff=10                          " 10 lines are above and below cursor
set shiftwidth=4                          " Change the number of space characters inserted for indentation
set shortmess+=c                          " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                        " So error/git diagnostics don't cause a column shift
" set showtabline=2                         " Always show tabline
set softtabstop=4 tabstop=4               " Insert 4 spaces for a tab
set splitbelow splitright                 " Splits will automatically be below and to the right
set statusline=%!ActiveStatus()           " Turn on default status line
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
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 350})
augroup END

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

" better yanking
map Y y$
vmap y y`>

" tab/buffer manipulation
nnoremap <leader>d   :bd<cr>
nnoremap <leader>dd  :bd!<cr>
nnoremap <TAB>       :bnext<cr>
nnoremap <S-TAB>     :bprevious<cr>
nnoremap <leader>wo  :%bd <bar> e# <bar> normal `" <cr>

" --------------------------------------------------------------------------- ==>
" ---------------------- Theme, StatusLine, TabLine ------------------------- ==>
" --------------------------------------------------------------------------- ==>

colorscheme dracula     " ==> my fork of this theme

function! FileNames()
    let specialFileNames = {'coc-explorer': 'Explorer', 'help': 'Help', 'startify': 'Startify', 'undotree': 'UndoTree'}
    if (has_key(specialFileNames, &filetype))
        return specialFileNames[&filetype]
    else
        return @%
    endif
endfunction

function! ActiveStatus()
    let statusline=""
    hi User1 guibg=#BD93F9 guifg=#282A36 gui=bold
    hi User2 guibg=#282A36 guifg=#BD93F9 gui=bold
    hi User3 guibg=#424450 guifg=#282A36
    hi User4 guibg=#424450 guifg=#F8F8F2
    hi User5 guibg=#FF5555 guifg=#282A36 gui=bold
    hi User6 guibg=#282A36 guifg=#FF5555 gui=bold
    if (&filetype == 'coc-explorer' || &filetype == 'startify' || &filetype == 'undotree' )
        let statusline.="%1*\ ﰆ\ %2*\ %{FileNames()}%3*%4*%="
    elseif (&filetype == 'help')
        let statusline.="%1*\ ﰆ\ %2*\ %{FileNames()}%3*%4*%=%3*\ %2*%3p%%\ 難\ %1*\ %2l/%L\ \ %2v\ "
    else
        if (&modified)
            let statusline.="%5*\ ﰆ\ %6*%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}%3*%4*\ %<%{FileNames()}"
            let statusline.="%=\ %{coc#status()}\ %3*\ %6*%3p%%\ 難\ %5*\ %2l/%L\ \ %2v\ "
        else 
            let statusline.="%1*\ ﰆ\ %2*%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}%3*%4*\ %<%{FileNames()}"
            let statusline.="%=\ %{coc#status()}\ %3*\ %2*%3p%%\ 難\ %1*\ %2l/%L\ \ %2v\ "
        endif

    endif
    return statusline

endfunction

function! InactiveStatus()
    hi Modified guibg=#424450 guifg=#FF5555 gui=bold,italic
    let statusline="%#Modified#%{&modified?'\ '.FileNames(): ''}%*%#StatusLineNC#%{&modified?'': '\ '.FileNames()}%=%*"
    return statusline
endfunction

augroup status
  autocmd!
  autocmd BufWinEnter,WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave * setlocal statusline=%!InactiveStatus()
augroup END

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
let g:indent_blankline_char = "│"
let g:indent_blankline_extra_indent_level = -1
let g:indentLine_char = "│"
let g:indentLine_fileType = ['cs', 'css', 'cpp', 'html', 'javascript', 'json', 'python', 'typescript']

" Treesitter setup for highlight
lua << EOF
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "maintained",
      highlight = { enable = true },
    }
EOF

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
au BufNewFile ~/vimwiki/diary/*.md :silent 0r !~/vimwiki/bin/generate-vimwiki-diary-template 

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

" ==> coc-fzf -- 'list-diagnostics' & 'list-symbols'
nnoremap <Leader>la :<C-u>CocFzfList actions<CR>
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

" if all buffers are closed, open Startify
autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif

nnoremap <Leader><CR> :Startify<CR>
nnoremap <C-s> :SSave!<CR>
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
