return {
	"Saghen/blink.cmp",
	version = "1.*",
	opts = {
		keymap = {
			preset = "enter",
			["<c-u>"] = {
				"scroll_documentation_up",
				"fallback",
			},
			["<c-d>"] = {
				"scroll_documentation_down",
				"fallback",
			},
		},
		sources = {
			default = {
				"lsp",
				"path",
			},
		},
		completion = {
			documentation = {
				auto_show = true,
			},
		},
	},
}
