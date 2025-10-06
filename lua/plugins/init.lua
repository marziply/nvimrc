local uses = {
	"kylechui/nvim-surround",
	"gbprod/stay-in-place.nvim",
	"chentoast/marks.nvim",
}
local events = {
	"textDocument/diagnostic",
	"workspace/diagnostic",
}

for i, value in ipairs(uses) do
	table.remove(uses, i)
	table.insert(uses, i, {
		value,
		config = true,
	})
end

for _, method in ipairs(events) do
	local handler = vim.lsp.handlers[method]

	vim.lsp.handlers[method] = function(err, result, context, config)
		if err ~= nil and err.code == -32802 then
			return
		end

		return handler(err, result, context, config)
	end
end

return vim.list_extend(uses, {
	{
		import = "plugins.lang",
	},
	"AndrewRadev/splitjoin.vim",
	"sitiom/nvim-numbertoggle",
	"b0o/schemastore.nvim",
	"tpope/vim-repeat",
})
