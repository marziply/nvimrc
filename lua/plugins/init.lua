local uses = {
	"gbprod/stay-in-place.nvim",
	"saecki/crates.nvim",
	"windwp/nvim-autopairs",
	"kylechui/nvim-surround",
	"nvim-pack/nvim-spectre",
	"simrat39/rust-tools.nvim",
	"sigmasd/deno-nvim"
}

for i, value in ipairs(uses) do
  table.remove(uses, i)
  table.insert(uses, i, {
    value,
    config = true
  })
end

return vim.list_extend(uses, {
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rcarriga/nvim-notify",
  "AndrewRadev/splitjoin.vim",
  "MunifTanjim/nui.nvim",
  "cstrahan/vim-capnp",
  "sheerun/vim-polyglot"
})
