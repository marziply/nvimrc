local fn = vim.fn
local data_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(data_dir)) > 0 then
	fn.system {
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		data_dir
	}

	vim.cmd [[packadd packer.nvim]]
end

vim.diagnostic.config {
  update_in_insert = true
}

vim.g.markdown_fenced_languages = {
  'ft=typescript'
}

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		client.server_capabilities.semanticTokensProvider = nil
	end
})
