local set_keymap = vim.api.nvim_set_keymap
-- Basic
set_keymap('n', '<CR>', ':<C-u>w<CR>', { noremap = true, silent = false})
set_keymap('n', 'q', ':q<CR>',         { noremap = true, silent = true})
set_keymap('n', 'Q', ':qa<CR>',        { noremap = true, silent = false})
set_keymap('n', '<C-y>', '<C-v>',      { noremap = true, silent = false})
set_keymap('n', 'U', '<C-r>',          { noremap = true, silent = false})
set_keymap('n', 'vy', 'ggVG',          { noremap = true, silent = false})
set_keymap('n', 'j', 'gj',             { noremap = true, silent = false})
set_keymap('n', 'k', 'gk',             { noremap = true, silent = false})
set_keymap('n', 'H', '^',              { noremap = true, silent = false})
set_keymap('n', 'L', '$',              { noremap = true, silent = false})
set_keymap('v', 'H', '^',              { noremap = true, silent = false})
set_keymap('v', 'L', '$',              { noremap = true, silent = false})
set_keymap('n', ';', ':',              { noremap = true, silent = false})
set_keymap('n', ':', 'm',              { noremap = true, silent = false})
set_keymap('n', 'm', ';',              { noremap = true, silent = false})
set_keymap('v', ';', ':',              { noremap = true, silent = false})
set_keymap('v', ':', 'm',              { noremap = true, silent = false})
set_keymap('v', 'm', ';',              { noremap = true, silent = false})

-- EasyMotion
set_keymap('n', ',', '<Plug>(easymotion-s)', {noremap = false, silent = false})

-- EasyAlign
set_keymap('n', 'ga', '<Plug>(EasyAlign)', {noremap = false, silent = false})
set_keymap('x', 'ga', '<Plug>(EasyAlign)', {noremap = false, silent = false})

-- Commentary
set_keymap('n', 'gc', ':<C-u>Commentary<CR>', {noremap = true, silent = true})

-- Fterm
set_keymap('n', '<C-q>', '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
set_keymap('t', '<C-q>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })

-- Buffer
set_keymap('n', 'tp', ':<C-u>bprev<CR>', { noremap = true, silent = true })
set_keymap('n', 'tn', ':<C-u>bnext<CR>', { noremap = true, silent = true })

-- Layout
set_keymap('n', 'tb', ':<C-u>NvimTreeToggle<CR>', {noremap = true, silent = true})
set_keymap('n', 'tt', ':<C-u>NvimTreeFocus<CR>', {noremap = true, silent = true})

-- Telescope
set_keymap('n', 'tg', ':<C-u>Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true})
set_keymap('n', 'tG', ':<C-u>Telescope live_grep<CR>',                 { noremap = true, silent = true})
set_keymap('n', 'to', ':<C-u>Telescope find_files<CR>',                { noremap = true, silent = true})
set_keymap('n', 'te', ':<C-u>Telescope buffers<CR>',                   { noremap = true, silent = true})
set_keymap('n', 'tm', ':<C-u>Telescope marks<CR>',                     { noremap = true, silent = true})
set_keymap('n', 't-', ':<C-u>TodoTelescope<CR>',                       { noremap = true, silent = true})

-- Browser
set_keymap('n', 'tw', ":<C-u>GHInteractive<CR>", {noremap = true, silent = true})
set_keymap('n', 'tW', ":<C-u>execute 'OpenBrowserSmartSearch' expand('<cWORD>')<CR>", {noremap = true, silent = true})

-- DiffView
set_keymap('n', 'td', ':<C-u>DiffviewOpen<CR>',  {noremap = true, silent = true})
set_keymap('n', 'tD', ':<C-u>DiffviewClose<CR>', {noremap = true, silent = true})

-- Ctrlsf
set_keymap('n', 'tf', '<Plug>CtrlSFPrompt',     {noremap = false, silent = false})
set_keymap('v', 'tf', '<Plug>CtrlSFVwordExec',  {noremap = false, silent = false})
set_keymap('n', 'tc', '<Plug>CtrlSFCwordExec',  {noremap = false, silent = false})
set_keymap('n', 'tC', ':<C-u>CtrlSFToggle<CR>', {noremap = true,  silent = true })
set_keymap('n', 'tF', ':<C-u>CtrlSFToggle<CR>', {noremap = true,  silent = true })

-- Compe
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
  return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end

set_keymap('i', '<Tab>', 'v:lua.smart_tab()',                                                     { noremap = true, silent = true, expr = true})
set_keymap('i', '<C-k>', [[compe#complete()]],                                                    { noremap = true, silent = true, expr = true})
set_keymap('i', '<C-e>', [[compe#close('<C-e>')]],                                                { noremap = true, silent = true, expr = true})
set_keymap('i', '<C-f>', [[compe#scroll({ 'delta': +4 })]],                                       { noremap = true, silent = true, expr = true})
set_keymap('i', '<C-d>', [[compe#scroll({ 'delta': -4 })]],                                       { noremap = true, silent = true, expr = true})
set_keymap('i', '<CR>',  [[compe#confirm('luaeval("require 'nvim-autopairs'.autopairs_cr()")')]], { noremap = true, silent = true, expr = true})

-- LSP
set_keymap('n', 'tk',    ':lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true, silent = true})
set_keymap('n', 'tj',    ':lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true, silent = true})
set_keymap('n', 'ta',    ':lua vim.lsp.buf.code_action()<CR>',      {noremap = true, silent = true})
set_keymap('n', 'tl',    ':lua vim.lsp.buf.formatting()<CR>',       {noremap = true, silent = true})
set_keymap('n', 'th',    ':lua vim.lsp.buf.hover()<CR>',            {noremap = true, silent = true})
set_keymap('n', 'ts',    ':lua vim.lsp.buf.document_symbol()<CR>',  {noremap = true, silent = true})
set_keymap('n', 'tr',    ':lua vim.lsp.buf.rename()<CR>',           {noremap = true, silent = true})
set_keymap('n', 'ti',    ':lua vim.lsp.buf.implementation()<CR>',   {noremap = true, silent = true})
set_keymap('n', 't]',    ':lua vim.lsp.buf.definition()<CR>',       {noremap = true, silent = true})
set_keymap('n', 't}',    ':lua vim.lsp.buf.references()<CR>',       {noremap = true, silent = true})

