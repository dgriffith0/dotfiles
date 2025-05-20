local M = {}

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }


  for mode_name, mode_char in pairs(mappings) do
    wk.add(require('user.lsp.config').buffer_mappings[mode_name], { mode = mode_char, buffer = bufnr })
  end
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

local mappings = {
  { "K",  "<cmd>lua vim.lsp.buf.hover()<cr>",                                   desc = "Show Hover",          nowait = true, remap = false },
  { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>",                              desc = "Goto Definition",     nowait = true, remap = false },
  { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>",                             desc = "Goto Declaration",    nowait = true, remap = false },
  { "gr", "<cmd>lua require('telescope.builtin').lsp_references<cr>",           desc = "Goto References",     nowait = true, remap = false },
  { "gI", "<cmd>lua vim.lsp.buf.implementation()<cr>",                          desc = "Goto Implementation", nowait = true, remap = false },
  { "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>",                          desc = "Show Signature Help", nowait = true, remap = false },
  { "gp", "<cmd>function() require('user.lsp.peek').Peek 'definition' end<cr>", desc = "Peek Definition",     nowait = true, remap = false },
}

wk.add(mappings)

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

lspconfig.terraformls.setup {}

return M
