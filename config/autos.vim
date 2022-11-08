augroup general
  autocmd!
  autocmd BufNewFile * startinsert
augroup end

augroup filetypes
	autocmd!
	autocmd BufEnter,BufReadPost *.{njk,tera}.html,*.html.tera set ft=htmldjango
	autocmd BufEnter,BufReadPost *.sway set ft=i3config
	autocmd BufEnter,BufReadPost *.env* set ft=sh
	autocmd BufEnter,BufReadPost *.rs set shiftwidth=2
augroup end

" augroup linters
"   autocmd!
"   autocmd BufWritePost * lua vim.lsp.buf.format()
"   autocmd BufWritePost * FormatWrite
" augroup end

augroup vim_config
	autocmd!
	autocmd BufWritePost */nvim/config/*.vim lua src('init.vim')
augroup end

augroup packer_config
	autocmd!
	autocmd BufWritePost *.lua so % | PackerCompile
augroup end

" augroup packer_hooks
" 	autocmd!
" 	autocmd User PackerComplete lua src('lua/options.lua')
" augroup end
