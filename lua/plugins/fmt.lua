return {
	{
		"mhartington/formatter.nvim",
		opts = function()
			local ts_fmt = require("formatter.defaults.prettier")
			local vue_fmt = require("formatter.filetypes.vue")
			local go_fmt = require("formatter.filetypes.go")

			return {
				filetype = {
					typescript = {
						ts_fmt
						-- ts_fmt.eslint_d
					},
					rust = {
						function()
							return {
								exe = "rustfmt",
								stdin = true,
								args = {
									"+nightly",
									"--edition 2021"
								}
							}
						end
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
