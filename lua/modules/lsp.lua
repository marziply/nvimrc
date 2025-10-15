local servers = require("modules.servers")

function attempt(name, config)
	if not pcall(vim.lsp.config, name, config) then
		local message = string.format("Failed to configure '%s'", name)

		vim.notify(message, vim.log.levels.WARN)
	end
end

function init()
	vim.lsp.config("*", {
		root_markers = {
			".git",
		},
	})

	for k, v in pairs(servers) do
		if type(v) == "function" then
			attempt(k, v())
		else
			attempt(k, v)
		end

		if not pcall(vim.lsp.enable, k) then
			local message = string.format("Failed to start '%s'", k)

			vim.notify(message, vim.log.levels.WARN)
		end
	end
end

init()

return {
	init = init,
}
