return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			exclude = {
				filetypes = {
					"dashboard",
					"help",
					"lspinfo",
					"checkhealth",
					"man",
					"packer",
				},
			},
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},
}
