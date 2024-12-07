return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
			},
		},
	},
}
