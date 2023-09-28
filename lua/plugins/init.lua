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
	-- "cstrahan/vim-capnp",
	-- "MunifTanjim/nui.nvim",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rcarriga/nvim-notify",
	"AndrewRadev/splitjoin.vim",
	"sheerun/vim-polyglot",
	"jghauser/mkdir.nvim",
	"sitiom/nvim-numbertoggle",
})
