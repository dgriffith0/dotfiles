local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--Tmux Navigation
keymap("n", "<C-h>", '<cmd>lua require("tmux").move_left()<cr>')
keymap("n", "<C-j>", '<cmd>lua require("tmux").move_bottom()<cr>')
keymap("n", "<C-k>", '<cmd>lua require("tmux").move_top()<cr>')
keymap("n", "<C-l>", '<cmd>lua require("tmux").move_right()<cr>')

keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)

-- -- Telescope --
-- keymap("n", "<C-f>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<C-f>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)

--Harpoon
keymap("n", "<A-1>", ":lua require'harpoon':list():select(1)<cr>", opts)
keymap("n", "<A-2>", ":lua require'harpoon':list():select(2)<cr>", opts)
keymap("n", "<A-3>", ":lua require'harpoon':list():select(3)<cr>", opts)
keymap("n", "<A-4>", ":lua require'harpoon':list():select(4)<cr>", opts)
keymap("n", "<C-e>", ":lua require'harpoon'.ui:toggle_quick_menu(require'harpoon':list())<cr>", opts)
