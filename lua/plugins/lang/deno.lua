return {
	{
		"sigmasd/deno-nvim",
		opts = function()
			local lsp = require("lspconfig")

			return {
				server = {
					root_dir = lsp.util.root_pattern("deno.json"),
					cmd_env = {
						DENO_V8_FLAGS = "--max-old-space-size=8192"
					},
					settings = {
						deno = {
							lint = true,
							suggest = {
								autoImports = true,
								imports = {
									autoDiscover = true,
									-- hosts = {
										-- 	["https://registry.npmjs.com"] = true
									-- }
								}
							}
						}
					}
				}
			}
		end
	}
}
