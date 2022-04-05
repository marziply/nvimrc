" Key
" a - ALT/OPTION
" c - CTRL
" s - SHIFT
" l - LEADER '\'

" General

" Alias for escape
inoremap <c-c> <esc>
" Clear search
nnoremap <esc> :noh<cr>
" Rebind vim exit
nnoremap ZZ :qa!<cr>
nnoremap <silent> <c-z> :ccl<cr>
" Save vim config
nnoremap <c-s> :w<cr>
inoremap <c-s> <esc>:w<cr>
" Refresh vim config
nnoremap <silent> <leader>r :call Init(0)<cr>

" Move line up/down
nnoremap <c-pagedown> :m .+1<cr>==
nnoremap <c-pageup> :m .-2<cr>==
inoremap <c-pagedown> <esc>:m .+1<cr>==gi
inoremap <c-pageup> <esc>:m .-2<cr>==gi
vnoremap <c-pagedown> :m '>+1<cr>gv=gv
vnoremap <c-pageup> :m '<-2<cr>gv=gv

" Move pane up/down/left/right
nnoremap <c-k> 10<c-y>
nnoremap <c-j> 10<c-e>
noremap <c-h> 10zh
noremap <c-l> 10zl

" Buffers

" Wipe all buffers
nnoremap <silent> <leader>Q :bufdo :Bdelete!<cr>
" Delete buffer
nnoremap <silent> <c-q> :Bdelete!<cr>:wincmd q<cr>
" Previous buffer
nnoremap <c-h> :bp<cr>
" Next buffer
nnoremap <c-l> :bn<cr>
" Delete buffer
nnoremap <silent> Q :Bdelete!<cr>:silent! bn<cr>

" Searching

" Search in file for visual selection
vnoremap F :Vcp<cr>/<c-r>a<cr>
" Search and replace for selected string
vnoremap <c-r> :call VisualSearch(1)<cr>
" Search for selected string
vnoremap <c-t> :call VisualSearch(2, 'c')<cr>

" Folding

" Folds first matched Open API JSDoc block
nnoremap zfo :call FoldApiBlocks(0)<cr>
" Fold all function blocks
nnoremap <c-f>a :call FoldAllBlocks()<cr>
" Fold in visual mode
vnoremap <c-f>f zf

" Centering

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

" Misc

" Commit vim config changes to vimrc git repo
nnoremap <silent> <leader>cv :call CommitChanges()<cr>
" Open vimrc for edit
nnoremap <silent> <leader>v :call EditVimConf(0)<cr>
" Open vimrc for edit and split
nnoremap <silent> <leader>V :call EditVimConf(1)<cr>
" Insert two lines above
nnoremap <silent> <leader>o o<esc>o
" Insert two lines below
nnoremap <silent> <leader>O O<esc>O
" Inserts single character
nnoremap Y i_<esc>r
" Creates empty object after key
inoremap <c-d> : {<cr><cr>},<c-c>kS
" Increases syntax column length for current buffer
nnoremap <c-f>x :set synmaxcol=5000<cr>
" New line below without insert
nnoremap mo o<esc>
" New line above without insert
nnoremap mO O<esc>
" Select block
vnoremap g{ V$%
" Delete block
vnoremap gd V$%d<bar>:call feedkeys(col('$') == 1 ? 'dd' : '')<cr>
" Toggle relative numbers
nnoremap <silent> - :call ToggleRelative()<cr>
" Toggle relative number in visual select
vnoremap <silent> - <esc>:call ToggleRelative()<cr>gv

" Plugins

" COC related keybinds
inoremap <silent> <c-f> <c-r>=coc#start({ 'source': 'snippets' })<cr>
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <esc> pumvisible() ? "<c-y>" : "<esc>"
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : CheckJumpable('CheckDel')
inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : CheckJumpable("\<c-h>")

" Search globally by input text
nnoremap <leader>f :silent! exec 'CtrlSF "' . input('search: ') . '"'<cr>
" Search globally for selected text
vnoremap <leader>F :Vcp<cr>:CtrlSF "<c-r>a"<cr>
" Open CtrlP buffer list
nnoremap <silent> <leader>b :CtrlPBuffer<cr>

" Easymotion keybinds
nmap T <plug>(easymotion-F2)
nmap t <plug>(easymotion-f2)
nmap gT <plug>(easymotion-b)
nmap gt <plug>(easymotion-w)
nmap s <plug>(easymotion-overwin-f2)

" Easymotion x/y linewise movement
nmap <leader>l <plug>(easymotion-lineforward)
nmap <leader>j <plug>(easymotion-j)
nmap <leader>k <plug>(easymotion-k)
nmap <leader>h <plug>(easymotion-linebackward)

" Undo
nnoremap <silent> <leader>m :MundoToggle<cr>

" Unused

" Formats a selected JSON object
" vnoremap <c-f>j :call ShellOutput('jq .')<bar>call feedkeys('kJ')<cr>

" nnoremap <silent> gd <plug>(coc-definition)
" nnoremap <silent> gy <plug>(coc-type-definition)
" nnoremap <silent> gi <plug>(coc-implementation)
" nnoremap <silent> gr <plug>(coc-references)

" nnoremap <silent> gl :Git mergetool<cr>
" nnoremap <silent> gv :Gvdiffsplit!<cr>zt
" nnoremap <silent> gn :cn<cr>zt
" nnoremap <silent> gp :cp<cr>zt
" nnoremap <silent> go :ccl<cr>zz
" nnoremap <silent> gw :w<cr>:Gw<cr>:normal go<cr>
" nnoremap <silent> gdh :diffget //2<cr>
" nnoremap <silent> gdl :diffget //3<cr>
" nnoremap <silent> gfl :normal gdh<cr>:normal gn<cr>
" nnoremap <silent> gfh :normal gdl<cr>:normal gn<cr>
