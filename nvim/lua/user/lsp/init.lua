local M = {}

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    return
  end

  for mode_name, mode_char in pairs(mappings) do
    wk.register(require('user.lsp.config').buffer_mappings[mode_name], { mode = mode_char, buffer = bufnr })
  end
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

M.common_on_attach = function(client, bufnr)
  -- vim.lsp.inlay_hint.enable(true)
  add_lsp_buffer_keybindings(bufnr)
end

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
      },
    },
  },
}

lspconfig.clojure_lsp.setup {}

lspconfig.pyright.setup {}

lspconfig.wgsl_analyzer.setup {}

return M
