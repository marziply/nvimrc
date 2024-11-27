return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local telescope = require("telescope")
			local undo_actions = require("telescope-undo.actions")

			telescope.setup({
				defaults = {
					layout_config = {
						horizontal = {
							width = 0.6,
							height = 0.7,
							preview_width = 80,
						},
						small = {
							width = 0.1,
						},
					},
					mappings = {
						i = {
							["<c-j>"] = function()
								vim.api.nvim_input("<cr>")
							end,
						},
					},
				},
				pickers = {
					live_grep = {
						theme = "dropdown",
					},
					command_history = {
						theme = "dropdown",
					},
					search_history = {
						theme = "dropdown",
						layout_strategy = "small",
					},
					spell_suggest = {
						theme = "cursor",
						layout_strategy = "small",
					},
					quickfix = {
						theme = "dropdown",
					},
					registers = {
						theme = "dropdown",
					},
				},
				extensions = {
					undo = {
						mappings = {
							i = {
								["<c-j>"] = undo_actions.restore,
							},
						},
					},
				},
			})

			telescope.load_extension("undo")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
	},
}
