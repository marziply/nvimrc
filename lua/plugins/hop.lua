return {
	{
		-- "phaazon/hop.nvim",
		-- branch = 'v2',
		"aznhe21/hop.nvim",
		branch = "fix-some-bugs",
		opts = {
			jump_on_sole_occurence = true,
			uppercase_labels = true
		},
		init = function()
      local maps = require("modules.maps")
      local hop = require("hop")
			local hints = require("hop.hint")
			local dirs = hints.HintDirection

			maps.nmap_with_all {
				["T"] = function()
					hop.hint_char2 {
						direction = dirs.BEFORE_CURSOR
					}
				end,
				["t"] = function()
					hop.hint_char2 {
						direction = dirs.AFTER_CURSOR
					}
				end,
				["s"] = function()
					hop.hint_char2 {
						multi_windows = true
					}
				end,
				["<c-t>k"] = function()
					hop.hint_vertical {
						direction = dirs.BEFORE_CURSOR
					}
				end,
				["<c-t>j"] = function()
					hop.hint_vertical {
						direction = dirs.AFTER_CURSOR
					}
				end,
				["<c-t>h"] = function()
					hop.hint_words {
						direction = dirs.BEFORE_CURSOR,
						current_line_only = true
					}
				end,
				["<c-t>l"] = function()
					hop.hint_words {
						direction = dirs.AFTER_CURSOR,
						current_line_only = true
					}
				end
			}
		end
	}
}
