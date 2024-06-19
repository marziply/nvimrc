return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			presets = {
				command_palette = true,
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
			},
			views = {
				cmdline_popup = {
					position = {
						row = 20,
					},
					size = {
						width = 80,
					},
				},
				cmdline_popupmenu = {
					position = {
						row = 23,
					},
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
