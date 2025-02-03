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
        { "<localleader>,", ":SlimeSend1 cargo run<cr>",             buffer = bufnr, desc = "Run",                remap = false },
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
