-- autocmd BufWritePost lua/**/*.lua source $NVIM_DIR/init.lua | PackerCompile
-- autocmd BufWritePost plugins.lua so % | PackerSync

vim.cmd [[
	augroup packer_config
		autocmd!
		autocmd BufWritePost *.lua so % | PackerCompile
	augroup end
]]
