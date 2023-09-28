function get_fmt(name, key)
	local path = string.format("formatter.filetypes.%s", name)
	local mod = require(path)

	return {
		mod[key],
	}
end

function get_fmt_default(name)
	local path = string.format("formatter.defaults.%s", name)

	return {
		require(path),
	}
end

return {
	{
		"mhartington/formatter.nvim",
		opts = function()
			return {
				filetype = {
					rust = {
						function()
							return {
								stdin = true,
								exe = "rustfmt",
								args = {
									"+nightly",
									"--edition 2021",
								},
							}
						end,
					},
					jsonnet = {
						function()
							return {
								stdin = true,
								exe = "jsonnetfmt",
								args = {
									"--string-style d",
									"-",
								},
							}
						end,
					},
					typescript = get_fmt_default("prettier"),
					go = get_fmt("go", "gofmt"),
					vue = get_fmt("vue", "prettier"),
					lua = get_fmt("lua", "stylua"),
				},
			}
		end,
	},
}
