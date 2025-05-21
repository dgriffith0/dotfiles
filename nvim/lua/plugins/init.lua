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
    -- version = "1.11.0",
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
    version = "*", 
    config = function()
      require("nvim-surround").setup(
      )
    end
  },
  {
    "folke/noice.nvim",
    event = "BufRead",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
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
  { "mfussenegger/nvim-lint" },
  { "rshkarin/mason-nvim-lint" },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  }
  -- FORMATTER ALTERNATIVE
  -- {
  --   'stevearc/conform.nvim',
  --   opts = {},
  --   config = function()
  --     require("conform").setup({
  --       formatters_by_ft = {
  --         lua = { lsp_format = "fallback" },
  --         python = { "isort", "black" },
  --         rust = { "rustfmt", lsp_format = "fallback" },
  --         clojure = { "cljfmt", lsp_format = "fallback" }
  --       },
  --     })
  --   end
  --
  -- },
}

return plugins
