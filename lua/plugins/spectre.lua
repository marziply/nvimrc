return {
	{
		"nvim-pack/nvim-spectre",
		opts = {
			open_cmd = "noswapfile enew",
			color_devicons = false,
			find_engine = {
				rg = {
					cmd = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
				},
			},
			replace_engine = {
				sd = {
					cmd = "sd",
				},
			},
			default = {
				find = {
					cmd = "rg",
				},
				replace = {
					cmd = "sd",
				},
			},
		},
		dependencies = {
			{
				"nvim-lua/plenary.nvim",
			},
		},
	},
}
