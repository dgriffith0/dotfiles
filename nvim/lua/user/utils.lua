local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"

---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end


function _G.get_runtime_dir()
    return vim.call("stdpath", "data")
end

function _G.get_config_dir()
    return vim.call("stdpath", "config")
end

function _G.get_cache_dir()
    return vim.call("stdpath", "cache")
end
