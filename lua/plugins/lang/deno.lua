return {
	{
		"sigmasd/deno-nvim",
		opts = function()
			local lsp = require("lspconfig")

			return {
				server = {
					root_dir = lsp.util.root_pattern("deno.json"),
					init_options = {
						lint = true,
						suggest = {
							autoImports = true,
							imports = {
								autoDiscover = true
							}
						}
					}
				}
			}
		end
	}
}
