-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set_keymap = vim.keymap.set

set_keymap("n", "<CR>", ":<C-u>w<CR>", { noremap = true, silent = true })
set_keymap("n", "q", ":q<CR>", { noremap = true, silent = true })
set_keymap("n", "Q", ":qa<CR>", { noremap = true, silent = true })
set_keymap("n", "<C-q>", "q", { noremap = true, silent = true })
set_keymap("n", "<C-y>", "<C-v>", { noremap = true, silent = true })
set_keymap("n", "vy", "ggVG", { noremap = true, silent = true })
set_keymap("n", "U", "<C-r>", { noremap = true, silent = true })
set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
