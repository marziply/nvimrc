let g:block_reg = '^\s*\(\(\(get\|set\|\(\(async\s\+\)*function\)\)\s\+\)*\)[0-9A-Za-z_]\+\s*([0-9A-Za-z_ \t,.{}\[\]]*)\s*{$'

let test#strategy = "dispatch"
let test#javascript#jest#file_pattern = '\.spec\.js'
let test#javascript#runner = "jest"
let test#runner_commands = ["jest"]
" let test#enabled_runners = ['javascript#jest']
" let g:vim_vue_plugin_use_foldexpr = 1

let mapleader = "\<space>"
let g:eighties_compute = 0
let g:eighties_minimum_width = 100
let g:polyglot_disabled = ['vue']
let g:one_allow_italics = 1
let g:gotofile_extensions = ['js', 'vue']
let g:javascript_plugin_jsdoc = 1
let g:eregex_default_enable = 0
let g:mundo_close_on_revert = 1
let g:mundo_verbose_graph = 0
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
let g:EasyMotion_startofline = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_prompt = '[{n}] >>> '
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_by_filename = 1
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_mruf_max = 20
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlsf_context = '-C 10'
let g:ctrlsf_ignore_dir = ['node_modules', 'docs', 'vendor', 'public', 'coverage']
let g:ctrlsf_auto_focus = { 'at': 'start' }
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_close = { 'normal': 1, 'compact': 1 }
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '50%'
let g:airline_theme = 'tomorrow'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_highlighting_cache = 1
let g:vim_vue_plugin_use_sass = 1
let g:vim_vue_plugin_highlight_vue_attr = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \ 'vue': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': ['eslint']
\}
let g:ale_linters = {
  \ 'vue': ['eslint', 'vls'],
  \ 'javascript': ['eslint']
\}
let g:ale_linter_aliases = {
  \ 'vue': ['javascript', 'html', 'scss']
\}
