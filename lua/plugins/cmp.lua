local function mapper(value)
	return {
		name = value
	}
end
local buf_sources = vim.tbl_map(mapper, {
	"nvim_lsp",
	"nvim_lsp_signature_help",
	"luasnip",
	"crates",
	"path",
	"cmd"
})
local win_sources = vim.tbl_map(mapper, {
	"buffer"
})

local function jump(x)
	local cmp = require("cmp")
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
			local map = cmp.mapping
			local select = {
				behavior = cmp.SelectBehavior.Insert
			}

			return {
				sources = cmp.config.sources(buf_sources, win_sources),
				enabled = function()
					local ctx = require("cmp.config.context")
					local cap = ctx.in_treesitter_capture("comment")
					local syn = ctx.in_syntax_group("Comment")
					local mode = vim.api.nvim_get_mode()

					if mode.mode == "c" then
						return true
					else
						return not cap and not syn
					end
				end,
				snippet = {
					expand = function(args)
						snip.lsp_expand(args.body)
					end
				},
				window = {
					documentation = cmp.config.window.bordered()
				},
				mapping = map.preset.insert {
					["<c-n>"] = jump(1),
					["<c-p>"] = jump(-1),
					["<c-d>"] = map.scroll_docs(4),
					["<c-u>"] = map.scroll_docs(-4),
					["<tab>"] = map.select_next_item(select),
					["<s-tab>"] = map.select_prev_item(select),
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
		init = function()
      local cmp = require("cmp")
			local loaders = require("luasnip.loaders.from_vscode")
			local handlers = require("nvim-autopairs.completion.handlers")
			local pairs = require("nvim-autopairs.completion.cmp")

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
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline"
		}
	}
}
