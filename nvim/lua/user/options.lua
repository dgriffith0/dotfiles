local options = {
  -- Core
  backup = false,                          -- creates a backup file
  undofile = true,                         -- enable persistent undo
  swapfile = false,                        -- creates a swapfile
  fileencoding = "utf-8",                  -- the encoding written to a file
  termguicolors = true,                    -- set term gui colors, mandatory for most plugins (most terminals support this, if yours doesn't, e.g. tty, just use vim)
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  clipboard = "unnamedplus",               -- use system clipboard
  -- mouse = "a",                             -- allow the mouse to be used in all modes
  -- UI
  guifont = "Fira Code:h12",               -- the font used in graphical neovim applications
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  -- completeopt = { "menu", "menuone", "noinsert" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  pumheight = 10,                          -- pop up menu height
  wrap = false,                            -- display lines as one long line
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  showtabline = 0,                         -- hide show tabs
  numberwidth = 4,                         -- set number column width to 2 (default 4)
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  number = true,                           -- set numbered lines
  relativenumber = true,                  -- set relative numbered lines
  cursorline = true,                       -- highlight the current line
  -- Search
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- don't ignore if there's uppercase
  -- Indent
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  smartindent = true,                      -- make indenting smarter again
  -- Other
  scrolloff = 8,                           -- scroll vertically when the cursor is <8 columns from the end
  sidescrolloff = 8,                       -- horizontally
  whichwrap = "bs<>[]hl",                  -- which "horizontal" keys are allowed to travel to prev/next line, see :help 'whichwrap'
  colorcolumn = "80",
}

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.shortmess:append("c") -- don't give Ctrl-P,Ctrl-N messages
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- to separate vim plugins from neovim on Arch
vim.opt.iskeyword:remove("-") -- treat a-word, word- as one w
vim.opt.showtabline = 0
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.guifont = { "Fira Code:h10" }

-- vim.notify = require("notify")
