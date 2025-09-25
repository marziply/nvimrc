local function map_fn(fn, dir, opts)
	return function()
		local arg = vim.tbl_extend("keep", opts or {}, {
			direction = dir,
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
		"smoka7/hop.nvim",
		opts = {
			jump_on_sole_occurence = true,
			uppercase_labels = true,
		},
		init = function()
			local hop = require("hop")
			local maps = require("modules.maps")
			local up_char, down_char = map_line(hop.hint_char2)
			local up_v, down_v = map_line(hop.hint_vertical)
			local left_h, right_h = map_line(hop.hint_words, {
				current_line_only = true,
			})

			maps.nmap_all({
				["T"] = up_char,
				["t"] = down_char,
				["<c-h>u"] = up_char,
				["<c-h>d"] = down_char,
				["<c-h>k"] = up_v,
				["<c-h>j"] = down_v,
				["<c-h>h"] = left_h,
				["<c-h>l"] = right_h,
				["s"] = function()
					hop.hint_char2({
						multi_windows = true,
					})
				end,
			})
		end,
	},
}
