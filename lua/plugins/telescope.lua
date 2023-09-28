return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope-undo.actions")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<c-j>"] = function()
								vim.api.nvim_input("<cr>")
							end,
						},
					},
				},
				extensions = {
					undo = {
						mappings = {
							i = {
								["<c-j>"] = actions.restore,
							},
						},
					},
				},
			})
			telescope.load_extension("undo")
			telescope.load_extension("neoclip")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			"AckslD/nvim-neoclip.lua",
		},
	},
}
