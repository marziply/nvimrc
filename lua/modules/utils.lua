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

function exec_from(path, fn)
  local mod = require(path)

  return fn(mod)
end

return {
  -- configure_nvim = configure_nvim,
  configure_zsh = configure_zsh,
  exec_from = exec_from
}
