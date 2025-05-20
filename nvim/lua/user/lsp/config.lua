local skipped_servers = {
  "angularls",
  "ansiblels",
  "ccls",
  "csharp_ls",
  "cssmodules_ls",
  "denols",
  "ember",
  "emmet_ls",
  "eslint",
  "eslintls",
  "golangci_lint_ls",
  "graphql",
  "jedi_language_server",
  "ltex",
  "ocamlls",
  "phpactor",
  "psalm",
  "pylsp",
  "quick_lint_js",
  "rome",
  "reason_ls",
  "scry",
  "solang",
  "solidity_ls",
  "sorbet",
  "sourcekit",
  "sourcery",
  "spectral",
  "sqlls",
  "sqls",
  "stylelint_lsp",
  "tailwindcss",
  "tflint",
  "verible",
  "vuels",
}

local skipped_filetypes = { "markdown", "rst", "plaintext" }

return {
  templates_dir = join_paths(get_runtime_dir(), "site", "after", "ftplugin"),
  diagnostics = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      format = function(d)
        local t = vim.deepcopy(d)
        local code = d.code or (d.user_data and d.user_data.lsp.code)
        if code then
          t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
        end
        return t.message
      end,
    },
  },
  document_highlight = true,
  code_lens_refresh = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
  },
  peek = {
    max_height = 15,
    max_width = 30,
    context = 10,
  },
  on_attach_callback = nil,
  on_init_callback = nil,
  automatic_servers_installation = true,
  automatic_configuration = {
    ---@usage list of servers that the automatic installer will skip
    skipped_servers = skipped_servers,
    ---@usage list of filetypes that the automatic installer will skip
    skipped_filetypes = skipped_filetypes,
  },
  buffer_mappings = {
    normal_mode = {
      { "K",  "<cmd>lua vim.lsp.buf.hover()<cr>",                                   desc = "Show Hover",          nowait = true, remap = false },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>",                              desc = "Goto Definition",     nowait = true, remap = false },
      { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>",                             desc = "Goto Declaration",    nowait = true, remap = false },
      { "gr", "<cmd>lua require('telescope.builtin').lsp_references<cr>",           desc = "Goto References",     nowait = true, remap = false },
      { "gI", "<cmd>lua vim.lsp.buf.implementation()<cr>",                          desc = "Goto Implementation", nowait = true, remap = false },
      { "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>",                          desc = "Show Signature Help", nowait = true, remap = false },
      { "gp", "<cmd>function() require('user.lsp.peek').Peek 'definition' end<cr>", desc = "Peek Definition",     nowait = true, remap = false },
      -- ["K"] = { vim.lsp.buf.hover, "Show hover" },
      -- ["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
      -- ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
      -- ["gr"] = { vim.lsp.buf.references, "Goto references" },
      -- ["gr"] = { require('telescope.builtin').lsp_references, "Goto references" },
      -- ["gI"] = { vim.lsp.buf.implementation, "Goto Implementation" },
      -- ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
      -- ["gp"] = {
      --   function()
      --     require("user.lsp.peek").Peek "definition"
      --   end,
      --   "Peek definition",
      -- },
      ["gl"] = {
        function()
          local config = require('config').diagnostics.float
          config.scope = "line"
          vim.diagnostic.open_float(0, config)
        end,
        "Show line diagnostics",
      },
    },
    insert_mode = {},
    visual_mode = {},
  },
}
