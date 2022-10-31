local packer = require('packer')

local function check(name)
	local ok, _ = pcall(require, name)

	if not ok then
		print('Run PackerSync for uninstalled package: ' .. name)

		return false
	end

	return true
end

function plug(input)
	local name = input.name or input[1] or input

	if not check(name) then return nil end

	local mod = require(name)

	if input.init == nil then
		return mod.setup(input.config or {})
	else
		local maps = require('core.maps')

		return input.init(mod, maps)
	end
end

packer.startup {
	function(use)
		use 'wbthomason/packer.nvim'
		use 'm4xshen/autoclose.nvim'
		use 'nvim-treesitter/nvim-treesitter'
		use 'nvim-treesitter/nvim-treesitter-context'
		use 'nvim-treesitter/nvim-treesitter-textobjects'
		use 'ms-jpq/coq_nvim'
		-- use 'ms-jpq/coq.artifacts'
		use {
			'williamboman/mason.nvim',
			config = function() plug('mason') end
		}
		use {
			'williamboman/mason-lspconfig.nvim',
			config = function()
				plug {
					'mason-lspconfig',
					config = {
						automatic_installation = true,
						ensure_installed = {
							'rust_analyzer'
						}
					}
				}
			end
		}
		use {
			'neovim/nvim-lspconfig',
			config = function()
				plug {
					'lspconfig',
					init = function(lsp)
						lsp.rust_analyzer.setup({})
						lsp.sumneko_lua.setup({})
					end
				}
			end
		}
		use {
			'folke/trouble.nvim',
			config = function()
				plug {
					'trouble',
					config = {
						icons = false
					}
				}
			end
		}
		use {
			'numToStr/Comment.nvim',
			config = function() plug('Comment') end
		}
		use {
			'gbprod/stay-in-place.nvim',
			config = function() plug('stay-in-place') end
		}
		use {
			'saecki/crates.nvim',
			config = function() plug('crates') end
		}
		use {
			'kylechui/nvim-surround',
			config = function() plug('nvim-surround') end
		}
		use {
			'lukas-reineke/indent-blankline.nvim',
			config = function()
				plug {
					'indent_blankline',
					config = {
						--
					}
				}
			end
		}
		use {
			'nvim-lualine/lualine.nvim',
			config = function()
				plug {
					'lualine',
					config = {
						options = {
							icons_enabled = false
						}
					}
				}
			end
		}
		use {
			'nvim-telescope/telescope.nvim',
			requires = {
				{
					'nvim-lua/plenary.nvim'
				}
			},
			config = function()
				plug {
					'telescope',
					init = function(telescope)
						local actions = require('telescope.actions')

						telescope.setup {
							defaults = {
								mappings = {
									i = {
										['<c-j>'] = actions.file_edit
									}
								}
							}
						}
					end
				}
			end
		}
		-- use {
		-- 	'sunjon/shade.nvim',
		-- 	config = function()
		-- 		plug {
		-- 			'shade',
		-- 			config = {
		-- 				overlay_opacity = 75,
		-- 				keys = {
		-- 					toggle = '<c-f>s'
		-- 				}
		-- 			}
		-- 		}
		-- 	end
		-- }
		use {
			'navarasu/onedark.nvim',
			config = function()
				plug {
					'onedark',
					init = function(m)
						m.setup {
							style = 'warmer'
						}
						m.load()
					end
				}
			end
		}
		use {
			'phaazon/hop.nvim',
			branch = 'v2',
			config = function()
				plug {
					'hop',
					init = function(hop, maps)
						local hints = require('hop.hint')
						local dirs = hints.HintDirection

						hop.setup()

						maps.nmap_with('T', function()
							hop.hint_char2 {
								direction = dirs.BEFORE_CURSOR
							}
						end)
						maps.nmap_with('t', function()
							hop.hint_char2 {
								direction = dirs.AFTER_CURSOR
							}
						end)
						maps.nmap_with('s', function()
							hop.hint_char2 {
								multi_windows = true
							}
						end)
						maps.nmap_with('<c-t>k', function()
							hop.hint_vertical {
								direction = dirs.BEFORE_CURSOR
							}
						end)
						maps.nmap_with('<c-t>j', function()
							hop.hint_vertical {
								direction = dirs.AFTER_CURSOR
							}
						end)
						maps.nmap_with('<c-t>h', function()
							hop.hint_words {
								direction = dirs.BEFORE_CURSOR,
								current_line_only = true
							}
						end)
						maps.nmap_with('<c-t>l', function()
							hop.hint_words {
								direction = dirs.AFTER_CURSOR,
								current_line_only = true
							}
						end)
					end
				}
			end
		}
		use {
			'romgrk/barbar.nvim',
			config = function()
				plug {
					'bufferline',
					config = {
						icons = false,
						closable = false
					}
				}
			end
		}
		use {
			'filipdutescu/renamer.nvim',
			config = function() plug('renamer') end
		}
		-- use {
		-- 	'windwp/nvim-autopairs',
		-- 	config = function() plug('nvim-autopairs') end
		-- }
		-- use {
		-- 	'goolord/alpha-nvim',
		-- 	config = function()
		-- 		local alpha = require('alpha')
		-- 		local dash = require('alpha.themes.dashboard')

		-- 		alpha.setup(dash.config)
		-- 	end
		-- }
	end
}
