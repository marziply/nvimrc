return {
	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				progress = {
					enabled = false,
				},
			},
			presets = {
				command_palette = true,
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
			},
			cmdline = {
				format = {
					search_down = {
						view = "cmdline",
					},
					search_up = {
						view = "cmdline",
					},
				},
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
		},
	},
}
