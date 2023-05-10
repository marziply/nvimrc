local function jump(cmp, x)
	local snip = require("luasnip")

	local function callback(fallback)
		if snip.jumpable(x) then
			snip.jump(x)
		else
			fallback()
		end
	end

	return cmp.mapping(callback, {
		"i",
		"s"
	})
end

return {
	{
		"hrsh7th/nvim-cmp",
		opts = function()
      local cmp = require("cmp")
			local snip = require("luasnip")
			local loaders = require("luasnip.loaders.from_vscode")
			local handlers = require("nvim-autopairs.completion.handlers")
			local pairs = require("nvim-autopairs.completion.cmp")
			local map = cmp.mapping
			local select_opts = {
				behavior = cmp.SelectBehavior.Insert
			}

			loaders.lazy_load()

			cmp.event:on("confirm_done", pairs.on_confirm_done {
				filetypes = {
					["*"] = {
						["("] = {
							handler = handlers["*"],
							kind = {
								cmp.lsp.CompletionItemKind.Function,
								cmp.lsp.CompletionItemKind.Method
							}
						}
					}
				}
			})

			return {
				snippet = {
					expand = function(args)
						snip.lsp_expand(args.body)
					end
				},
				window = {
					documentation = cmp.config.window.bordered()
				},
				sources = cmp.config.sources {
					{
						name = "nvim_lsp"
					},
					-- {
						--   name = "nvim_lsp_signature_help"
					-- },
					{
						name = "luasnip"
					},
					{
						name = "crates"
					},
					{
						name = "path"
					},
					{
						name = "cmd"
					},
					{
						name = "buffer"
					}
				},
				mapping = map.preset.insert {
					["<c-n>"] = jump(cmp, 1),
					["<c-p>"] = jump(cmp, -1),
					["<c-d>"] = map.scroll_docs(4),
					["<c-u>"] = map.scroll_docs(-4),
					["<tab>"] = map.select_next_item(select_opts),
					["<s-tab>"] = map.select_prev_item(select_opts),
					["<esc>"] = map.abort(),
					["<cr>"] = map.confirm()
				},
				formatting = {
					-- Fixes: nvim-cmp/discussions/609#discussioncomment-1844480
					format = function(_, item)
						local label = item.abbr
						local trunc = vim.fn.strcharpart(label, 0, 120)

						if trunc ~= label then
							item.abbr = trunc .. "..."
						end

						return item
					end
				}
			}
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		}
	},
}
