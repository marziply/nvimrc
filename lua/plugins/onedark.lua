return {
	{
		"navarasu/onedark.nvim",
    opts = {
      style = "warmer"
    },
		init = function(onedark)
      local onedark = require("onedark")

			onedark.load()
		end
	}
}
