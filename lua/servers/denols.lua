return function(lsp)
	local tsconfig_exists = io.open("tsconfig.json", "r") ~= nil

	return {
		root_dir = lsp.util.root_pattern("deno.json"),
		autostart = not tsconfig_exists,
		init_options = {
			enable = true,
			lint = true,
			suggest = {
				autoImports = true,
				imports = {
					autoDiscover = true
				}
			}
		}
	}
end
