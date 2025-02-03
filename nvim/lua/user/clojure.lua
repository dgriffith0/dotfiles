local M = {}

M.setup = function()
  local g = vim.g

  -- Breifly highlight evaluated forms
  g["conjure#highlight#enabled"] = true

  g["conjure#filetypes"] = { "clojure", "lua", "python" }

  local wk = require("which-key")

  local conjure_mapping = {
    { "<LocalLeader>c",  group = "Connection",                           nowait = true,          remap = false },
    { "<LocalLeader>e",  group = "Evaluate",                             nowait = true,          remap = false },
    { "<LocalLeader>g",  group = "Go",                                   nowait = true,          remap = false },
    { "<LocalLeader>l",  group = "REPL Log",                             nowait = true,          remap = false },
    { "<LocalLeader>r",  group = "Reset REPL State",                     nowait = true,          remap = false },
    { "<LocalLeader>s",  group = "REPL Session",                         nowait = true,          remap = false },
    { "<LocalLeader>t",  group = "Test",                                 nowait = true,          remap = false },
    { "<LocalLeader>v",  group = "Value",                                nowait = true,          remap = false },
    { "<LocalLeader>j",  group = "Jackin",                               nowait = true,          remap = false },
    { "<LocalLeader>x",  group = "Macro",                                nowait = true,          remap = false },
    { "<LocalLeader>jj", '<cmd>:Clj! -A:dev:test<cr>',                   desc = "Jackin",        nowait = true, remap = false },
    { "<LocalLeader>jx", '<cmd>:Start! npx shadow-cljs watch main<cr>',  desc = "ShadIn",        nowait = true, remap = false },
    { "<LocalLeader>jf", '<cmd>:ConjureClientState default<cr>',         desc = "Clj State",     nowait = true, remap = false },
    { "<LocalLeader>jc", '<cmd>:ConjureClientState shadow<cr>',          desc = "Shadow State",  nowait = true, remap = false },
    { "<LocalLeader>jv", '<cmd>:ConjureShadowSelect main<cr>',           desc = "Shadow Select", nowait = true, remap = false },
  }

  wk.add(conjure_mapping)
end

return M
