" Executes if/else clause for setting defaults on env vars.
" Will probably move this to Lua at some point.
fun! SetDefault(env_name, default_value)
  let l:var_name = tolower(a:env_name)
	let l:var_assignment = 'let g:' . l:var_name . ' = '
	let l:if_clause = 'if empty($' . a:env_name . ')'
	let l:then_scope = var_assignment . 'glob("' . a:default_value . '")'
  let l:else_scope_1 = var_assignment . '$' . a:env_name
  let l:else_scope_2 = 'let $' . a:env_name . ' = g:' . l:var_name
  let l:else_scope = l:else_scope_1 . ' | ' . l:else_scope_2

	exec l:if_clause . ' | ' . l:then_scope . ' | else | ' . l:else_scope . ' | endif'
endfun

call SetDefault('XDG_CONFIG_HOME', $HOME . '/.config')
call SetDefault('XDG_CACHE_HOME', $HOME . '/.cache')
call SetDefault('NVIM_DIR', g:xdg_config_home . '/nvim')
call SetDefault('NVIM_CACHE_DIR', g:xdg_cache_home . '/nvim')

lua require('init')

for module in glob(g:nvim_dir . '/config/*.vim', 0, 1)
	exec 'so' module
endfor
