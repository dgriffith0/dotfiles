local M = {}

local status_ok, npairs = pcall(require, "nvim-autopairs")

if not status_ok then
  return
end

local options = {
  check_ts = true
}

M.setup = function()
  npairs.setup(options)
end

return M
