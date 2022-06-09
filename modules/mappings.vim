" 2
" General
"
" Alias for escape
inoremap <c-c> <esc>
" Clear search
nnoremap <esc> :noh<cr>
" Rebind vim exit
nnoremap ZZ :qa!<cr>
" Close quickfix window
nnoremap <silent> <c-z> :ccl<cr>
" Save vim config
nnoremap <c-s> :w<cr>
" Save vim config
inoremap <c-s> <esc>:w<cr>

" Movement
"
" Move pane up
nnoremap <c-k> 10<c-y>
" Move pane down
nnoremap <c-j> 10<c-e>
" Centers screen after next search
nnoremap n nzz
" Centers screen after previous search
nnoremap N Nzz
" Center screen after *
nnoremap * *zz
" Remaps up to center screen when moving
nnoremap H Hzz
" Remaps down to center screen when moving
nnoremap L Lzz
" Scroll up when cursor is moved to the bottom
nnoremap G Gzz
" Centers screen after going 'back'
nnoremap <c-o> <c-o>zz
" Centers screen after going 'forward'
nnoremap <c-i> <c-i>zz

" Appearance
"
" Toggle relative numbers
nnoremap <silent> - :call ToggleRelative()<cr>
" Toggle relative number in visual select
vnoremap <silent> - <esc>:call ToggleRelative()<cr>gv

" Text
"
" Move current line up by one
nnoremap gu :m .-2<cr>==
" Move current line down by one
nnoremap gd :m .+1<cr>==
" Move current line up by one
vnoremap gu :m '<-2<cr>gv=gv
" Move current line down by one
vnoremap gd :m '>+1<cr>gv=gv
" Move current line up by one
inoremap <c-g>u <esc>:m .-2<cr>==gi
" Move current line down by one
inoremap <c-g>d <esc>:m .+1<cr>==gi
" New line below without insert
nnoremap mo o<esc>
" New line above without insert
nnoremap mO O<esc>
" Select block
vnoremap g{ V$%
" Delete block
vnoremap gd V$%d<bar>:call feedkeys(col('$') == 1 ? 'dd' : '')<cr>
" Insert two lines above
nnoremap <silent> <leader>o o<esc>o
" Insert two lines below
nnoremap <silent> <leader>O O<esc>O
" Inserts single character
nnoremap Y i_<esc>r
" Formats a selected JSON object
vnoremap <c-f>j :Vcp<cr>:call FormatJSON()<cr>

" Buffers
"
" Wipe all buffers
nnoremap <silent> <leader>Q :bufdo :bd<cr>:Bdelete!<cr>
" Delete buffer
nnoremap <silent> Q :Bdelete!<cr>:silent! bn<cr>
" Delete buffer
nnoremap <silent> <c-q> :Bdelete!<cr>:wincmd q<cr>
" Previous buffer
nnoremap <c-h> :bp<cr>
" Next buffer
nnoremap <c-l> :bn<cr>

" Searching
"
" Search in file for visual selection
vnoremap F :Vcp<cr>/<c-r>a<cr>
" Search and replace for selected string
vnoremap <c-r> :call VisualSearch(1)<cr>
" Search for selected string
vnoremap <c-t> :call VisualSearch(2, 'c')<cr>

" Folding
"
" Folds first matched Open API JSDoc block
nnoremap zfo :call FoldApiBlocks(0)<cr>
" Fold all function blocks
nnoremap <c-f>a :call FoldAllBlocks()<cr>
" Fold in visual mode
vnoremap <c-f>f zf

" Misc
"
" Commit vim config changes to vimrc git repo
nnoremap <silent> <leader>cv :call CommitAndPush()<cr>
" Open vimrc for edit
nnoremap <silent> <leader>v :call ConfigureNvim()<cr>
" Open vimrc for edit and split
nnoremap <silent> <leader>V :vs <bar> call ConfigureNvim()<cr>
" Open vimrc for edit
nnoremap <silent> <leader>z :call ConfigureZsh()<cr>
" Open vimrc for edit and split
nnoremap <silent> <leader>Z :vs <bar> call ConfigureZsh()<cr>
" Copies the path to the current buffer
nnoremap <silent> <c-g>y :let @+=expand("%") <bar> echo "yanked path"<cr>
" Sets the filetype of the current buffer
nnoremap <c-f>t :exec 'setf ' . input('ft: ')<cr>
" Increases syntax column length for current buffer
nnoremap <c-f>x :set synmaxcol=5000<cr>

" COC
"
" Search by snippets
inoremap <silent> <c-f> <c-r>=coc#start({ 'source': 'snippets' })<cr>
" Pastes the selected text from the autocomplete list
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
" Pastes the selected text from the autocomplete list
inoremap <expr> <esc> pumvisible() ? "\<c-y>" : "\<esc>"
" Move down a row in the autocomplete list
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : HandleWhitespace()
" Move up a row in the autocomplete list
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"
" Find implementation of word, beginning at cursor
nnoremap <silent> gi <plug>(coc-implementation)
" Find references of word, beginning at cursor
nnoremap <silent> gr <plug>(coc-references)

" CtrlSF
"
" Search globally by input text
nnoremap <leader>f :silent! exec 'CtrlSF "' . input('search: ') . '"'<cr>
" Search globally for selected text
vnoremap <leader>F :Vcp<cr>:CtrlSF "<c-r>a"<cr>

" CtrlP
"
" Open CtrlP buffer list
nnoremap <silent> <leader>b :CtrlPBuffer<cr>

" Hop
"
" Hop upwards, search two characters
nnoremap <silent> T :HopChar2BC<cr>
" Hop downwards, search two characters
nnoremap <silent> t :HopChar2AC<cr>
" Hop upwards, each word by it's first character
nnoremap <silent> gT :HopWordBC<cr>
" Hop downwards, each word by it's first character
nnoremap <silent> gt :HopWordAC<cr>
" Hop anywhere, on any window, search two characters
nnoremap <silent> s :HopChar2MW<cr>
" Hop upwards, beginning of each line
nnoremap <silent> <leader>k :HopLineStartBC<cr>
" Hop downwards, beginning of each line
nnoremap <silent> <leader>j :HopLineStartAC<cr>
" Hop leftwards, beginning of each word
nnoremap <silent> <leader>h :HopWordCurrentLineBC<cr>
" Hop righwards, beginning of each word
nnoremap <silent> <leader>l :HopWordCurrentLineAC<cr>

" Undo tree
"
" Toggle Mundo tree pane on the left
nnoremap <silent> <leader>m :MundoToggle<cr>

" Unused
"
" Formats a selected JSON object (legacy)
" vnoremap <c-f>j :call ShellOutput('jq .')<bar>call feedkeys('kJ')<cr>
" Refresh vim config
" nnoremap <silent> <leader>r :call Init(0)<cr>
" Find method or symbol definition of word, beginning at cursor
" nnoremap <silent> gd <plug>(coc-definition)
" Find type definition of word, beginning at cursor
" nnoremap <silent> gy <plug>(coc-type-definition)
" Start git merge tool
" nnoremap <silent> gml :Git mergetool<cr>
" Start git diff in a vertical split
" nnoremap <silent> gmv :Gvdiffsplit!<cr>zt
" Next option in quickfix window
" nnoremap <silent> gmn :cn<cr>zt
" Previous option in quickfix window
" nnoremap <silent> gmp :cp<cr>zt
" Save and commit diff, then close quickfix window
" nnoremap <silent> gmw :w<cr>:Gw<cr>:ccl<cr>
" Move left one window when diffing
" nnoremap <silent> gmH :diffget //2<cr>
" Move right one window when diffing
" nnoremap <silent> gmL :diffget //3<cr>
