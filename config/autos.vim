fun! Diagnostic()
  lua << EOF
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
      -- severity = vim.diagnostic.severity.ERROR
    })
EOF
endfun

aug general
  au!
  au BufNewFile * startinsert
aug end

aug filetypes
	au!
	au BufEnter,BufReadPost,BufWritePost *.{njk,tera}.html,*.html.tera setl ft=htmldjango
	au BufEnter,BufReadPost,BufWritePost *.capnp setl ft=capnp
	au BufEnter,BufReadPost,BufWritePost *.sway setl ft=i3config
	au BufEnter,BufReadPost,BufWritePost *.env* setl ft=sh
	au BufEnter,BufReadPost,BufWritePost *.h setl ft=c
	au BufEnter,BufReadPost,BufWritePost *.rs setl shiftwidth=2
	" au BufEnter,BufReadPost,BufWritePost *.ts setl shiftwidth=4
aug end

aug vim_config
	au!
	au BufWritePost */nvim/config/*.vim lua src('init.vim')
aug end

aug packer_config
	au!
	au BufWritePost */nvim/*.lua so % | PackerCompile
aug end

aug cargo_config
	au!
	au BufWritePost Cargo.toml LspRestart
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
