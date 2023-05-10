return {
	settings = {
		Lua = {
			diagnostics = {
				disable = {
					"lowercase-global"
				},
				globals = {
					"vim"
				}
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false
			},
			telemetry = {
				enabled = false
			}
		}
	}
}
