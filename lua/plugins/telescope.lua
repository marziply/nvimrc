return {
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				mappings = {
					i = {
						["<c-j>"] = function()
							vim.api.nvim_input("<cr>")
						end
					}
				}
			}
		},
		dependencies = {
			"nvim-lua/plenary.nvim"
		}
	}
}
