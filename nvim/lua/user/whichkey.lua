local M = {}

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  { "<leader>F",  "<cmd>Telescope live_grep theme=ivy<cr>",                                             desc = "Find Text",             nowait = true, remap = false },
  { "<leader>T",  group = "Treesitter",                                                                 nowait = true,                  remap = false },
  { "<leader>Tc", ":TSConfigInfo<cr>",                                                                  desc = "Config Info",           nowait = true, remap = false },
  { "<leader>Ti", ":Inspect<cr>",                                                                       desc = "Inspect",               nowait = true, remap = false },
  { "<leader>Tq", ":EditQuery",                                                                         desc = "Edit Query",            nowait = true, remap = false },
  { "<leader>Tt", ":InspectTree<cr>",                                                                   desc = "Inspect Tree",          nowait = true, remap = false },
  { "<leader>Tu", ":TSUpdate<cr>",                                                                      desc = "Update",                nowait = true, remap = false },
  { "<leader>a",  "<cmd>lua vim.lsp.buf.code_action()<cr>",                                             desc = "Code Action",           nowait = true, remap = false },
  { "<leader>b",  "<cmd>lua require('telescope.builtin').buffers()<cr>",                                desc = "Buffers",               nowait = true, remap = false },
  { "<leader>c",  "<cmd>bp|bd #<CR>",                                                                   desc = "Close Buffer",          nowait = true, remap = false },
  { "<leader>d",  group = "Debug",                                                                      nowait = true,                  remap = false },
  { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>",                                          desc = "Run To Cursor",         nowait = true, remap = false },
  { "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>",                                 desc = "Toggle UI",             nowait = true, remap = false },
  { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>",                                              desc = "Step Back",             nowait = true, remap = false },
  { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",                                               desc = "Continue",              nowait = true, remap = false },
  { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>",                                             desc = "Disconnect",            nowait = true, remap = false },
  { "<leader>dg", "<cmd>lua require'dap'.session()<cr>",                                                desc = "Get Session",           nowait = true, remap = false },
  { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",                                              desc = "Step Into",             nowait = true, remap = false },
  { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",                                              desc = "Step Over",             nowait = true, remap = false },
  { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>",                                                  desc = "Pause",                 nowait = true, remap = false },
  { "<leader>dq", "<cmd>lua require'dap'.close()<cr>",                                                  desc = "Quit",                  nowait = true, remap = false },
  { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",                                            desc = "Toggle Repl",           nowait = true, remap = false },
  { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",                                      desc = "Toggle Breakpoint",     nowait = true, remap = false },
  { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>",                                               desc = "Step Out",              nowait = true, remap = false },
  { "<leader>e",  "<cmd>Explore<cr>",                                                                   desc = "File Explorer",         nowait = true, remap = false },
  { "<leader>f",  "<cmd>lua require('user.custom-finders').find_from_project()<cr>",                    desc = "Find Files",            nowait = true, remap = false },
  { "<leader>g",  group = "Git",                                                                        nowait = true,                  remap = false },
  { "<leader>gP", "<cmd>Neogit push<cr>",                                                               desc = "Push",                  nowait = true, remap = false },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>",                                                    desc = "Checkout branch",       nowait = true, remap = false },
  { "<leader>gc", "<cmd>Neogit commit<cr>",                                                             desc = "Commit",                nowait = true, remap = false },
  { "<leader>gd", "<cmd>DiffviewOpen<cr>",                                                              desc = "Diff View",             nowait = true, remap = false },
  { "<leader>gg", "<cmd>Neogit<cr>",                                                                    desc = "Neogit",                nowait = true, remap = false },
  { "<leader>gp", "<cmd>Neogit pull<cr>",                                                               desc = "Pull",                  nowait = true, remap = false },
  { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<cr>",                                        desc = "Toggle Blame",          nowait = true, remap = false },
  { "<leader>h",  "<cmd>nohlsearch<cr>",                                                                desc = "No Highlight",          nowait = true, remap = false },
  { "<leader>j",  group = "Jump",                                                                       nowait = true,                  remap = false },
  { "<leader>j1", "<cmd>lua require'harpoon':list():select(1)<cr>",                                     desc = "1",                     nowait = true, remap = false },
  { "<leader>j2", "<cmd>lua require'harpoon':list():select(2)<cr>",                                     desc = "2",                     nowait = true, remap = false },
  { "<leader>j3", "<cmd>lua require'harpoon':list():select(3)<cr>",                                     desc = "3",                     nowait = true, remap = false },
  { "<leader>j4", "<cmd>lua require'harpoon':list():select(4)<cr>",                                     desc = "4",                     nowait = true, remap = false },
  { "<leader>jj", "<cmd>lua require'harpoon':list():append()<cr>",                                      desc = "Append",                nowait = true, remap = false },
  { "<leader>jl", "<cmd>lua require('user.custom-finders').harpoon_list(require 'harpoon':list())<cr>", desc = "List",                  nowait = true, remap = false },
  { "<leader>jn", "<cmd>lua require'harpoon':list():prev()<cr>",                                        desc = "Previous",              nowait = true, remap = false },
  { "<leader>jp", "<cmd>lua require'harpoon':list():next()<cr>",                                        desc = "Next",                  nowait = true, remap = false },
  { "<leader>l",  group = "LSP",                                                                        nowait = true,                  remap = false },
  { "<leader>lI", "<cmd>Mason<cr>",                                                                     desc = "Mason Info",            nowait = true, remap = false },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",                                   desc = "Workspace Symbols",     nowait = true, remap = false },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",                                             desc = "Code Action",           nowait = true, remap = false },
  { "<leader>ld", "<cmd>Telescope lsp_document_diagnostics<cr>",                                        desc = "Document Diagnostics",  nowait = true, remap = false },
  { "<leader>le", "<cmd>Telescope quickfix<cr>",                                                        desc = "Telescope Quickfix",    nowait = true, remap = false },
  { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>",                                    desc = "Format",                nowait = true, remap = false },
  { "<leader>li", "<cmd>LspInfo<cr>",                                                                   desc = "Info",                  nowait = true, remap = false },
  { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",                                        desc = "Next Diagnostic",       nowait = true, remap = false },
  { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",                                        desc = "Prev Diagnostic",       nowait = true, remap = false },
  { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",                                                desc = "CodeLens Action",       nowait = true, remap = false },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                                                  desc = "Rename",                nowait = true, remap = false },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",                                            desc = "Document Symbols",      nowait = true, remap = false },
  { "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>",                                       desc = "Workspace Diagnostics", nowait = true, remap = false },
  { "<leader>q",  desc = "Quickfix",                                                                    nowait = true,                  remap = false },
  { "<leader>s",  group = "Search",                                                                     nowait = true,                  remap = false },
  { "<leader>sC", "<cmd>Telescope commands<cr>",                                                        desc = "Commands",              nowait = true, remap = false },
  { "<leader>sH", "<cmd>Telescope highlights<cr>",                                                      desc = "Find highlight groups", nowait = true, remap = false },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                                       desc = "Man Pages",             nowait = true, remap = false },
  { "<leader>sR", "<cmd>Telescope registers<cr>",                                                       desc = "Registers",             nowait = true, remap = false },
  { "<leader>sb", "<cmd>Telescope git_branches<cr>",                                                    desc = "Checkout branch",       nowait = true, remap = false },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>",                                                       desc = "Find Help",             nowait = true, remap = false },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                                         desc = "Keymaps",               nowait = true, remap = false },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>",                                                        desc = "Open Recent File",      nowait = true, remap = false },
  { "<leader>t",  group = "Terminal",                                                                   nowait = true,                  remap = false },
  { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",                                                desc = "Float",                 nowait = true, remap = false },
  { "<leader>th", "<cmd>ToggleTerm size=50 direction=horizontal<cr>",                                   desc = "Horizontal",            nowait = true, remap = false },
  { "<leader>tt", "<cmd>ToggleTermToggleAll<cr>",                                                       desc = "Toggle All",            nowait = true, remap = false },
  { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",                                     desc = "Vertical",              nowait = true, remap = false },
  { "<leader>u",  group = "Copilot",                                                                    nowait = true,                  remap = false },
  { "<leader>ur", ":CopilotChatReset<cr>",                                                              desc = "Reset Chat",            nowait = true, remap = false },
  { "<leader>uu", ":CopilotChatToggle<cr>",                                                             desc = "Toggle Chat",           nowait = true, remap = false },
  { "<leader>v",  group = "Vim",                                                                        nowait = true,                  remap = false },
  { "<leader>vc", "<cmd>lua require('user.custom-finders').find_config_files()<cr>",                    desc = "Configs",               nowait = true, remap = false },
  { "<leader>vd", ":exec &bg=='light'? 'set bg=dark' : 'set bg=light'<CR>",                             desc = "Dark/Light Mode",       nowait = true, remap = false },
  { "<leader>vq", "<cmd>wqa<CR>",                                                                       desc = "Save & Quit",           nowait = true, remap = false },
  { "<leader>vr", "<cmd>lua reload_nvim_conf()<cr>",                                                    desc = "Reload",                nowait = true, remap = false },
  { "<leader>vt", "<cmd>Telescope colorscheme {enable_preview=true}<cr>",                               desc = "Theme",                 nowait = true, remap = false },
  { "<leader>vw", "<cmd>wa<CR>",                                                                        desc = "Save All",              nowait = true, remap = false },
  { "<leader>x",  group = "Trouble",                                                                    nowait = true,                  remap = false },
  { "<leader>xR", "<cmd>Trouble lsp_references<cr>",                                                    desc = "LSP References",        nowait = true, remap = false },
  { "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",                                              desc = "Document Diagnostics",  nowait = true, remap = false },
  { "<leader>xl", "<cmd>Trouble loclist<cr>",                                                           desc = "Location List",         nowait = true, remap = false },
  { "<leader>xq", "<cmd>Trouble quickfix<cr>",                                                          desc = "Quick Fix",             nowait = true, remap = false },
  { "<leader>xt", "<cmd>TodoTrouble<cr>",                                                               desc = "Todos",                 nowait = true, remap = false },
  { "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",                                             desc = "Workspace Diagnostics", nowait = true, remap = false },
  { "<leader>xx", "<cmd>Trouble<cr>",                                                                   desc = "Trouble",               nowait = true, remap = false },
  { "<localleader>f", '<cmd>!janet -e "(import spork/fmt) (fmt/format-file \\"%\\")"<cr>',              desc = "Format",                nowait = true, remap = false },
  { "<localleader>cn",'<cmd>:te janet -e "(import spork/netrepl) (netrepl/server)"<cr>',                   desc = "Netrepl",               nowait = true, remap = false },
}

M.setup = function()
  wk.setup()
  wk.add(mappings)
end

return M