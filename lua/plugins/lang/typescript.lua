return {
	{
		"pmizio/typescript-tools.nvim",
		opts = function()
			local lsp = require("lspconfig")
			local vite_exists = io.open("vite.config.ts", "r") ~= nil
			local deno_exists = io.open("deno.json", "r") ~= nil

			return {
				root_dir = lsp.util.root_pattern("package.json"),
				autostart = not vite_exists and not deno_exists,
				settings = {
					publish_diagnostic_on = "change",
					separate_diagnostic_server = true,
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
					tsserver_format_options = {
						allowIncompleteCompletions = false,
						allowRenameOfImportPath = false,
					},
				},
			}
		end,
		dependencies = {
			{
				"vuki656/package-info.nvim",
				opts = {
					package_manager = "npm",
					autostart = true,
					icons = {
						enable = false,
					},
				},
			},
		},
	},
}
