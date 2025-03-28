return {
	{
		"akinsho/bufferline.nvim",
		opts = function()
			local bl = require("bufferline")

			return {
				highlights = {
					fill = {
						bg = "#1C1C1C",
					},
					buffer_visible = {
						fg = "grey",
					},
				},
				options = {
					style_preset = bl.style_preset.no_italic,
					themable = false,
					show_close_icon = false,
					show_buffer_close_icons = false,
					show_buffer_icons = false,
					right_mouse_command = false,
					left_moud_command = false,
					diagnostics = "nvim_lsp",
					separator_style = "thin",
				},
			}
		end,
	},
}
