-- Same as vimrc
vim.g.loaded_gzip         = 1
vim.g.loaded_man          = 1
vim.g.loaded_matchit      = 1
vim.g.loaded_matchparen   = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_tarPlugin    = 1
vim.g.loaded_tar          = 1
vim.g.loaded_zipPlugin    = 1
vim.g.loaded_zip          = 1
vim.g.loaded_netrwPlugin  = 1
vim.opt.encoding          = "UTF-8"
vim.opt.cursorline        = true
vim.opt.showmode          = true
vim.opt.hidden            = true
vim.opt.backup            = false
vim.opt.swapfile          = false
vim.opt.undofile          = false
vim.opt.splitright        = true
vim.opt.splitbelow        = true
vim.opt.incsearch         = true
vim.opt.hlsearch          = true
vim.opt.smartcase         = true
vim.opt.ignorecase        = true
vim.opt.autoindent        = true
vim.opt.smartindent       = true
vim.opt.showmatch         = true
vim.opt.laststatus        = 2
vim.opt.scrolloff         = 8
vim.opt.errorbells        = false
vim.opt.pastetoggle       = "<C-\\>"
vim.opt.completeopt       = "menu,menuone,noselect"

vim.cmd 'set nrformats-=octal'
vim.cmd 'au InsertLeave * set nopaste'
vim.cmd 'au FileType * set formatoptions-=cro'
vim.cmd 'au BufReadPost * lua goto_last_pos()'
vim.cmd 'au FileType yaml setlocal sw=0 sts=2 ts=2 et'

function goto_last_pos()
  local last_pos = vim.fn.line("'\"")
  if last_pos > 0 and last_pos <= vim.fn.line("$") then
    vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
  end
end

vim.opt.shiftwidth      = 0
vim.opt.softtabstop     = 2
vim.opt.tabstop         = 2
vim.opt.expandtab       = true

-- Lines below do not exist in vimrc
-- Config
vim.g.mapleader         = ' '

vim.opt.completeopt     = "menu,menuone,noselect"

vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.colorcolumn     = "80"
vim.opt.list            = true
vim.opt.listchars       = { tab = ">>>", trail = "·", precedes = "←", extends = "→", eol = "↲", nbsp = "␣" }
vim.opt.termguicolors   = true

-- Basic keymaps
local set_keymap        = vim.api.nvim_set_keymap

set_keymap('n', '<CR>', ':<C-u>w<CR>', { noremap = true, silent = true })
set_keymap('n', 'q', ':q<CR>', { noremap = true, silent = true })
set_keymap('n', 'Q', ':qa<CR>', { noremap = true, silent = true })
set_keymap('n', '<C-q>', 'q', { noremap = true, silent = true })
set_keymap('n', '<C-y>', '<C-v>', { noremap = true, silent = true })
set_keymap('n', 'U', '<C-r>', { noremap = true, silent = true })
set_keymap('n', 'vy', 'ggVG', { noremap = true, silent = true })
set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })
set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
set_keymap('n', 'H', '^', { noremap = true, silent = true })
set_keymap('n', 'L', '$', { noremap = true, silent = true })
set_keymap('v', 'H', '^', { noremap = true, silent = true })
set_keymap('v', 'L', '$', { noremap = true, silent = true })
set_keymap('n', ';', ':', { noremap = true, silent = false })
set_keymap('n', ':', 'm', { noremap = true, silent = true })
set_keymap('n', 'm', ';', { noremap = true, silent = true })
set_keymap('v', ';', ':', { noremap = true, silent = true })
set_keymap('v', ':', 'm', { noremap = true, silent = true })
set_keymap('v', 'm', ';', { noremap = true, silent = true })
