-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set_keymap = vim.keymap.set

set_keymap("n", "<CR>", ":<C-u>w<CR>", { noremap = true, silent = true })
set_keymap("n", "q", function()
  Snacks.bufdelete()
end, { noremap = true, silent = true })
set_keymap("n", "Q", ":qa<CR>", { noremap = true, silent = true })
set_keymap("n", "<C-q>", "q", { noremap = true, silent = true })
set_keymap("n", "<C-y>", "<C-v>", { noremap = true, silent = true })
set_keymap("n", "vy", "ggVG", { noremap = true, silent = true })
set_keymap("n", "U", "<C-r>", { noremap = true, silent = true })
set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Disable C-h/j/k/l navigation
-- NOTE: I can assign theme keys to  some other functionality later
set_keymap("n", "<C-h>", "<Nop>", { noremap = true, silent = true })
set_keymap("n", "<C-j>", "<Nop>", { noremap = true, silent = true })
set_keymap("n", "<C-k>", "<Nop>", { noremap = true, silent = true })
set_keymap("n", "<C-l>", "<Nop>", { noremap = true, silent = true })

-- Window resize
set_keymap("n", "<C-Home>", ":vertical resize -5<CR>", { noremap = true, silent = true })
set_keymap("n", "<C-End>", ":vertical resize +5<CR>", { noremap = true, silent = true })
set_keymap("n", "<C-PageUp>", ":resize -5<CR>", { noremap = true, silent = true })
set_keymap("n", "<C-PageDown>", ":resize +5<CR>", { noremap = true, silent = true })
