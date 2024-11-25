local M = {}

-- M.theme = 'tokyonight-night'
-- M.theme = 'gruvbox'
M.theme = 'catppuccin'

vim.o.background = "dark"
-- vim.o.background = "light"
-- vim.g.tokyonight_style = "night"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. M.theme)
if not status_ok then
  vim.notify("colorscheme " .. M.theme .. " not found!")
  return
end

return M
