augroup vim_config
	autocmd!
	autocmd BufWritePost */nvim/config/*.vim lua src('init.vim')
augroup end

augroup packer_config
	autocmd!
	autocmd BufWritePost *.lua so % | PackerCompile
augroup end

augroup packer_hooks
	autocmd!
	autocmd User PackerComplete lua src('lua/options.lua')
augroup end
