return {
	"Saghen/blink.cmp",
	version = "1.*",
	opts = {
		keymap = {
			preset = "enter",
			["<c-u>"] = {
				"scroll_signature_up",
				"fallback",
			},
			["<c-d>"] = {
				"scroll_signature_down",
				"fallback",
			},
		},
		sources = {
			default = {
				"lsp",
				"path",
			},
		},
		signature = {
			enabled = true,
			window = {
				direction_priority = { "s" },
			},
		},
	},
}
