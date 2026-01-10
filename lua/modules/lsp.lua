return {
	rust = {
		cmd = {
			"rust-analyzer",
		},
		filetypes = {
			"rust",
		},
		root_markers = {
			"Cargo.toml",
		},
	},
	lua = {
		cmd = {
			"lua-language-server",
		},
		filetypes = {
			"lua",
		},
		root_markers = {
			"lock.json",
		},
		settings = {
			Lua = {
				diagnostics = {
					disable = {
						"lowercase-global",
					},
					globals = {
						"vim",
						"Snacks",
					},
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						"${3rd}/luv/library",
					},
				},
				telemetry = {
					enabled = false,
				},
			},
		},
	},
	luau = {
		cmd = {
			"luau-analyze",
		},
		filetypes = {
			"luau",
		},
	},
	go = {
		cmd = {
			"gopls",
		},
		filetypes = {
			"go",
		},
		root_markers = {
			"go.mod",
		},
	},
	bash = {
		cmd = {
			"bash-language-server",
			"start",
		},
		filetypes = {
			"sh",
			"zsh",
			"bash",
		},
	},
	clang = {
		cmd = {
			"clang-format",
		},
		root_markers = {
			"format.cfg",
		},
		filetypes = {
			"c",
			"h",
			"cc",
			"cpp",
			"hpp",
		},
	},
	vue = function()
		local nvm_lib = os.getenv("NVM_LIB")
		local ts_path = string.format("%s/node_modules/typescript", nvm_lib)

		return {
			root_markers = {
				"vite.config.ts",
			},
			cmd = {
				"vue-language-server",
				"--stdio",
			},
			filetypes = {
				"typescript",
				"vue",
				"json",
			},
			init_options = {
				typescript = {
					tsdk = ts_path,
				},
			},
		}
	end,
	json = function()
		local store = require("schemastore")

		return {
			cmd = {
				"vscode-json-language-server",
				"--stdio",
			},
			filetypes = {
				"json",
			},
			settings = {
				json = {
					schemas = store.json.schemas(),
					validate = {
						enable = true,
					},
				},
			},
		}
	end,
	yaml = function()
		local store = require("schemastore")

		return {
			cmd = {
				"yaml-language-server",
				"--stdio",
			},
			filetypes = {
				"yaml",
			},
			settings = {
				yaml = {
					customTags = {
						"!reference sequence",
					},
					keyOrdering = false,
					proseWrap = "always",
					schemas = store.yaml.schemas({
						ignore = {
							"Deployer Recipe",
							"RKE Cluster Configuration YAML",
						},
						extra = {
							{
								url = "https://taskfile.dev/schema.json",
								name = "taskfile.yaml",
								fileMatch = "**/taskfile.yaml",
							},
						},
					}),
					schemaStore = {
						enable = false,
						url = "",
					},
				},
			},
		}
	end,
}
