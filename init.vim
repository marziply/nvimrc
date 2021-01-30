if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = glob("$HOME/.config") | endif
if empty($NVIM_DIR) | let $NVIM_DIR = glob("$XDG_CONFIG_HOME/nvim") | endif

let s:auto_dir = "$NVIM_DIR/autoload"
let s:plug_file = s:auto_dir . "/plug.vim"
let s:plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if empty(glob(s:plug_file))
  if empty(glob(s:auto_dir)) | silent exec "!mkdir " . s:auto_dir | endif

  silent exec "
    \ !curl -fLo \" . s:plug_file
    \ --create-dirs \" . s:plug_url
  \"

  au VimEnter * PlugInstall --sync | source s:plug_file
endif

let g:rc = ["vars", "utils", "mappings", "settings"]
let g:imports = map(g:rc, "v:val . '.vim'")

if !exists("*Init")
  fun! Init (reset)
    if a:reset
      call feedkeys("\<space>r")

      exec "so $NVIM_DIR/init.vim"

      echo "Reset"
    else
      for i in g:imports | exec "so $NVIM_DIR/" . i | endfor
    endif

    call SetColours()
  endfun
endif

call plug#begin("$NVIM_DIR/plug")

" Language specific plugins
Plug 'pangloss/vim-javascript'
Plug 'leafoftree/vim-vue-plugin'
Plug 'sheerun/vim-polyglot'

" Code snippets
Plug 'honza/vim-snippets'
" Context specific syntax highlighting
Plug 'shougo/context_filetype.vim'
" Colour scheme
Plug 'rakr/vim-one'
" Linter
Plug 'w0rp/ale'
" Status bar
Plug 'vim-airline/vim-airline'
" Status bar theme
Plug 'vim-airline/vim-airline-themes'
" Search for files
Plug 'ctrlpvim/ctrlp.vim'
" Search in files
Plug 'dyng/ctrlsf.vim'
" Automatically close scopes, quotes, parens, etc.
Plug 'jiangmiao/auto-pairs'
" Soft delete buffers
Plug 'moll/vim-bbye'
" Dim inactive panes
Plug 'blueyed/vim-diminactive'
" Advanced regex matcher
Plug 'othree/eregex.vim'
" Surround selection/words with scopes, quotes, parens, etc.
Plug 'tpope/vim-surround'
" Motions via cursor text search
Plug 'easymotion/vim-easymotion'
" Split or join language specific lines of code
Plug 'andrewradev/splitjoin.vim'
" Undo tree navigator
Plug 'simnalamburt/vim-mundo'
" Language server
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Matchit improved
Plug 'andymass/vim-matchup'
" Context specific comments
" Plug 'tyru/caw.vim'
Plug 'tomtom/tcomment_vim'

call plug#end()
call Init(0)
