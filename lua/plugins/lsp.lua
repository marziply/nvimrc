local servers = {
	"gopls",
	"buf_ls",
	"tflint",
	"bashls",
	"jsonnet_ls",
	"luau_lsp",
}

function attempt(lsp, name, config)
	local server = lsp[name]

	if not server then
		warn("server not installed")

		return
	end

	function setup(c)
		local at_ok = pcall(server.setup, c)

		if not at_ok then
			local message = string.format("'%s' setup error", name)

			vim.notify(message, vim.log.levels.WARN)
		end
	end

	if type(config) == "function" then
		local c = config(lsp)

		if c.disabled then
			setup(config(lsp))
		end
	else
		if config.disabled then
			return
		end

		setup(config)
	end
end

function init()
	local lsp = require("lspconfig")
	local server_path = vim.fn.stdpath("config") .. "/lua/servers"
	local server_files = io.popen("ls -A " .. server_path)

	if server_files ~= nil then
		for file_name in server_files:lines() do
			if vim.tbl_contains(servers, file_name) then
				error("conflict in LSP server configuration")
			end

			local lsp_name = string.gsub(file_name, ".lua", "")
			local mod_name = string.format("servers.%s", lsp_name)
			local req_ok, config = pcall(require, mod_name)

			if req_ok then
				local at_ok = pcall(attempt, lsp, lsp_name, config)

				if not at_ok then
					local message = string.format("'%s' failed to start", mod_name)

					vim.notify(message, vim.log.levels.WARN)
				end
			end
		end

		server_files:close()
	end

	for _, name in ipairs(servers) do
		local at_ok = pcall(attempt, lsp, name, {})

		if not at_ok then
			local message = string.format("'%s' failed to start", name)

			vim.notify(message, vim.log.levels.WARN)
		end
	end
end

return {
	{
		"neovim/nvim-lspconfig",
		init = init,
		dependencies = {
			"snacks.nvim",
		},
	},
}
