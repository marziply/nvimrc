return {
	{
		"ray-x/go.nvim",
		event = {
			"CmdlineEnter",
		},
		ft = {
			"go",
			"gomod",
		},
		config = function()
			local go = require("go")
			local parsers = require("nvim-treesitter.parsers")
			local cmp = require("cmp_nvim_lsp")
			local client_caps = vim.lsp.protocol.make_client_capabilities()
			local all_caps = cmp.default_capabilities(client_caps)
			local configs = parsers.get_parser_configs()

			configs.gotmpl2 = {
				install_info = {
					url = "https://github.com/ngalaiko/tree-sitter-go-template",
					files = {
						"src/parser.c",
					},
				},
				filetype = "gotmpl",
				used_by = {
					"gohtmltmpl",
					"gotexttmpl",
					"gotmpl",
					"yaml",
				},
			}

			return go.setup({
				-- lsp_on_attach = true,
				lsp_inlay_hints = {
					enable = true,
				},
				lsp_config = {
					capabilities = all_caps,
				},
			})
		end,
		dependencies = {
			"ray-x/guihua.lua",
		},
	},
}
