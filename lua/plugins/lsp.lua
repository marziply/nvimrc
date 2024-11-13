local servers = {
	"gopls",
	"bufls",
	"tflint",
	"bashls",
	"jsonnet_ls",
	"luau_lsp",
}

return {
	{
		"neovim/nvim-lspconfig",
		init = function()
			local lsp = require("lspconfig")
			local path = vim.fn.stdpath("config") .. "/lua/servers"
			local files = io.popen("ls -A " .. path)

			if files ~= nil then
				for name in files:lines() do
					if vim.tbl_contains(servers, name) then
						error("Conflict in LSP server configuration")
					end

					local key = string.gsub(name, ".lua", "")
					local mod = string.format("servers.%s", key)
					local ok, config = pcall(require, mod)
					local server = lsp[key]

					if ok then
						if type(config) == "function" then
							server.setup(config(lsp))
						else
							server.setup(config)
						end
					end
				end

				files:close()
			end

			for _, name in ipairs(servers) do
				local server = lsp[name]

				server.setup({})
			end
		end,
	},
}
