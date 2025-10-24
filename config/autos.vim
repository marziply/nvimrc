fun! Diagnostic()
  lua vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
endfun

aug ft
	au!
	" au BufEnter,BufReadPost,BufWritePost *.sql setl ft=pgsql
	au BufEnter,BufReadPost,BufWritePost *.dockerfile setl ft=dockerfile
	au BufEnter,BufReadPost,BufWritePost *.env*,*.zsh setl ft=sh
	au BufEnter,BufReadPost,BufWritePost *.capnp setl ft=capnp
	au BufEnter,BufReadPost,BufWritePost *.rasi setl ft=rasi
	au BufEnter,BufReadPost,BufWritePost *.sway setl ft=i3config
	au BufEnter,BufReadPost,BufWritePost *.tmpl.* setl ft=gotmpl
	au BufEnter,BufReadPost,BufWritePost *.h setl ft=c
	au
    \ BufEnter,BufReadPost,BufWritePost
    \ *.{njk,tera}.html,*.html.tera,*.askama
    \ setl ft=htmldjango
	au
    \ BufEnter,BufReadPost,BufWritePost
    \ *.tf*,*.env*,*.md,*.json,*.yaml
    \ setl nowrap
	au 
    \ BufEnter,BufReadPost,BufWritePost
    \ *.tfvars,*.env*,*.md,*.json,*.yaml,*.rs,*.ts
    \ setl shiftwidth=2
aug end

aug config
	au!
	au BufWritePost **/nvim/init.vim so <afile>
	au BufWritePost **/nvim/config/*.vim so <afile>
	au BufWritePost **/nvim/lua/plugins/init.lua so <afile>
	au BufWritePost **/nvim/lua/modules/*.lua so <afile>
aug end

aug diag
  au!
  au CursorHold,CursorHoldI * call Diagnostic()
aug end

aug quickfix
  au!
  au FileType qf nnoremap <buffer> <cr> <cr>:cclose<cr>
aug end
