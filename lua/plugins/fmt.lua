return {
	{
		"stevearc/conform.nvim",
		opts = function()
			local util = require("conform.util")

			return {
				notify_on_error = true,
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 500,
				},
				format_after_save = {
					lsp_fallback = true,
				},
				formatters_by_ft = {
					lua = {
						"stylua",
					},
					luau = {
						"stylua",
					},
					vue = {
						"prettier",
					},
					react = {
						"prettier",
					},
					javascript = {
						"prettier",
					},
					typescript = {
						"prettier",
					},
					typescriptreact = {
						"prettier",
					},
					rust = {
						"rustfmt_nightly",
					},
					sql = {
						"pg_format",
					},
					python = {
						"ruff",
					},
					pgsql = {
						"pg_format",
					},
					json = {
						"jq",
					},
					toml = {
						"taplo",
					},
					terraform = {
						"tofu",
					},
					c = {
						"uncrustify",
						"clang_format",
					},
					go = {
						"gofmt",
					},
					html = {
						"html",
					},
					-- htmldjango = {
					-- 	"html",
					-- },
				},
				formatters = {
					rustfmt_nightly = {
						stdin = true,
						command = "rustfmt",
						args = "+nightly --edition 2024",
						cwd = util.root_file({
							"Cargo.toml",
						}),
					},
					jsonnet = {
						stdin = true,
						command = "jsonnetfmt",
						args = "--string-style d -",
					},
					uncrustify = {
						stdin = true,
						command = "uncrustify",
						args = "-c format.cfg -l C",
					},
					pg_format = {
						stdin = true,
						command = "pg_format",
						args = "-s 2 -w 80 -u 1 -U 1 -C --no-space-function -",
					},
					ruff = {
						stdin = false,
						command = "ruff",
						args = "format",
					},
					tofu = {
						stdin = true,
						command = "tofu",
						args = "fmt -",
					},
					html = {
						stdin = true,
						command = "prettier",
						args = "--parser html",
					},
				},
			}
		end,
	},
}
