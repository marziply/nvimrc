local manager = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local utils = require("modules.utils")
local servers = require("modules.servers")

require("modules.maps")

local function init()
	local lazy = require("lazy")

	lazy.setup("plugins", {
		lockfile = vim.fn.stdpath("config") .. "/lock.json",
		concurrency = 10,
		change_detection = {
			notify = false,
		},
	})

	for k, v in pairs(servers) do
		if type(v) == "function" then
			vim.lsp.config(k, v())
		else
			vim.lsp.config(k, v)
		end

		vim.lsp.enable(k)
	end
end

if not vim.uv.fs_stat(manager) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim",
		"--branch=stable",
		manager,
	})
end

vim.opt.rtp:prepend(manager)

vim.diagnostic.config({
	update_in_insert = false,
})

vim.g.markdown_fenced_languages = {
	"ft=typescript",
}

vim.g.rustaceanvim = {
	server = {
		-- capabilities = vim.lsp.protocol.make_client_capabilities(),
		default_settings = {
			["rust-analyzer"] = {
				diagnostics = {
					disabled = {
						"inactive-code",
					},
				},
			},
		},
		capabilities = {
			textDocument = {
				completion = {
					completionItem = {
						snippetSupport = false,
					},
				},
			},
		},
	},
}

vim.filetype.add({
	extension = {
		tera = "tera",
		jinja = "jinja",
		-- html = "jinja",
	},
})

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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "tera",
	callback = function(event)
		vim.bo[event.buf].commentstring = "{# %s #}"
	end,
})

return init()
