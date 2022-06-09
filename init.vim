if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = glob("$HOME/.config")
endif

if empty($NVIM_DIR)
  let $NVIM_DIR = glob("$XDG_CONFIG_HOME/nvim")
endif

let g:modules = glob('$NVIM_DIR/modules/*.vim', 0, 1)
  \ ->map('readfile(v:val, "", 1)->add(v:val)')
  \ ->sort({a, b -> a->get(0) > b->get(0)})
  \ ->map('v:val->get(1)')
let g:hop_init = ":lua require('hop').setup()"

let s:auto_dir = "$NVIM_DIR/autoload"
let s:plug_file = s:auto_dir . "/plug.vim"
let s:plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if empty(glob(s:plug_file))
  if empty(glob(s:auto_dir)) | silent exec "!mkdir " . s:auto_dir | endif

  exec "!curl -fLo " . s:plug_file . " --create-dirs " . s:plug_url

  au VimEnter * PlugInstall --sync | so s:plug_file
endif

call plug#begin("$NVIM_DIR/plug")

" Language specific plugins
"
" JavaScript
" https://github.com/pangloss/vim-javascript
Plug 'pangloss/vim-javascript'
" Rust
" https://github.com/rust-lang/rust.vim
Plug 'rust-lang/rust.vim'
" Mixed set of popular languages
" https://github.com/sheerun/vim-polyglot
Plug 'sheerun/vim-polyglot'

" Language agnostic tools
"
" General purpose, language agnostic linter
" https://github.com/w0rp/ale
Plug 'w0rp/ale'
" Language server
" https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim'
" Surround selection/words with scopes, quotes, parens, etc.
" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'
" Automatically close scopes, quotes, parens, etc.
" https://github.com/jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'

" GIT
"
" GIT history/diff info in column
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'
" GIT integration commands
" https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
" GIT merge tool
" https://github.com/samoshkin/vim-mergetool
Plug 'samoshkin/vim-mergetool'

" Vim utilities
"
" Split or join language specific lines of code
" https://github.com/andrewradev/splitjoin.vim
Plug 'andrewradev/splitjoin.vim'
" Soft delete buffers
" https://github.com/moll/vim-bbye
Plug 'moll/vim-bbye'
" Undo tree navigator
" https://github.com/simnalamburt/vim-mundo
Plug 'simnalamburt/vim-mundo'

" Searching
"
" Search for files
" https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
" Search within files
" https://github.com/dyng/ctrlsf.vim
Plug 'dyng/ctrlsf.vim'
" Fuzzy search within a collection
" https://github.com/junegunn/fzf
Plug 'junegunn/fzf'

" Movement
"
" Matchit improved, moving between open and close of scopes
" https://github.com/andymass/vim-matchup
Plug 'andymass/vim-matchup'
" Motions via cursor text search
" https://github.com/phaazon/hop.nvim
Plug 'phaazon/hop.nvim'

" Status
"
" Airline status bar
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
" Airline status bar themes
" https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'
" Column mark names
" https://github.com/kshenoy/vim-signature
Plug 'kshenoy/vim-signature'

" Appearance
"
" Colour scheme, Vim One
" https://github.com/rakr/vim-one
Plug 'rakr/vim-one'
" Dim inactive panes
" https://github.com/blueyed/vim-diminactive
Plug 'blueyed/vim-diminactive'

" Text manipulation and formatting
"
" Code snippets
" https://github.com/honza/vim-snippets
Plug 'honza/vim-snippets'
" Context specific syntax highlighting
" https://github.com/shougo/context_filetype.vim
Plug 'shougo/context_filetype.vim'
" Comment/uncomment lines
" https://github.com/tomtom/tcomment_vim
Plug 'tomtom/tcomment_vim'


" Services
"
" Kubectl
" https://github.com/rottencandy/vimkubectl
Plug 'rottencandy/vimkubectl'

" Unused
"
" Comment/uncomment lines
" https://github.com/tyru/caw.vim
" Plug 'tyru/caw.vim'
" Vue syntax and indent
" https://github.com/leafoftree/vim-vue-plugin
" Plug 'leafoftree/vim-vue-plugin'
" Move lines up/down/left/right
" https://github.com/matze/vim-move
" Plug 'matze/vim-move'

call plug#end()

for config in g:modules
  exec "so" config
endfor

lua require('hop').setup({
  \ keys = 'asdghjklqweryuiop'
\ })

call SetColours()
