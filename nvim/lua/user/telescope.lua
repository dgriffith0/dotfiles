local M = {}

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local lga_status_ok, lga_actions = pcall(require, "telescope-live-grep-args.actions")
if not lga_status_ok then
  return
end

local options = {
  defaults = {
    mappings = {
      n = {
        ['<C-c>'] = require('telescope.actions').delete_buffer
      }, -- n
      i = {
        ['<C-c>'] = require('telescope.actions').delete_buffer
      } -- i
    },
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    live_grep_args = {
      auto_quoting = false, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {          -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  }
}

M.setup = function()
  telescope.setup(options)
  telescope.load_extension("ui-select")
  telescope.load_extension("live_grep_args")
end

return M
