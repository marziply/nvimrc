function exec_from(path, fn)
  local mod = require(path)

  return fn(mod)
end

return {
  exec_from = exec_from
}
