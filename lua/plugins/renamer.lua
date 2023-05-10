return {
	{
		"filipdutescu/renamer.nvim",
		opts = {
			empty = true,
			mappings = {
				["<c-c>"] = function()
					vim.api.nvim_input("<esc>")
				end
			}
		}
	}
}
