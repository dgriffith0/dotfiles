local M = {}

local _, themes = pcall(require, "telescope.themes")
local _, builtin = pcall(require, "telescope.builtin")
local conf = require("telescope.config").values

function M.find_config_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ Nvim Config Files",
    cwd = get_config_dir()
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.find_files(opts)
end

M.find_from_project = function(opts)
  opts = opts or {}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    -- if not git then active lsp client root
    -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
    local active_clients = vim.lsp.get_clients()
    if #active_clients == 0 then
      opts.cwd = vim.fn.getcwd()
    else
      opts.cwd = vim.lsp.get_clients()[1].config.root_dir
    end
  end
  builtin.find_files(opts)
end

M.harpoon_list = function(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

return M
