local function map_fn(fn, dir, opts)
	return function()
		local arg = vim.tbl_extend("keep", opts or {}, {
			direction = dir
		})

		return fn(arg)
	end
end

local function map_line(fn, opts)
	local hints = require("hop.hint")
	local dirs = hints.HintDirection
	local before, after = dirs.BEFORE_CURSOR, dirs.AFTER_CURSOR

	return map_fn(fn, before, opts), map_fn(fn, after, opts)
end

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
      local hop = require("hop")
      local maps = require("modules.maps")
			local up_char, down_char = map_line(hop.hint_char2)
			local up_vert, down_vert = map_line(hop.hint_vertical)
			local left_horiz, right_horiz = map_line(hop.hint_words, {
				current_line_only = true
			})

			maps.nmap_with_all {
				["T"] = up_char,
				["t"] = down_char,
				["<c-t>k"] = up_vert,
				["<c-t>j"] = down_vert,
				["<c-t>h"] = left_horiz,
				["<c-t>l"] = right_horiz,
				["s"] = function()
					hop.hint_char2 {
						multi_windows = true
					}
				end
			}
		end
	}
}
