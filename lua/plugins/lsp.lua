local servers = {
  "gopls",
  "bufls",
  "tflint",
  "bashls"
}

local function extend_caps(cmp, defs)
	local caps = cmp.default_capabilities()

	return vim.tbl_deep_extend("force", defs.capabilities, caps)
end

return {
	{
		"neovim/nvim-lspconfig",
		init = function()
      local lsp = require("lspconfig")
			local cmp = require("cmp_nvim_lsp")
			local defs = lsp.util.default_config
			local path = vim.fn.stdpath("config") .. "/lua/servers"
			local files = io.popen("ls -A " .. path)

			defs.capabilities = extend_caps(cmp, defs)

			if files ~= nil then
				for name in files:lines() do
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
		end
	}
}
