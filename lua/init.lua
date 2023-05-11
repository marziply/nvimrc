local manager = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

require("modules.maps")

local function init()
  local lazy = require("lazy")

  return lazy.setup("plugins", {
    lockfile = vim.fn.stdpath("config") .. "/lock.json",
    concurrency = 10,
		change_detection = {
			notify = false
		}
  })
end

if not vim.loop.fs_stat(manager) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim",
		"--branch=stable",
		manager
	}
end

vim.opt.rtp:prepend(manager)

vim.diagnostic.config {
  update_in_insert = true
}

vim.g.markdown_fenced_languages = {
  "ft=typescript"
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		client.server_capabilities.semanticTokensProvider = nil
	end
})

return init()
