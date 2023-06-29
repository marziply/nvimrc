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
	au BufEnter,BufReadPost,BufWritePost *.rs,*.ts setl shiftwidth=2
	au BufEnter,BufReadPost,BufWritePost *.env*,*.zsh setl ft=sh
	au BufEnter,BufReadPost,BufWritePost *.capnp setl ft=capnp
	au BufEnter,BufReadPost,BufWritePost *.rasi setl ft=rasi
	au BufEnter,BufReadPost,BufWritePost *.sway setl ft=i3config
	au BufEnter,BufReadPost,BufWritePost *.h setl ft=c
aug end

aug vim_config
	au!
	au BufWritePost */nvim/config/*.vim so <sfile>
aug end

aug diagnostics
  au!
  au CursorHold,CursorHoldI * call Diagnostic()
aug end

aug linters
  au!
  au BufWritePost * FormatWrite
  " au BufWritePost * lua vim.lsp.buf.format()
aug end
