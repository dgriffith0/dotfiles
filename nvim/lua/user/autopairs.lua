local M = {}

local status_ok, npairs = pcall(require, "nvim-autopairs")
local cond = require('nvim-autopairs.conds')

if not status_ok then
  return
end

local options = {
  check_ts = true,
  enable_check_bracket_line = false,
}

M.setup = function()
  npairs.setup(options)

  -- npairs.get_rules("'")[1].not_filetypes = { "clojure", "scheme", "lisp" }
  -- npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))
end

return M
