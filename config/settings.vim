" General
set cmdheight=2
set timeoutlen=3000
set updatetime=250
set signcolumn=yes
set clipboard+=unnamedplus

" Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab

" Lists
set completeopt=menu,menuone,noselect
set backspace=indent,eol,start

" Booleans
set cursorline
set cursorcolumn
set ignorecase
set smartcase
set splitright
set splitbelow
set number
set undofile
set incsearch
set expandtab
set hidden
set autoread
set showcmd
set linebreak
set nohlsearch
set noswapfile
set nobackup
set nowritebackup

call SetWith('shadafile', g:nvim_cache_dir . '/session.shada')
call SetWith('directory', g:nvim_cache_dir . '/tmp//')
call SetWith('backupdir', g:nvim_cache_dir . '/backup//')
call SetWith('undodir', g:nvim_cache_dir . '/undo//')
