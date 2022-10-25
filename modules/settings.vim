" 3

set runtimepath^=$NVIM_DIR/plug/coc.nvim
set shadafile=$NVIM_CACHE_DIR/session.shada
set directory=$NVIM_CACHE_DIR/tmp//
set backupdir=$NVIM_CACHE_DIR/backup//
set undodir=$NVIM_CACHE_DIR/undo//
set completeopt=menuone,noselect,noinsert
set backspace=indent,eol,start
set guicursor=a:ver25-blinkon750
" set virtualedit=onemore
set clipboard=unnamedplus
set cinoptions+=:0
set formatoptions-=ro
set shortmess+=I
set laststatus=3
set softtabstop=2
set laststatus=2
set shiftwidth=2
set tabstop=2
set cmdheight=2
set updatetime=100
set signcolumn=yes
set ttimeoutlen=0
set colorcolumn=0
set synmaxcol=300
set foldlevel=2
set foldnestmax=10
set foldmethod=manual
set foldcolumn=1
set mouse=a
set bg=dark
set re=1

set undofile
set incsearch
set expandtab
set cursorcolumn
set cursorline
set ignorecase
set smartcase
set autoindent
set expandtab
set lazyredraw
set splitright
set splitbelow
set hidden
set autoread
set smartcase
set termguicolors
set showcmd
set nu

set nohlsearch
set noswapfile
set nobackup
set nowritebackup
set nowrap
set nofoldenable

exe 'set wildignore+=' . join(g:wild_ignore_dirs, ',')

color one
filetype off
syn on

aug aug
  au!
  au BufWritePost */nvim/{modules/*.vim,init.vim} exec 'source $NVIM_DIR/init.vim'
  au BufWritePost */tmux/*.conf silent !tmux source "$TMUX_DIR/tmux.conf"
  au BufWritePost */sway/*.sway silent !swaymsg reload
  au BufEnter,InsertLeave * syn sync fromstart
  au BufEnter,BufReadPost *.{njk,tera}.html,*.html.tera set ft=htmldjango
  au BufEnter,BufReadPost .env.* set ft=sh
  au BufEnter,BufReadPost *.sway set ft=i3config
  au BufEnter,BufReadPost *.jq set ft=jq
  au BufEnter,BufReadPost *.h set ft=c
  au BufEnter,BufReadPost *.rs set shiftwidth=2
aug end
