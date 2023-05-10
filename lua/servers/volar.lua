return function(lsp)
	local nvm_lib = os.getenv("NVM_LIB")
	local ts_path = string.format("%s/node_modules/typescript", nvm_lib)

	return {
		root_dir = lsp.util.root_pattern("vite.config.ts"),
		filetypes = {
			"typescript",
			"vue",
			"json"
		},
		init_options = {
			typescript = {
				tsdk = ts_path
			}
		}
	}
end
