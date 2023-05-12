function exec_from(path, fn)
  local mod = require(path)

  return fn(mod)
end

function reload(opts)
  local name = opts.fargs[1]
  local config = require("lazy.core.config")
  local loader = require("lazy.core.loader")
  local ok = pcall(loader.reload, config.plugins[name])

  if ok then
    print("Reloaded " .. name)
  end
end

return {
  exec_from = exec_from,
  reload = reload
}
