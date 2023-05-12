return {
	{
		"jose-elias-alvarez/typescript.nvim",
		opts = function()
			local lsp = require("lspconfig")
			local vite_exists = io.open("vite.config.ts", "r") ~= nil
			local deno_exists = io.open("deno.json", "r") ~= nil

			return {
				server = {
					root_dir = lsp.util.root_pattern("package.json"),
					autostart = not vite_exists and not deno_exists
				}
			}
		end,
		dependencies = {
			{
				"vuki656/package-info.nvim",
				opts = {
					package_manager = "npm",
					autostart = true,
					icons = {
						enable = false
					}
				}
			}
		}
	}
}
