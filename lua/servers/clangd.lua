return function(lsp)
	return {
		root_dir = lsp.util.root_pattern(".git", "format.cfg"),
		filetypes = {
			"c",
			"h",
			"cc",
			"cpp",
			"hpp"
		}
	}
end
