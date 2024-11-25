local M = {}

local status_cmp_ok, cmp = pcall(require, "cmp")
if not status_cmp_ok or cmp == nil then
  return
end
local compare = require('cmp.config.compare')

local WIDE_HEIGHT = 40

local status_luasnip_ok, luasnip = pcall(require, "luasnip")
if not status_luasnip_ok then
  return
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local options = {
  view = {
    entries = {
      vertical_position = 'above'
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  completion = {
    ---@usage The minimum length of a word to complete on.
    keyword_length = 1,
    completeopt = 'menu,menuone,noinsert'
  },
  experimental = {
    ghost_text = true,
    -- native_menu = false,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    max_width = 0,
    kind_icons = {
      Class = " ",
      Color = " ",
      Constant = "ﲀ ",
      Constructor = " ",
      Enum = "練",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = "",
      Folder = " ",
      Function = " ",
      Interface = "ﰮ ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Operator = "",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = "塞",
      Value = " ",
      Variable = " ",
      Copilot = "",
    },
    source_names = {
      nvim_lsp = "(LSP)",
      emoji = "(Emoji)",
      path = "(Path)",
      calc = "(Calc)",
      vsnip = "(Snippet)",
      luasnip = "(Snippet)",
      buffer = "(Buffer)",
      tmux = "(TMUX)",
      copilot = "(Copilot)",
    },
    duplicates = {
      buffer = 1,
      path = 1,
      nvim_lsp = 0,
      luasnip = 1,
    },
    duplicates_default = 0,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      border = { '', '', '', '', '', '', '', '' },
      winhighlight = 'FloatBorder:FloatBorder',
      winblend = vim.o.pumblend,
      scrolloff = 0,
      zindex = 999,
      col_offset = 0,
      side_padding = 20,
      scrollbar = true,
    },
    documentation = {
      max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
      max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
      zindex = 1000,
      border = { '', '', '', ' ', '', '', '', ' ' },
      winhighlight = 'FloatBorder:FloatBorder',
      winblend = vim.o.pumblend,
    },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
    { name = "treesitter" },
    { name = "crates" },
    { name = "tmux" },
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" })
  },
  sorting = {
    comparators = {
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      require("cmp-under-comparator").under,
      compare.kind,
    },
  }
}

M.setup = function()
  -- hide copilot suggestions when cmp menu is open
  -- to prevent odd behavior/garbled up suggestions
  cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
  end)

  cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
  end)

  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
  cmp.setup(options)
end

return M
