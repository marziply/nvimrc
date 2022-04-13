if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = glob("$HOME/.config") | endif
if empty($NVIM_DIR) | let $NVIM_DIR = glob("$XDG_CONFIG_HOME/nvim") | endif

let g:rc = [
  \ "vars",
  \ "utils",
  \ "mappings",
  \ "settings"
\]
let g:imports = map(g:rc, "v:val . '.vim'")
let g:hop_init = ":lua require('hop').setup()"

let s:auto_dir = "$NVIM_DIR/autoload"
let s:plug_file = s:auto_dir . "/plug.vim"
let s:plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if empty(glob(s:plug_file))
  if empty(glob(s:auto_dir)) | silent exec "!mkdir " . s:auto_dir | endif

  exec "!curl -fLo " . s:plug_file . " --create-dirs " . s:plug_url

  au VimEnter * PlugInstall --sync | source s:plug_file
endif

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

" Colour schemes
Plug 'rakr/vim-one'

" Language server
Plug 'neoclide/coc.nvim',
" Code snippets
Plug 'honza/vim-snippets'
" Context specific syntax highlighting
Plug 'shougo/context_filetype.vim'
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
" Surround selection/words with scopes, quotes, parens, etc.
Plug 'tpope/vim-surround'
" Split or join language specific lines of code
Plug 'andrewradev/splitjoin.vim'
" Undo tree navigator
Plug 'simnalamburt/vim-mundo'
" Fuzzy search
Plug 'junegunn/fzf'
" Matchit improved
Plug 'andymass/vim-matchup'
" Plug 'tyru/caw.vim'
Plug 'tomtom/tcomment_vim'
" Kubectl
Plug 'rottencandy/vimkubectl'
" Rust
Plug 'rust-lang/rust.vim'
" Column mark names
Plug 'kshenoy/vim-signature'
" Git history/diff info in column
Plug 'airblade/vim-gitgutter'
" Git integration commands
Plug 'tpope/vim-fugitive'
" Git merge tool
Plug 'samoshkin/vim-mergetool'
" Motions via cursor text search
" Plug 'easymotion/vim-easymotion'
Plug 'phaazon/hop.nvim',

call plug#end()

lua require('hop').setup({
  \ keys = 'asdghjklqweryuiop'
\ })

call Init(0)
