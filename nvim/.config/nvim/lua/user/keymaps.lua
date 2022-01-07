-- NVIM keymaps

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


-- keymap options
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Normal --
-- Toggle scrolloff
keymap("n", "<leader>vs", ":let &scrolloff=8-&scrolloff<CR>", opts)

-- Toggle sidescrolloff
keymap("n", "<leader>hs", ":let &sidescrolloff=8-&sidescrolloff<CR>", opts)

-- Clean search highlights
keymap("n", "<ESC>", ":noh<CR>", opts)

-- Turn off list hidden chars
keymap("n", "<leader>tl", ":set list!<CR>", opts) 

-- Navigate buffers
keymap("n", "<C-n>", ":bnext<CR>", opts)
keymap("n", "<C-p>", ":bprevious<CR>", opts)


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- When visual putting dont overwrite the register
keymap("v", "p", '"_dP', opts)


-- Command --
-- 2fast2save
vim.cmd [[ command WQ wq ]]
vim.cmd [[ command Wq wq ]]
vim.cmd [[ command W w ]]
vim.cmd [[ command Q q ]]
