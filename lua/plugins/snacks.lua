local function plugin_keys(keys)
	local ret = {}

	for k, v in pairs(keys) do
		local map = {
			"<leader>" .. k,
		}

		if type(v) == "string" then
			table.insert(map, function()
				Snacks.picker[v]()
			end)
		else
			table.insert(map, v)
		end

		table.insert(ret, map)
	end

	return ret
end

local function win_key(name)
	return {
		name,
		mode = {
			"n",
			"i",
		},
	}
end

return {
	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			styles = {
				notification = {
					wo = {
						wrap = true,
					},
				},
			},
			picker = {
				enabled = true,
				win = {
					input = {
						keys = {
							["<c-u>"] = win_key("preview_scroll_up"),
							["<c-d>"] = win_key("preview_scroll_down"),
						},
					},
				},
			},
			indent = {
				enabled = true,
				animate = {
					enabled = false,
				},
			},
			notifier = {
				enabled = true,
				timeout = 6000,
				top_down = false,
				width = {
					min = 40,
					max = 0.3,
				},
			},
			notify = {
				enabled = true,
			},
			bufdelete = {
				enabled = false,
			},
			dashboard = {
				enabled = true,
			},
			debug = {
				enabled = true,
			},
			git = {
				enabled = true,
			},
			scope = {
				enabled = false,
			},
			statuscolumn = {
				enabled = true,
			},
		},
		keys = plugin_keys({
			["*"] = "grep_word",
			q = "qflist",
			u = "undo",
			ff = "files",
			fg = "grep",
			ch = "command_history",
			sh = "search_history",
			ss = "spelling",
			mp = "man",
			ma = "marks",
			re = "registers",
			lo = "diagnostics_buffer",
			lr = "lsp_references",
			li = "lsp_implementations",
			ld = "lsp_definitions",
			gl = "git_log",
			gb = "git_branches",
			gs = "git_status",
			cc = function()
				Snacks.picker.files({
					cwd = "~/.config",
				})
			end,
			nl = function()
				Snacks.picker.files({
					cwd = "~/.config/nvim/lua",
				})
			end,
			nc = function()
				Snacks.picker.files({
					cwd = "~/.config/nvim/config",
				})
			end,
			nh = function()
				Snacks.notifier.show_history()
			end,
		}),
	},
}
