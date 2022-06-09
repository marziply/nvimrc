" 0

let mapleader = "\<space>"

let s:fn_reg = '\(\(\(get\|set\|\(\(async\s\+\)*function\)\)\s\+\)*\)'
let s:body_reg = '([0-9A-Za-z_ \t,.{}\[\]]*)\s*{'

let g:ignore_dirs = [
  \ '.git',
  \ '.git-crypt',
  \ 'node_modules',
  \ 'vendor',
  \ 'public',
  \ 'coverage',
  \ 'tmp',
  \ 'build',
  \ 'target'
\]
let g:block_reg = '^\s*' . s:fn_reg . '[0-9A-Za-z_]\+\s*' . s:body_reg . '$'
let g:wild_ignore_dirs = map(g:ignore_dirs, '"*/" . v:val . "/*"')

" Gutter for git
" https://github.com/airblade/vim-gitgutter
let g:gitgutter_map_keys = 0

" Matchup
" https://github.com/andymass/vim-matchup
let g:matchup_matchparen_offscreen = {
  \ 'method': 'popup'
\}

" One colour scheme
" https://github.com/rakr/vim-one
let g:one_allow_italics = 1

" JavaScript
" https://github.com/pangloss/vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_sql_dialect = 'pgsql'

" Mundo
" https://github.com/simnalamburt/vim-mundo
let g:mundo_close_on_revert = 1
let g:mundo_verbose_graph = 0

" COC
" https://github.com/neoclide/coc.nvim
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

" Signature
" https://github.com/kshenoy/vim-signature
let g:SignatureMarkTextHLDynamic = 1

" CtrlP
" https://github.com/ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_by_filename = 1
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_mruf_max = 20
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_working_path_mode = 0

" CtrlSF
" https://github.com/dyng/ctrlsf.vim
let g:ctrlsf_context = '-C 10'
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '50%'
let g:ctrlsf_mapping = {
  \ 'split': '',
  \ 'vsplit': '<c-o>'
\}
let g:ctrlsf_auto_focus = {
  \ 'at': 'start'
\}
let g:ctrlsf_auto_close = {
  \ 'normal': 1,
  \ 'compact': 1
\}

" Airline
" https://github.com/vim-airline/vim-airline
let g:airline_theme = 'tomorrow'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_highlighting_cache = 1

" ALE
" https://github.com/w0rp/ale
let g:ale_ft_opts = {
  \ 'vue': [
    \ 'eslint',
    \ 'vls'
  \ ],
  \ 'javascript': [
    \ 'eslint'
  \ ],
  \ 'css': [
    \ 'prettier'
  \ ],
  \ 'c': [
    \ 'uncrustify'
  \ ],
  \ 'h': [
    \ 'uncrustify'
  \ ],
  \ 'cpp': [
    \ 'uncrustify'
  \ ],
  \ 'hpp': [
    \ 'uncrustify'
  \ ],
  \ 'go': [
    \ 'gofmt',
    \ 'goimports'
  \ ],
  \ 'rs': [
    \ 'rust-analyzer',
  \ ],
\}
let g:ale_linter_aliases = {
  \ 'vue': [
    \ 'javascript',
    \ 'html',
    \ 'scss'
  \]
\}
let g:ale_fixers = g:ale_ft_opts
let g:ale_linters = g:ale_ft_opts
let g:ale_lint_on_text_changed = 'normal'
let g:ale_c_uncrustify_options = '-c format.cfg'
let g:ale_sign_column_always = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
