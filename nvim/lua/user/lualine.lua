local M = {}

local status_ok, lualine = pcall(require, 'lualine')

if not status_ok then
  print("Unable to load luiline")
  return
end

local display_lsp_status = function()
  -- if #vim.lsp.buf_get_clients() == 0 then return '' end
  local status = require 'lsp-status'.status()
  if status == '' then return '' end
  status = string.gsub(status, '%(', '') -- get rid of opening paren
  status = string.gsub(status, 'ʪ ', '') -- get rid of ls symbol so we can add it on a lualine component level
  status = string.gsub(status, '%)', '') -- get rid of closing paren
  status = string.gsub(status, "^%s*(.-)%s*$", "%1") -- trim
  return status
end

local options = {
  options = { theme = 'tokyonight'
  -- require('user.colorscheme').theme 
},
}
options.sections = {
   lualine_c = {
    {
               'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }
  },
  lualine_x = { { display_lsp_status, icon = { 'ʪ' } }, 'tabs', 'fileformat', 'filetype' },
}

M.setup = function()
  lualine.setup(options)
end

return M
