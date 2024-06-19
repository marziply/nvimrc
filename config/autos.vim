fun! Diagnostic()
  lua vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
endfun

aug general
  au!
  au BufNewFile * startinsert
aug end

aug filetypes
	au!
	au BufEnter,BufReadPost,BufWritePost *.{njk,tera}.html,*.html.tera setl ft=htmldjango
	au BufEnter,BufReadPost,BufWritePost *.dockerfile setl ft=dockerfile
	au BufEnter,BufReadPost,BufWritePost *.rs,*.ts setl shiftwidth=2
	au BufEnter,BufReadPost,BufWritePost *.env*,*.zsh setl ft=sh
	au BufEnter,BufReadPost,BufWritePost *.capnp setl ft=capnp
	au BufEnter,BufReadPost,BufWritePost *.rasi setl ft=rasi
	au BufEnter,BufReadPost,BufWritePost *.sway setl ft=i3config
	au BufEnter,BufReadPost,BufWritePost *.sql setl ft=pgsql
	au BufEnter,BufReadPost,BufWritePost *.tmpl.* setl ft=gotmpl
	au BufEnter,BufReadPost,BufWritePost *.h setl ft=c
	au BufEnter,BufReadPost,BufWritePost *.tfvars,*.env*,*.md,*.json,*.yaml setl nowrap
	au BufEnter,BufReadPost,BufWritePost *.tfvars,*.env*,*.md,*.json,*.yaml setl shiftwidth=2
	au BufEnter,BufReadPost,BufWritePost *.tm.hcl call system("terramate generate")
	au BufEnter,BufReadPost,BufWritePost Earthfile setl ft=Earthfile
aug end

aug vim_config
	au!
	au BufWritePost */nvim/config/*.vim so <sfile>
	" au BufWritePost */nvim/lua/plugins/init.lua so <sfile>
	" au BufWritePost */nvim/lua/plugins/*.lua exec printf(
	" 	\ "Lazy reload %s",
	" 	\	expand("<sfile>:t:r")
	" \)
aug end

aug diagnostics
  au!
  au CursorHold,CursorHoldI * call Diagnostic()
aug end
