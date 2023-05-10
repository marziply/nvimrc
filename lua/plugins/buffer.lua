return {
	{
		"romgrk/barbar.nvim",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = false,
			no_name_title = "*",
			icons = {
				button = false,
				filetype = {
					enabled = false
				}
			}
		},
		dependencies = {
			{
				"lewis6991/gitsigns.nvim",
				opts = {
					signs = {
						delete = {
							hl = "GitSignsDelete",
							numhl = "GitSignsDeleteNr",
							linehl = "GitSignsDeleteLn",
							text = "ᐯ"
						},
						topdelete = {
							hl = "GitSignsDelete",
							numhl = "GitSignsDeleteNr",
							linehl = "GitSignsDeleteLn",
							text = "ᐱ"
						}
					}
				}
			}
		}
	}
}
