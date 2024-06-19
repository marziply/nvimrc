return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local telescope = require("telescope")
			local undo_actions = require("telescope-undo.actions")
			-- local default_actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<c-j>"] = function()
								vim.api.nvim_input("<cr>")
							end,
							-- ["<c-p"] = function()
							-- 	default_actions.move_selection_previous()
							-- end,
							-- ["<c-n"] = function()
							-- 	default_actions.move_selection_next()
							-- end,
						},
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
