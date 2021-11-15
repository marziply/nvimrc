set directory=$NVIM_DIR/tmp//
set backupdir=$NVIM_DIR/backup//
set undodir=$NVIM_DIR/undo//
set runtimepath^=$NVIM_DIR/plug/coc.nvim
set clipboard=unnamedplus
set tabstop=2
set softtabstop=2
set shiftwidth=2
set laststatus=2
set regexpengine=1
set backspace=indent,eol,start
set mouse=a
set cinoptions+=:0
set virtualedit=onemore
set cmdheight=2
set updatetime=100
set shortmess+=I
set signcolumn=yes
set completeopt=menuone,noselect,noinsert
set guicursor=a:ver25-blinkon750
set ttimeoutlen=0
set colorcolumn=0
set synmaxcol=300
set formatoptions-=ro
set foldlevel=2
set foldnestmax=10
set foldmethod=manual
set foldcolumn=1
set re=1
set bg=dark

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
  au VimEnter * call SetColours()
  au FileType qf nnoremap <buffer> <cr> <cr>:ccl<cr>
  au TextChanged,CursorMoved * call EasyMotionCoc()
  au BufReadPost *.mjs call FoldApiBlocks(1)
  au BufWritePost * silent :CocRestart
  au BufWritePost */nvim/*.vim call Init(1)
  au BufWritePost */sway/*.sway silent !swaymsg reload
  au BufWritePost */zsh/*.zsh silent !source "$XDG_CONFIG_HOME/zsh/init.zsh"
  au BufWritePost */tmux.conf silent !tmux source-file "$XDG_CONFIG_HOME/tmux.conf"
  au BufEnter,InsertLeave * syn sync fromstart
  au BufEnter,InsertLeave * syn match jsDocTags contained "@\(openapi\)\>"
  au BufEnter,BufReadPost .env.* set ft=sh
  au BufEnter,BufReadPost *.vue set ft=vue
  au BufEnter,BufReadPost *.njk.html set ft=htmldjango
  au BufEnter,BufReadPost *.html.tera set ft=htmldjango
  au BufEnter,BufReadPost *.tera.html set ft=htmldjango
  " au BufEnter,BufReadPost *.sway set ft=i3config
  au BufEnter,BufReadPost *.sway set ft=config
  au BufEnter,BufReadPost *.jq set ft=jq
  au BufEnter,BufReadPost *.json.jbuilder set ft=ruby
  au BufEnter,BufReadPost *.rs set shiftwidth=2
aug end
