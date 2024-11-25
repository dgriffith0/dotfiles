function SlimeCargoTestFunction()
  local function_name = require("user.treesitter").rust_function_surrounding_cursor()
  vim.cmd("SlimeSend1 cargo test " .. function_name .. " -- --nocapture")
end

vim.api.nvim_create_user_command('SlimeTest', "lua SlimeCargoTestFunction()", {})
