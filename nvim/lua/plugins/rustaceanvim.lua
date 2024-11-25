vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      require('user.lsp').common_on_attach()
      local lsp_status = require('lsp-status')
      lsp_status.register_progress()
      vim.keymap.set("n", "<S-k>", ":RustLsp hover actions<cr>", { buffer = bufnr })
    end,
    default_settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = "clippy"
        },
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        tools = {
          enable_clippy = true,
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        diagnostics = {
          disabled = { "unresolved-proc-macro" },
        },

      },
    },
  },
}

return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false,   -- This plugin is already lazy
}
