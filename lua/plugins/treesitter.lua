local targets = {
	"lua",
	"javascript",
	"tsx",
	"json",
	"yaml",
	"html",
	"css",
	"scss",
	"sql",
	"go",
	"rust",
	"c",
	"toml",
	"bash",
	"git_config",
	"just",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		main = "nvim-treesitter",
		init = function()
			local ts = require("nvim-treesitter")
			local config = require("nvim-treesitter.config")

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)

					vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
				end,
			})

			local installed = config.get_installed()
			local parsers = vim.iter(targets)
				:filter(function(parser)
					return not vim.tbl_contains(installed, parser)
				end)
				:totable()

			ts.install(parsers)
		end,
		opts = {
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
				},
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				branch = "main",
			},
		},
	},
}
