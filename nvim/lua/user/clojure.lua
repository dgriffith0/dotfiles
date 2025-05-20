local M = {}

M.setup = function()
  local g = vim.g

  -- Breifly highlight evaluated forms
  g["conjure#highlight#enabled"] = true


  -- Disable goto definition (use lsp)
  g["conjure#mapping#def_word"] = false

  -- Disable the documentation mapping (use lsp)
  g["conjure#mapping#doc_word"] = false

  -- g["conjure#filetypes"] = { "clojure", "lua", "python" }

  local wk = require("which-key")

  local conjure_mapping = {
    { "<LocalLeader>c", group = "Connection",                          nowait = true,          remap = false },
    { "<LocalLeader>e", group = "Evaluate",                            nowait = true,          remap = false },
    { "<LocalLeader>g", group = "Go",                                  nowait = true,          remap = false },
    { "<LocalLeader>l", group = "REPL Log",                            nowait = true,          remap = false },
    { "<LocalLeader>r", group = "Reset REPL State",                    nowait = true,          remap = false },
    { "<LocalLeader>s", group = "REPL Session",                        nowait = true,          remap = false },
    { "<LocalLeader>t", group = "Test",                                nowait = true,          remap = false },
    { "<LocalLeader>v", group = "Value",                               nowait = true,          remap = false },
    { "<LocalLeader>x", group = "Macro",                               nowait = true,          remap = false },
    { "<LocalLeader>j", '<cmd>:Clj! -A:dev:test<cr>',                  desc = "Jackin",        nowait = true, remap = false },
    { "<LocalLeader>f", '<cmd>:Clj! -A:dev:test:storm<cr>',            desc = "Stormin",       nowait = true, remap = false },
    { "<LocalLeader>x", '<cmd>:Start! npx shadow-cljs watch main<cr>', desc = "Shadowin",      nowait = true, remap = false },
    { "<LocalLeader>u", '<cmd>:ConjureShadowSelect main<cr>',          desc = "Shadow Select", nowait = true, remap = false },
    { "<LocalLeader>q", '<cmd>:ConjureEval :cljs/quit<cr>',            desc = "Shadow Quit",   nowait = true, remap = false },
  }

  wk.add(conjure_mapping)
end

return M
