return {
	{
		"nvim-pack/nvim-spectre",
		opts = {
			color_devicons = false,
			replace_engine = {
				sd = {
					cmd = "sd",
				},
			},
			default = {
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
