" Key
" a - ALT/OPTION
" c - CTRL
" s - SHIFT
" l - LEADER '\'

" General keybinds

" Toggle NERDTree panel
nnoremap <silent> <F12> :NERDTreeToggle<cr>
" Focus opened NERDTree panel
nnoremap <silent> <F11> :NERDTreeFocus<cr>
" Find current directory and focus it
nnoremap <silent> <F1> :NERDTreeFind<cr>C
" Alternative to pressing ESC
inoremap <c-c> <esc>

" Move line up/down
nnoremap <c-\> :m .+1<cr>==
nnoremap <c-]> :m .-2<cr>==
inoremap <c-\> <esc>:m .+1<cr>==gi
inoremap <c-]> <esc>:m .-2<cr>==gi
vnoremap <c-\> :m '>+1<cr>gv=gv
vnoremap <c-]> :m '<-2<cr>gv=gv

" Move pane up/down/left/right
nnoremap <c-k> 10<c-y>
nnoremap <c-j> 10<c-e>
noremap <c-h> 10zh
noremap <c-l> 10zl

" Resize current pane up/down/left/right
nnoremap <s-up> 10<c-w>-
nnoremap <s-down> 10<c-w>+
nnoremap <s-left> 10<c-w><
nnoremap <s-right> 10<c-w>>

" Save vim config
nnoremap <c-s> :w<cr>
inoremap <c-s> <esc>:w<cr>

" Go to component under cursor
nnoremap <silent> <leader>gt :call GoToTag()<cr>
" Format single line tag to multi line tag
nnoremap <silent> <leader>t :call FormatTag()<cr>
" Search globally for tag on line
nnoremap <silent> <leader>s :call SearchTag(0)<cr>
" Search globally for tag in filename
nnoremap <silent> <leader>S :call SearchTag(1)<cr>
" Commit vim config changes to vimrc git respo
nnoremap <silent> <leader>V :call CommitChanges()<cr>
" Open vimrc for edit
nnoremap <silent> <leader>v :call EditVimConf()<cr>
" Set current directory
nnoremap <silent> <leader>c :call ChangeDirectory(0)<cr>
" Write an empty JSON object either above or below depending on location
nnoremap <silent> <leader>J :call WriteEmptyJson()<cr>
" Delete {} block and remove comma if last element in block
nnoremap <silent> <leader>} :call DeleteBlock()<cr>
" Select function
nnoremap <silent> <leader>{ :call SelectBlock()<cr>
" Refresh vim config
nnoremap <silent> <leader>r :call Init(0)<cr>
" Insert two lines above
nnoremap <silent> <leader>o o<esc>o
" Insert two lines below
nnoremap <silent> <leader>O O<esc>O
" Convert current character to lowercase
nnoremap <silent> <leader>u vu
" Conver current character to uppercase
nnoremap <silent> <leader>U vU
" Wipe all buffers
nnoremap <silent> <leader>Q :bufdo bwipe<cr>
" Exit window
nnoremap <silent> <c-q> :call CloseWindow()<cr>
" Clear search
nnoremap <esc> :noh<cr>
" Insert line below without insert mode
nnoremap <cr> o<esc>
" Insert new line above without insert mode
nnoremap <s-enter> O<esc>
" Insert new line above in insert move
inoremap <c-enter> <c-o>O
" Inserts single character
nnoremap <silent> Y :exec "normal i".nr2char(getchar())."\e"<cr>
" Search file for selected string
vnoremap <c-r> <esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>
" Uncomment selected HTML tag
vnoremap <silent> gch :s/<!--\s//ge \| '<,'>s/\s-->//ge<cr>:noh<cr>
" Fold function
nnoremap <c-f>f $v%Vzf
" Fold in visual mode
vnoremap <c-f> zf
" Fold HTML tag
nnoremap <c-f>t ^vatVzf
" Fold self closing HTML tag
nnoremap <c-f>p ^v%Vzf
" Fold all function blocks
nnoremap <c-f>a :call FoldAllBlocks()<cr>
" Previous buffer
nnoremap <c-h> :bp<cr>
" Next buffer
nnoremap <c-l> :bn<cr>
" Delete buffer
nnoremap Q :Bwipe!<cr>
" Scroll up when cursor is moved to the bottom
nnoremap G Gzz
" Clear whitespace
nnoremap ds :%S/\s+$//g<cr>
" Comments out function
nnoremap <silent> gc{ :call SelectBlock() \| call feedkeys("gcc")<cr>
" Centers screen after next search
nnoremap n nzz
" Centers screen after previous search
nnoremap N Nzz
" Center screen after *
nnoremap * *zz
" Creates empty object after key
inoremap <c-d> : {<cr><cr>},<c-c>kS


"Plugins

" COC related keybinds
inoremap <silent> <c-f> <c-r>=coc#start({'source': 'snippets'})<cr>
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <esc> pumvisible() ? "<c-y>" : "<esc>"
inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<c-n>" :
      \ coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetNext',[])\<cr>" :
      \ CheckBackSpace() ? "\<tab>" :
      \ coc#refresh()
inoremap <silent><expr> <s-tab>
    \ pumvisible() ? "\<c-p>" :
    \ coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetPrev',[])\<cr>" :
    \ "\<c-h>"

" Go-to definitions
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

" imap <c-l> <plug>(coc-snippets-expand)
" imap <c-j> <plug>(coc-snippets-expand-jump)
" vmap <c-j> <plug>(coc-snippets-select)

" Open CTRLSF
nmap <leader>f <plug>CtrlSFPrompt""<left>
" Search globally for selected text
vmap <leader>F :call SearchSelection()<cr>
" Open CtrlP Buffer list
nmap <silent> <leader>b :CtrlPBuffer<cr>
nmap <silent> <leader>p :CtrlPLine<cr>

" Downwards eregex
nnoremap <leader>/ :1M/
" Backwards eregex
nnoremap <leader>? :1M?

" Easymotion keybinds
nmap T <plug>(easymotion-F2)
nmap t <plug>(easymotion-f2)
nmap yT <plug>(easymotion-F)
nmap yt <plug>(easymotion-f)
nmap gT <plug>(easymotion-b)
nmap gt <plug>(easymotion-w)
nmap s <plug>(easymotion-overwin-f2)

" Easymotion x/y linewise movement
map <leader>l <plug>(easymotion-lineforward)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
map <leader>h <plug>(easymotion-linebackward)

" Undo
nnoremap <silent> <leader>m :MundoToggle<cr>
nnoremap <silent> <leader>M :wincmd t<cr>
