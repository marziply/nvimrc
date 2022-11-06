local packer = require('packer')

plugins = {
  'wbthomason/packer.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'rcarriga/nvim-notify'
}
servers = {
  'rust_analyzer',
  'sumneko_lua',
  'clangd',
  'tsserver'
}

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
    return input.init(mod, require('modules.maps'))
  end
end

packer.startup {
  function(use)
    for _, path in ipairs(plugins) do
      use(path)
    end

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
            local cmp = require('cmp_nvim_lsp')
            local defaults = lsp.util.default_config

            defaults.capabilities = vim.tbl_deep_extend(
              'force',
              defaults.capabilities,
              cmp.default_capabilities()
            )

            for _, name in ipairs(servers) do
              local server = lsp[name]

              server.setup({})
            end
          end
        }
      end
    }
    use {
      'hrsh7th/nvim-cmp',
      config = function()
        plug {
          'cmp',
          init = function(cmp)
            local snip = require('luasnip')
            local snip_loaders = require('luasnip.loaders.from_vscode')
            local ap = require('nvim-autopairs.completion.cmp')
            local handlers = require('nvim-autopairs.completion.handlers')
            local select_opts = {
              behavior = cmp.SelectBehavior.Insert
            }
            local function jump_map(x)
              local function jump(fallback)
                if snip.jumpable(x) then
                  snip.jump(x)
                else
                  fallback()
                end
              end

              return cmp.mapping(jump, {
                'i',
                's'
              })
            end

            snip_loaders.lazy_load()
            cmp.event:on('confirm_done', ap.on_confirm_done {
              filetypes = {
                ['*'] = {
                  ['('] = {
                    handler = handlers['*'],
                    kind = {
                      cmp.lsp.CompletionItemKind.Function,
                      cmp.lsp.CompletionItemKind.Method
                    }
                  }
                }
              }
            })

            cmp.setup {
              snippet = {
                expand = function(args) snip.lsp_expand(args.body) end
              },
              window = {
                documentation = cmp.config.window.bordered()
              },
              sources = cmp.config.sources {
                {
                  name = 'nvim_lsp'
                },
                {
                  name = "luasnip"
                },
                {
                  name = 'path'
                },
                {
                  name = 'buffer'
                },
              },
              mapping = cmp.mapping.preset.insert {
                ['<c-n>'] = jump_map(1),
                ['<c-p>'] = jump_map(-1),
                ['<c-d>'] = cmp.mapping.scroll_docs(4),
                ['<c-u>'] = cmp.mapping.scroll_docs(-4),
                ['<tab>'] = cmp.mapping.select_next_item(select_opts),
                ['<s-tab>'] = cmp.mapping.select_prev_item(select_opts),
                ['<esc>'] = cmp.mapping.abort(),
                ['<cr>'] = cmp.mapping.confirm()
              }
            }
          end
        }
      end
    }
    use {
      'mhartington/formatter.nvim',
      config = function()
        plug {
          'formatter',
          init = function(fmt)
            local ts_fmt = require('formatter.filetypes.typescript')
            -- local lua_fmt = require('formatter.filetypes.lua')

            fmt.setup {
              filetype = {
                -- lua = {
                --   lua_fmt.stylua
                -- },
                ts = {
                  ts_fmt.eslint
                },
                typescript = {
                  ts_fmt.eslint
                }
              }
            }
          end
        }
      end
    }
    use {
      'mfussenegger/nvim-dap',
      config = function()
        plug {
          'dag',
          init = function(dap)
            -- Configure language debuggers here...
          end
        }
      end
    }
    use {
      'akinsho/toggleterm.nvim',
      config = function()
        plug {
          'toggleterm',
          config = {
            direction = 'float',
            float_opts = {
              width = 200,
              height = 50
            }
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
            filetype_exclude = {
              'dashboard'
            }
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
            },
            sections = {
              lualine_c = {
                {
                  'filename',
                  path = 1
                }
              }
            },
            inactive_sections = {
              lualine_c = {
                {
                  'filename',
                  path = 1
                }
              }
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
          config = {
            defaults = {
              mappings = {
                i = {
                  ['<c-j>'] = function()
                    vim.api.nvim_input('<cr>')
                  end
                }
              }
            }
          }
        }
      end
    }
    use {
      'navarasu/onedark.nvim',
      config = function()
        plug {
          'onedark',
          init = function(onedark)
            onedark.setup {
              style = 'warmer'
            }

            onedark.load()
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

            hop.setup {
              jump_on_sole_occurence = true,
              uppercase_labels = true
            }

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
      config = function()
        plug {
          'renamer',
          config = {
            empty = true,
            mappings = {
              ['<c-c>'] = function()
                vim.api.nvim_input('<esc>')
              end
            }
          }
        }
      end
    }
    use {
      'windwp/nvim-autopairs',
      config = function() plug('nvim-autopairs') end
    }
    use {
    	'goolord/alpha-nvim',
      config = function()
        plug {
          'alpha',
          init = function(alpha)
            local db = require('alpha.themes.dashboard')

            db.section.buttons.val = {
              db.button('e', 'New file', ':enew <bar> startinsert <cr>'),
              db.button('q', 'Quit', ':qa<cr>')
            }

            alpha.setup(db.config)
          end
        }
      end
    }
    -- use {
    -- 	'gbprod/cutlass.nvim',
    -- 	config = function() plug('cutlass') end
    -- }
  end,
  config = {
    ensure_dependencies = true,
    autoclean = true,
    autoremove = true
  }
}
