call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
   Plug 'chrisbra/csv.vim'
   Plug 'simeji/winresizer'
   Plug 'simnalamburt/vim-mundo'
call plug#end()

set clipboard+=unnamedplus

" no swap file
set noswapfile

" save undo-trees in files
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=10000
set undoreload=10000

"set line number
set number

" use 4 spaces instead of tab
" copy indent from current line when starting a new line

set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set hidden

nnoremap <space> <nop>
let mapleader = "\<space>"

nnoremap <leader>bn :bn<cr> ;buffer next
nnoremap <leader>tn gt ;new tab

nnoremap <c-w>h <c-w>s 
