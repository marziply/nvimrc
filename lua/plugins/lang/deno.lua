return {
	{
		"sigmasd/deno-nvim",
		opts = function()
			local deno_exists = io.open("deno.json", "r") ~= nil

			return {
				server = {
					root_dir = vim.fs.find("deno.json"),
					autostart = deno_exists,
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
								},
							},
							inlayHints = {
								parameterNames = {
									enabled = "all",
								},
								parameterTypes = {
									enabled = true,
								},
								variableTypes = {
									enabled = true,
								},
								propertyDeclarationTypes = {
									enabled = true,
								},
								functionLikeReturnTypes = {
									enabled = true,
								},
								enumMemberValues = {
									enabled = true,
								},
							},
						},
					},
				},
			}
		end,
	},
}
