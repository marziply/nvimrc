fun! Diagnostic()
  lua vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
endfun

aug general
  au!
  au BufNewFile * startinsert
aug end

aug filetypes
	au!
	" au BufEnter,BufReadPost,BufWritePost *.sql setl ft=pgsql
	au BufEnter,BufReadPost,BufWritePost *.dockerfile setl ft=dockerfile
	au BufEnter,BufReadPost,BufWritePost *.env*,*.zsh setl ft=sh
	au BufEnter,BufReadPost,BufWritePost *.capnp setl ft=capnp
	au BufEnter,BufReadPost,BufWritePost *.rasi setl ft=rasi
	au BufEnter,BufReadPost,BufWritePost *.sway setl ft=i3config
	au BufEnter,BufReadPost,BufWritePost *.tmpl.* setl ft=gotmpl
	au BufEnter,BufReadPost,BufWritePost *.h setl ft=c
	au BufEnter,BufReadPost,BufWritePost Earthfile setl ft=Earthfile
	au
    \ BufEnter,BufReadPost,BufWritePost
    \ *.{njk,tera}.html,*.html.tera
    \ setl ft=htmldjango
	au
    \ 
    \ BufEnter,BufReadPost,BufWritePost
    \ *.tfvars,*.env*,*.md,*.json,*.yaml
    \ setl nowrap
	au 
    \ BufEnter,BufReadPost,BufWritePost
    \ *.tfvars,*.env*,*.md,*.json,*.yaml,*.rs,*.ts
    \ setl shiftwidth=2
aug end

aug vim_config
	au!
	au BufWritePost **/nvim/init*.vim so <afile>
	au BufWritePost **/nvim/config/*.vim so <afile>
	au BufWritePost **/nvim/lua/plugins/init.lua so <afile>
	au BufWritePost **/nvim/lua/modules/*.lua so <afile>
  " au
  "    \ BufWritePost
  "    \ */nvim/lua/plugins/*.lua
  "    \ exec printf("Lazy reload '%s'", expand("<afile>:t:r")) |
  "    \ exec printf("Reloaded %s", expand("<afile>:t:r"))
aug end

aug diagnostics
  au!
  au CursorHold,CursorHoldI * call Diagnostic()
aug end
