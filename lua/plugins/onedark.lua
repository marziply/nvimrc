return {
	{
		"navarasu/onedark.nvim",
    opts = {
      style = "warmer"
    },
		init = function()
      local onedark = require("onedark")

			onedark.load()
		end
	}
}
