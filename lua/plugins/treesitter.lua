return {
	{
		"nvim-treesitter/nvim-treesitter",
		main = "nvim-treesitter.configs",
		opts = {
			auto_install = true,
			ensure_installed = {
				"lua",
				"javascript",
				"tsx",
				"json",
				"html",
				"css",
				"scss",
				"sql",
				"go",
				"rust",
				"c",
			},
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
				},
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
}
