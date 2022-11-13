local packer = require('packer')

plugins = {
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'rcarriga/nvim-notify',
  'AndrewRadev/splitjoin.vim',
  'MunifTanjim/nui.nvim'
}
servers = {
  {
    name = 'sumneko_lua',
    config = {
      settings = {
        Lua = {
          diagnostics = {
            disable = {
              'lowercase-global'
            },
            globals = {
              'vim'
            }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true)
          },
          telemetry = {
            enabled = false
          }
        }
      }
    }
  },
  {
    name = 'rust_analyzer',
  },
  {
    name = 'clangd',
  },
  {
    name = 'tsserver',
  }
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

  if input.init then
    return input.init(mod, {
      maps = require('modules.maps'),
      utils = require('modules.utils')
    })
  else
    return mod.setup(input.config or {})
  end
end

packer.startup {
  function(use)
    use('wbthomason/packer.nvim')

    for _, path in ipairs(plugins) do
      use(path)
    end

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
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects'
      },
      config = function()
        local treesitter_configs = require('nvim-treesitter.configs')

        treesitter_configs.setup {
          auto_install = true,
          ensure_installed = {
            'rust',
            'lua',
            'javascript',
            'tsx',
            'json',
            'html',
            'css'
          },
          highlight = {
            enable = true
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true
            }
          }
        }
      end
    }
    use {
      'williamboman/mason.nvim',
      config = function() plug('mason') end,
      requires = {
        {
          'williamboman/mason-lspconfig.nvim',
          config = function()
            plug {
              'mason-lspconfig',
              config = {
                automatic_installation = true,
                ensure_installed = {
                  'rust_analyzer',
                  'tsserver'
                }
              }
            }
          end
        }
      }
    }
    use {
      'neovim/nvim-lspconfig',
      config = function()
        plug {
          'lspconfig',
          init = function(lsp)
            local cmp = require('cmp_nvim_lsp')
            local defs = lsp.util.default_config

            defs.capabilities = vim.tbl_deep_extend(
              'force',
              defs.capabilities,
              cmp.default_capabilities()
            )

            for _, opt in ipairs(servers) do
              local server = lsp[opt.name]

              server.setup(opt.config or {})
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
            local function jump(x)
              local function callback(fallback)
                if snip.jumpable(x) then
                  snip.jump(x)
                else
                  fallback()
                end
              end

              return cmp.mapping(callback, {
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
                  name = 'nvim_lsp_signature_help'
                },
                {
                  name = 'luasnip'
                },
                {
                  name = 'path'
                },
                {
                  name = 'cmd'
                }
              },
              mapping = cmp.mapping.preset.insert {
                ['<c-n>'] = jump(1),
                ['<c-p>'] = jump(-1),
                ['<c-d>'] = cmp.mapping.scroll_docs(4),
                ['<c-u>'] = cmp.mapping.scroll_docs(-4),
                ['<tab>'] = cmp.mapping.select_next_item(select_opts),
                ['<s-tab>'] = cmp.mapping.select_prev_item(select_opts),
                ['<esc>'] = cmp.mapping.abort(),
                ['<cr>'] = cmp.mapping.confirm()
              },
              formatting = {
                -- Fixes: nvim-cmp/discussions/609#discussioncomment-1844480
                format = function(_, item)
                  local label = item.abbr
                  local trunc = vim.fn.strcharpart(label, 0, 120)

                  if trunc ~= label then
                    item.abbr = trunc .. '...'
                  end

                  return item
                end
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
          'dap',
          init = function()
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
      config = function()
        plug {
          'Comment',
          config = {
            sticky = true
          }
        }
      end
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
              'dashboard',
              'help',
              'lspinfo',
              'checkhealth',
              'man',
              'packer'
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
              icons_enabled = false,
              refresh = {
                statusline = 250,
                tabline = 250,
                winbar = 250
              }
            },
            sections = {
              lualine_b = {
                'branch',
                'diff'
              },
              lualine_c = {
                {
                  'filename',
                  path = 1
                }
              },
              lualine_x = {
                'filetype'
              },
              lualine_y = {
                'diagnostics',
              },
              lualine_z = {
                'location'
              }
            },
            inactive_sections = {
              lualine_c = {
                {
                  'filename',
                  path = 1
                }
              },
              lualine_x = {
                'diagnostics'
              }
            }
          }
        }
      end
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
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
      'phaazon/hop.nvim',
      branch = 'v2',
      config = function()
        plug {
          'hop',
          init = function(hop, mods)
            local hints = require('hop.hint')
            local dirs = hints.HintDirection

            hop.setup {
              jump_on_sole_occurence = true,
              uppercase_labels = true
            }

            mods.maps.nmap_with_all {
              ['T'] = function()
                hop.hint_char2 {
                  direction = dirs.BEFORE_CURSOR
                }
              end,
              ['t'] = function()
                hop.hint_char2 {
                  direction = dirs.AFTER_CURSOR
                }
              end,
              ['s'] = function()
                hop.hint_char2 {
                  multi_windows = true
                }
              end,
              ['<c-t>k'] = function()
                hop.hint_vertical {
                  direction = dirs.BEFORE_CURSOR
                }
              end,
              ['<c-t>j'] = function()
                hop.hint_vertical {
                  direction = dirs.AFTER_CURSOR
                }
              end,
              ['<c-t>h'] = function()
                hop.hint_words {
                  direction = dirs.BEFORE_CURSOR,
                  current_line_only = true
                }
              end,
              ['<c-t>l'] = function()
                hop.hint_words {
                  direction = dirs.AFTER_CURSOR,
                  current_line_only = true
                }
              end
            }
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
            animation = false,
            closable = false,
            icons = false
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
