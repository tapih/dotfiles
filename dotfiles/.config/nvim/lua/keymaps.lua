local set_keymap = vim.api.nvim_set_keymap

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
set_keymap('n', 'Y', 'g%', { noremap = true, silent = true })
set_keymap('v', 'Y', 'g%', { noremap = true, silent = true })

set_keymap('n', ',u', ':<C-u>PackerUpdate<CR>', { noremap = true, silent = false })
set_keymap('n', ',c', ':<C-u>PackerCompile<CR>', { noremap = true, silent = false })
set_keymap('n', ',s', ':<C-u>source %<CR>', { noremap = true, silent = false })

-- set C-b as PageUp explicitly because a certain plugin overwrites it.
set_keymap('n', 'R', '<Plug>(operator-replace)', { noremap = false, silent = true })
set_keymap('v', 'R', '<Plug>(operator-replace)', { noremap = false, silent = true })
set_keymap('', 'w', '<Plug>CamelCaseMotion_w', { noremap = false, silent = true })
set_keymap('', 'b', '<Plug>CamelCaseMotion_b', { noremap = false, silent = true })
set_keymap('', 'e', '<Plug>CamelCaseMotion_e', { noremap = false, silent = true })
set_keymap('', 'ge', '<Plug>CamelCaseMotion_ge', { noremap = false, silent = true })
set_keymap('n', '*', "<Plug>(asterisk-*)<Cmd>lua require('hlslens').start()<CR>", { noremap = false, silent = true })
set_keymap('v', '*', "<Plug>(asterisk-*)<Cmd>lua require('hlslens').start()<CR>", { noremap = false, silent = true })
set_keymap('n', '#', "<Plug>(asterisk-#)<Cmd>lua require('hlslens').start()<CR>", { noremap = false, silent = true })
set_keymap('v', '#', "<Plug>(asterisk-#)<Cmd>lua require('hlslens').start()<CR>", { noremap = false, silent = true })
set_keymap('n', 'g*', "<Plug>(asterisk-g*)<Cmd>lua require('hlslens').start()<CR>", { noremap = false, silent = true })
set_keymap('v', 'g*', "<Plug>(asterisk-g*)<Cmd>lua require('hlslens').start()<CR>", { noremap = false, silent = true })
set_keymap('n', 'g#', "<Plug>(asterisk-g#)<Cmd>lua require('hlslens').start()<CR>", { noremap = false, silent = true })
set_keymap('v', 'g#', "<Plug>(asterisk-g#)<Cmd>lua require('hlslens').start()<CR>", { noremap = false, silent = true })

set_keymap('', '<leader><space>', ':<C-u>HopChar1<CR>', { noremap = true, silent = true })
set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
set_keymap("n", "<C-x>", "<cmd>FloatermToggle<CR>", { noremap = true, silent = true })
set_keymap("t", "<C-x>", "<cmd>FloatermToggle<CR>", { noremap = true, silent = true })
set_keymap('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>a', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
set_keymap("n", "<leader>b", ":<C-u>Telescope file_browser<CR>", { noremap = true, silent = true })
set_keymap("n", "<leader>B", ":<C-u>Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true, silent = true })
set_keymap('n', '<leader>c', ':<C-u>noh<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>d', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>f', ':<C-u>Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>F', ':<C-u>Telescope live_grep<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>h', '<cmd>lua require("spectre").open_file_search()<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>H', '<cmd>lua require("spectre").open()<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>i', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>j', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>k', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>l', ':lua vim.lsp.buf.format { async = true }<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>m', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
set_keymap('v', '<leader>m', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })
set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", { noremap = true, silent = true })
-- set_keymap('n', '<leader>r', ':<C-u>Telescope lsp_references<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>r', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
set_keymap("n", "<Leader>sh", ":<C-u>SidewaysLeft<CR>", { noremap = true, silent = true })
set_keymap("n", "<Leader>sl", ":<C-u>SidewaysRight<CR>", { noremap = true, silent = true })
set_keymap('n', '<leader>s', '<Cmd>lua require"telescope.builtin".lsp_document_symbols{}<CR>',
    { noremap = true, silent = true })
set_keymap('n', '<leader>S', '<Cmd>lua require"telescope.builtin".lsp_workspace_symbols{}<CR>',
    { noremap = true, silent = true })
set_keymap('n', '<leader>t', ':lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
set_keymap('n', '<leader>v', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    { noremap = true, silent = true })
set_keymap('v', '<leader>V', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    { noremap = true, silent = true })
set_keymap('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { noremap = false, silent = true })
set_keymap('v', '<leader>/', '<Plug>(comment_toggle_blockwise_visual)', { noremap = false, silent = true })
set_keymap('n', '<leader>;', ':<C-u>CommaOrSemiColon<CR>', { noremap = true, silent = true });

set_keymap('n', '<A-a>', '<Plug>(EasyAlign)', { noremap = false, silent = false })
set_keymap('x', '<A-a>', '<Plug>(EasyAlign)', { noremap = false, silent = false })
set_keymap('n', '<A-b>', ':<C-u>Telescope git_branches<CR>', { noremap = true, silent = true })
set_keymap('n', '<A-c>', ':<C-u>Telescope commands<CR>', { noremap = true, silent = true })
set_keymap('n', '<A-e>', ':<C-u>Telescope buffers<CR>', { noremap = true, silent = true })
set_keymap("n", "<A-g>", "<cmd>FloatermNew lazygit<CR>", { noremap = true, silent = true })
set_keymap('n', '<A-G>', ":<C-u>GHInteractive<CR>", { noremap = true, silent = true })
set_keymap('n', '<A-h>', ':<C-u>Telescope command_history<CR>', { noremap = true, silent = true })
set_keymap('n', '<A-i>', ':<C-u>Telescope diagnostics<CR>', { noremap = true, silent = true })
set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
set_keymap('n', '<A-l>', ':<C-u>Octo actions<CR>', { noremap = true, silent = true })
set_keymap('n', '<A-m>', ':<C-u>Telescope marks<CR>', { noremap = true, silent = true })
set_keymap('n', '<A-n>', ':<C-u>bnext<CR>', { noremap = true, silent = true })
set_keymap('n', '<A-o>', ':<C-u>Telescope find_files find_command=fd,-HLE.git,-tf<CR>', { noremap = true, silent = true })
set_keymap('n', '<A-p>', ':<C-u>bprev<CR>', { noremap = true, silent = true })
set_keymap('n', '<A-w>', ":<C-u>Bdelete<CR>", { noremap = true, silent = true })
set_keymap('n', '<A-y>', ':<C-u>Telescope registers<CR>', { noremap = true, silent = true })

if vim.g.vscode then
  set_keymap('n', 'q', ':<C-u>call VSCodeCall("workbench.action.closeActiveEditor")<CR>',
      { noremap = true, silent = true })
end
