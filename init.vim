" Executes if/else clause for setting defaults on env vars.
" Will probably move this to Lua at some point.
fun! SetDefault(env_name, glob_path)
	let l:var_assignment = 'let g:' . tolower(a:env_name) . ' = '
	let l:if_clause = 'if empty($' . a:env_name . ')'
	let l:then_scope = var_assignment . 'glob("' . a:glob_path . '")'
	let l:else_scope = var_assignment . '$' . a:env_name

	exec l:if_clause . ' | ' . l:then_scope . ' | else | ' . l:else_scope . ' | endif'
endfun

fun! SetWith(set_name, set_value)
  let l:lhs_expr = 'set ' . a:set_name

  exec l:lhs_expr . '=' . a:set_value
endfun

call SetDefault('XDG_CONFIG_HOME', $HOME . '/.config')
call SetDefault('XDG_CACHE_HOME', $HOME . '/.cache')
call SetDefault('NVIM_DIR', g:xdg_config_home . '/nvim')
call SetDefault('NVIM_CACHE_DIR', g:xdg_cache_home . '/nvim')

lua require('init')

for module in glob(g:nvim_dir . '/config/*.vim', 0, 1)
	exec 'so' module
endfor
