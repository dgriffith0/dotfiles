local M = {}

local options = {
  ensure_installed = { "lua", "rust", "wgsl_bevy"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  endwise = {
    enable = true
  },
}

M.setup = function()
  local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
  if not status_ok then
    return
  end

  treesitter.setup(options)
end

M.rust_function_surrounding_cursor = function()
  local prev_function_node = nil
  local prev_function_name = nil

  local ts_utils = require('nvim-treesitter.ts_utils')
  local current_node = ts_utils.get_node_at_cursor()

  if not current_node then
    return ""
  end

  local func = current_node

  while func do
    if func:type() == 'function_item' then
      break
    end

    func = func:parent()
  end

  if not func then
    prev_function_node = nil
    prev_function_name = ""
    return ""
  end

  if func == prev_function_node then
    return prev_function_name
  end

  prev_function_node = func

  local find_name
  find_name = function(node)
    for i = 0, node:named_child_count() - 1, 1 do
      local child = node:named_child(i)
      local type = child:type()

      if type == 'identifier' or type == 'operator_name' then
        return (ts_utils.get_node_text(child))[1]
      else
        local name = find_name(child)

        if name then
          return name
        end
      end
    end

    return nil
  end

  prev_function_name = find_name(func)
  return prev_function_name
end

return M
