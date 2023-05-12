return {
	{
		"williamboman/mason.nvim",
		config = true,
		build = ":MasonUpdate",
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim"
			}
		}
	}
}
