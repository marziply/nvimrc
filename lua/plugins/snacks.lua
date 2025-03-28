return {
	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			styles = {
				notification = {
					wo = {
						wrap = true,
					},
				},
			},
			animate = {
				enabled = true,
			},
			bufdelete = {
				enabled = false,
			},
			dashboard = {
				enabled = true,
			},
			debug = {
				enabled = true,
			},
			git = {
				enabled = true,
			},
			indent = {
				enabled = true,
				animate = {
					enabled = false,
				},
			},
			notify = {
				enabled = true,
			},
			notifier = {
				enabled = true,
				timeout = 5000,
				top_down = false,
				width = {
					min = 40,
					max = 0.3,
				},
			},
			picker = {
				enabled = true,
			},
			scope = {
				enabled = true,
			},
			statuscolumn = {
				enabled = true,
			},
			terminal = {
				enabled = true,
			},
			words = {
				enabled = true,
			},
			win = {
				enabled = true,
			},
		},
	},
}
