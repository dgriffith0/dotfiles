local plugins = {
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
      require('user.telescope').setup()
    end
  },
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require('user.whichkey').setup()
    end,
    dependencies = "echasnovski/mini.nvim",
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("user.todo").setup()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    event = "BufRead",
    config = function()
      require('user.lualine').setup()
    end
  },
  {
    'numToStr/Comment.nvim',
    event = "BufRead",
    config = function()
      require('Comment').setup()
    end
  },
  --Completions
  { "lukas-reineke/cmp-under-comparator" },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { "saadparwaiz1/cmp_luasnip" },
  --LSP
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    "williamboman/mason.nvim",
    config = function()
      require('user.mason').setup()
    end
  },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'black',
          'debugpy',
          'flake8',
          'isort',
          'mypy',
          'pylint',
        }
      })
    end
  },
  { 'nvim-lua/lsp-status.nvim' },
  --Snippets
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },
  -- Language Parser / Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('user.treesitter').setup()
    end
  },
  { 'RRethy/nvim-treesitter-endwise' },
  { 'HiPhish/rainbow-delimiters.nvim' },
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup()
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require('trouble').setup()
    end
  },
  { 'rcarriga/nvim-notify' },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup(
      -- Configuration here, or leave empty to use defaults
      )
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    'jpalardy/vim-slime',
    event = "VeryLazy",
    init = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_paste_file = vim.fn.expand("$HOME/.slime_paste")
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_default_config = {
        socket_name = vim.fn.get(vim.fn.split(vim.env.TMUX, ","), 0),
        target_pane = ":.1",
      }
      vim.g.slime_dont_ask_default = 1
    end
  },
  {
    "folke/noice.nvim",
    event = "BufRead",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    "NeogitOrg/neogit",
    event = "BufRead",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup()
    end
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require('copilot').setup({
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         hide_during_completion = true,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<M-l>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<M-]>",
  --           prev = "<M-[>",
  --           dismiss = "<C-]>",
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   branch = "canary",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
  --     { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
  --   },
  --   opts = {
  --     debug = true, -- Enable debugging
  --     -- See Configuration section for rest
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },
  { "mfussenegger/nvim-lint" },
  { "rshkarin/mason-nvim-lint" },
  { "akinsho/toggleterm.nvim", version = "*", config = true }
}

return plugins
