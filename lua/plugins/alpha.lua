return {
	{
		"goolord/alpha-nvim",
		opts = function()
			local db = require("alpha.themes.dashboard")

			db.section.buttons.val = {
				db.button("e", "New file", ":enew <bar> startinsert <cr>"),
				db.button("q", "Quit", ":qa<cr>")
			}

			return db.config
		end
	}
}
