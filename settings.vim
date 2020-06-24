set directory=$NVIM_DIR/tmp//
set backupdir=$NVIM_DIR/backup//
set undodir=$NVIM_DIR/undo//
set undofile
set nohlsearch
set incsearch
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set cursorcolumn
set cursorline
set ignorecase
set smartcase
set laststatus=2
set nu
set autoindent
set expandtab
set regexpengine=1
set lazyredraw
set backspace=indent,eol,start
set splitright
set splitbelow
set mouse=a
set hidden
set cinoptions+=:0
set noswapfile
set virtualedit=onemore
set cmdheight=2
set nobackup
set nowritebackup
set updatetime=100
set shortmess+=c
set signcolumn=yes
set completeopt=menuone,noselect,noinsert
set wildignore+=*/node_modules/*,*/.git/*,*/vendor/*,*/docs/*,*/coverage/*,*/tmp/*
set guicursor=a:ver25-blinkon750
set autoread
set ttimeoutlen=0
set smartcase
set termguicolors
set colorcolumn=0
set synmaxcol=250
set showcmd
set formatoptions-=ro
set nofoldenable
set foldlevel=2
set foldnestmax=10
set foldmethod=manual
set foldcolumn=1
set nowrap
set re=1
set bg=dark

color one
runtime macros/matchit.vim
filetype off
syn on

aug aug
  au!
  au BufEnter,InsertLeave * syntax sync fromstart
  au VimEnter * call SetColours()
  au VimEnter * call ChangeDirectory(1)
  au BufWritePost $NVIM_DIR/*.vim call Init(1)
  au BufEnter,BufReadPost *.vue set ft=vue
  au BufEnter,BufReadPost .env.* set ft=sh
aug end
