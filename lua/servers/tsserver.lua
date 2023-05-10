return function(lsp)
	local vite_exists = io.open("vite.config.ts", "r") ~= nil
	local deno_exists = io.open("deno.json", "r") ~= nil

	return {
		root_dir = lsp.util.root_pattern("package.json"),
		autostart = not vite_exists and not deno_exists
	}
end
