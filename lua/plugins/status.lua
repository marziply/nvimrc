return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				refresh = {
					statusline = 250,
					tabline = 250,
					winbar = 250
				}
			},
			sections = {
				lualine_b = {
					"branch",
					"diff"
				},
				lualine_c = {
					{
						"filename",
						path = 1
					}
				},
				lualine_x = {
					"filetype"
				},
				lualine_y = {
					"diagnostics",
				},
				lualine_z = {
					"location"
				}
			},
			inactive_sections = {
				lualine_c = {
					{
						"filename",
						path = 1
					}
				},
				lualine_x = {
					"diagnostics"
				}
			}
		}
	}
}
