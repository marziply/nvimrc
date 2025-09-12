return {
	{
		"navarasu/onedark.nvim",
		opts = {
			style = "darker",
			highlights = {
				BufferCurrent = {
					fg = "#dddddd",
				},
			},
		},
		init = function()
			local onedark = require("onedark")

			onedark.load()
		end,
	},
}
