augroup general
  autocmd!
  autocmd BufNewFile * startinsert
augroup end

augroup filetypes
	autocmd!
	autocmd BufEnter,BufReadPost *.{njk,tera}.html,*.html.tera setl ft=htmldjango
	autocmd BufEnter,BufReadPost *.sway setl ft=i3config
	autocmd BufEnter,BufReadPost *.env* setl ft=sh
	autocmd BufEnter,BufReadPost *.rs setl shiftwidth=2
	autocmd BufEnter,BufReadPost *.ts setl shiftwidth=4
augroup end

augroup vim_config
	autocmd!
	autocmd BufWritePost */nvim/config/*.vim lua src('init.vim')
augroup end

augroup packer_config
	autocmd!
	autocmd BufWritePost */nvim/*.lua so % | PackerCompile
augroup end

augroup linters
  autocmd!
  " autocmd BufWritePost * lua vim.lsp.buf.format()
  autocmd BufWritePost * FormatWrite
augroup end
