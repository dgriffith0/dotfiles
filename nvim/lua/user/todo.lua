local M = {}

local ok, todo = pcall(require, 'todo-comments')

if not ok then
  return
end

local options = {
}

M.setup = function()
  todo.setup(options)
end

return M

