local manager = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local utils = require("modules.utils")

require("modules.maps")

local function init()
	local lazy = require("lazy")

	return lazy.setup("plugins", {
		lockfile = vim.fn.stdpath("config") .. "/lock.json",
		concurrency = 10,
		change_detection = {
			notify = false,
		},
	})
end

if not vim.loop.fs_stat(manager) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim",
		"--branch=stable",
		manager,
	})
end

vim.lsp.inlay_hint.enable()
vim.opt.rtp:prepend(manager)

vim.diagnostic.config({
	update_in_insert = false,
})

vim.g.markdown_fenced_languages = {
	"ft=typescript",
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
vim.api.nvim_create_user_command("Reload", utils.reload, {
	nargs = 1,
	complete = function()
		local config = require("lazy.core.config")

		return vim.tbl_keys(config.plugins)
	end,
})

return init()
