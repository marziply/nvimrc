return {
	{
		"mhartington/formatter.nvim",
		opts = function()
			-- local lua_fmt = require("formatter.filetypes.lua")
			-- local ts_fmt = require("formatter.filetypes.typescript")
			local ts_fmt = require("formatter.defaults.prettier")
			local vue_fmt = require("formatter.filetypes.vue")
			local rs_fmt = require("formatter.filetypes.rust")
			local go_fmt = require("formatter.filetypes.go")

			return {
				filetype = {
					typescript = {
						ts_fmt
						-- ts_fmt.eslint_d
					},
					rust = {
						rs_fmt.rustfmt
					},
					go = {
						go_fmt.gofmt
					},
					vue = {
						vue_fmt.prettier
					}
					-- lua = {
						--   lua_fmt.stylua
					-- },
				}
			}
		end
	}
}
