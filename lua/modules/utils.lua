local function configure(files)
  local menu = require('nui.menu')
  local menu_items = {}
  local ui_opts = {
    relative = 'cursor',
    position = {
      row = 1,
      col = 0
    }
    -- relative = 'editor',
    -- size = {
    --   width = '30%',
    --   height = '30%'
    -- }
  }

  for i, file in ipairs(files) do
    table.insert(menu_items, i, file)
  end

  local ui = menu(ui_opts, {
    lines = {
      menu.item('')
    },
    max_width = 200,
    on_submit = function(item)
      print(item)
    end
    -- keymap = {}
  })

  ui:mount()
end

local function list_files(dir)
  local files = {}
  local result = io.popen('fd -d 1 -t f --base-directory ' .. dir)

  if not result then return files end

  for line in result:lines() do
    table.insert(files, string.upper(line))
  end

  return files
end

-- function configure_nvim()
--   local files = {}
-- end

function configure_zsh()
  local dir = os.getenv('XDG_CONFIG_HOME') .. '/zsh'
  local files = list_files(dir)

  configure(files)
end

function popup_substitute(old_value)
  local input = require('nui.input')
  local ui = input({
    relative = 'cursor',
    position = {
      row = 2,
      col = 1
    },
    size = {
      width = 60
    },
    border = {
      style = 'single',
      text = {
        top = '[Substitute]',
        top_align = 'center'
      }
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:Normal'
    }
  }, {
    prompt = '> ',
    on_submit = function(new_value)
      vim.cmd('%s/' .. old_value .. '/' .. new_value)
    end
  })

  ui:mount()
end

function exec_from(path, fn)
  local mod = require(path)

  return fn(mod)
end

return {
  -- configure_nvim = configure_nvim,
  configure_zsh = configure_zsh,
  popup_substitute = popup_substitute,
  exec_from = exec_from
}
