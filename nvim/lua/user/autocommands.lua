local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

local mkdir = api.nvim_create_augroup("Mkdir", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  command = 'call mkdir(expand("<afile>:p:h"), "p")',
  group = mkdir,
})

function _G.reload_nvim_conf()
  for name, _ in pairs(package.loaded) do
    if name:match('^user') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  desc = "Whichkey rust localleader bindings",
  pattern = { "*.rs", "*.toml" },
  callback = function(_)
    local bufnr = vim.api.nvim_get_current_buf()
    local wk = require("which-key")
    wk.add(
      {
        { "<localleader>",  buffer = bufnr,                          group = "Rust", remap = false },
        { "<localleader>,", "<cmd>:Start! cargo run<cr>",            buffer = bufnr, desc = "Run",                remap = false },
        { "<localleader>.", "<cmd>lua SlimeCargoTestFunction()<cr>", buffer = bufnr, desc = "Run Test at Cursor", remap = false },
        { "<localleader>b", ":SlimeSend1 cargo build<cr>",           buffer = bufnr, desc = "Build",              remap = false },
        { "<localleader>r", ":RustLsp runnables<cr>",                buffer = bufnr, desc = "Runnables",          remap = false },
        { "<localleader>d", ":RustLsp debuggables<cr>",              buffer = bufnr, desc = "debuggables",        remap = false },
        { "<localleader>t", ":RustLsp testables<cr>",                buffer = bufnr, desc = "Testables",          remap = false },
        { "<localleader>u", ":SlimeSend1 cargo update<cr>",          buffer = bufnr, desc = "Update",             remap = false },
      }
    )
  end
})

vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", { clear = true }),
  pattern = { "conjure-log-*" },
  callback = function() vim.diagnostic.enable(false) end,
  desc = "Conjure Log disable LSP diagnostics",
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
