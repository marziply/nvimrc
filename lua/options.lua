vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cmdheight = 2
vim.opt.bg = 'dark'
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.completeopt = 'menu,menuone,noselect'

vim.cmd.colorscheme('onedark')
vim.cmd.syn('on')

vim.api.nvim_set_var('coq_settings', {
	auto_start = 'shut-up',
	clients = {
		snippets = {
			warn = {}
		}
	}
})
