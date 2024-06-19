local uses = {
	"windwp/nvim-autopairs",
	"kylechui/nvim-surround",
	"gbprod/stay-in-place.nvim",
	"chentoast/marks.nvim",
}

for i, value in ipairs(uses) do
	table.remove(uses, i)
	table.insert(uses, i, {
		value,
		config = true,
	})
end

return vim.list_extend(uses, {
	{
		import = "plugins.lang",
	},
	"AndrewRadev/splitjoin.vim",
	"sheerun/vim-polyglot",
	"sitiom/nvim-numbertoggle",
	"b0o/schemastore.nvim",
})
