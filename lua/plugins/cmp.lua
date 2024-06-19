local function sources()
	local function mapper(value)
		return {
			name = value,
		}
	end

	local lsp_sources = {
		{
			name = "nvim_lsp",
			entry_filter = function(entry)
				local cmp = require("cmp")

				return entry:get_kind() ~= cmp.lsp.CompletionItemKind.Snippet
			end,
		},
	}
	local buf_sources = vim.tbl_map(mapper, {
		"nvim_lsp_signature_help",
		"crates",
		"path",
		"cmd",
	})
	local win_sources = vim.tbl_map(mapper, {
		"buffer",
	})

	vim.list_extend(lsp_sources, buf_sources)

	return lsp_sources, win_sources
end

local function on_pairs_ready()
	local cmp = require("cmp")
	local handlers = require("nvim-autopairs.completion.handlers")
	local pairs = require("nvim-autopairs.completion.cmp")

	return pairs.on_confirm_done({
		filetypes = {
			["*"] = {
				["("] = {
					handler = handlers["*"],
					kind = {
						cmp.lsp.CompletionItemKind.Function,
						cmp.lsp.CompletionItemKind.Method,
					},
				},
			},
		},
	})
end

local function is_cmp_enabled()
	local ctx = require("cmp.config.context")
	local cap = ctx.in_treesitter_capture("comment")
	local syn = ctx.in_syntax_group("Comment")
	local mode = vim.api.nvim_get_mode()

	if mode.mode == "c" then
		return true
	end

	return not cap and not syn
end

local function cmp_key_binds()
	local cmp = require("cmp")
	local map = cmp.mapping
	-- @NOTE: I don't know why this works.
	local movement = cmp.mapping(function(cb)
		cb()
	end, {
		"i",
		"s",
	})
	local select = {
		behavior = cmp.SelectBehavior.Insert,
	}

	return {
		["<c-n>"] = movement,
		["<c-p>"] = movement,
		["<c-d>"] = map.scroll_docs(4),
		["<c-u>"] = map.scroll_docs(-4),
		["<tab>"] = map.select_next_item(select),
		["<s-tab>"] = map.select_prev_item(select),
		["<cr>"] = map.confirm(),
	}
end

local function cmp_fmt(item)
	local src_label = item.abbr or ""
	local new_label = vim.fn.strcharpart(src_label, 0, 80)
	local src_text = item.menu or ""
	local new_text = vim.fn.strcharpart(src_text, 0, 80)

	if new_label ~= src_label then
		item.abbr = new_label .. "..."
	end

	if new_text ~= src_text then
		item.menu = new_text .. "..."
	end

	return item
end

return {
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local cmp = require("cmp")
			-- local cmp_rs = require("cmp_lsp_rs")
			local map = cmp.mapping
			local buf_sources, win_sources = sources()
			local win_opts = vim.tbl_extend("force", cmp.config.window.bordered(), {
				max_width = 80,
				max_height = 40,
			})

			-- for _, source in ipairs(buf_sources) do
			-- 	cmp_rs.filter_out.entry_filter(source)
			-- end

			return {
				enabled = is_cmp_enabled,
				sources = cmp.config.sources(buf_sources, win_sources),
				mapping = map.preset.insert(cmp_key_binds()),
				preselect = cmp.PreselectMode.None,
				window = {
					completion = win_opts,
					documentation = win_opts,
				},
				formatting = {
					-- Fixes: nvim-cmp/discussions/609#discussioncomment-1844480
					format = function(_, item)
						return cmp_fmt(item)
					end,
				},
				-- sorting = {
				-- 	comparators = {
				-- 		cmp.config.compare.exact,
				-- 		cmp.config.compare.score,
				-- 		cmp_rs.comparators.inscope_inherent_import,
				-- 		cmp_rs.comparators.sort_by_label_but_underscore_last,
				-- 	},
				-- },
			}
		end,
		init = function()
			local cmp = require("cmp")

			cmp.event:on("confirm_done", on_pairs_ready())
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- "zjp-CN/nvim-cmp-lsp-rs",
		},
	},
}
