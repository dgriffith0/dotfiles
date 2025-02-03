vim.g.rustaceanvim = function()
  local mason_registry = require('mason-registry')
  local codelldb = mason_registry.get_package("codelldb")
  local extension_path = codelldb:get_install_path() .. "/extension/"

  -- local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb'

  local this_os = vim.uv.os_uname().sysname;
  -- The path is different on Windows
  if this_os:find "Windows" then
    codelldb_path = extension_path .. "adapter\\codelldb.exe"
    liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
  else
    -- The liblldb extension is .so for Linux and .dylib for MacOS
    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
  end

  local cfg = require('rustaceanvim.config')

  -- local dap = require('dap')
  -- local codelldb_adapter_config = {
  --   type = "executable",
  --   command = codelldb_path, -- or if not in $PATH: "/absolute/path/to/codelldb"
  --   args = { '--liblldb', liblldb_path }
  --
  --   -- On windows you may have to uncomment this:
  --   -- detached = false,
  -- }

  return {
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
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
              group = "module"
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
end

return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false,   -- This plugin is already lazy
}
