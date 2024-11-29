return {
	{
		"rcarriga/nvim-notify",
		opts = {
			top_down = false,
			fps = 60,
		},
	},
	{
		"mrded/nvim-lsp-notify",
		opts = function()
			return {
				notify = require("notify"),
			}
		end,
	},
}
