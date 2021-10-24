local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspkind').init()

vim.cmd('sign define LspDiagnosticsSignError text=')
vim.cmd('sign define LspDiagnosticsSignWarning text=')
vim.cmd('sign define LspDiagnosticsSignInformation text=')
vim.cmd('sign define LspDiagnosticsSignHint text=')
vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

local  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.gopls.setup{
  capabilities = capabilities,
}
require'lspconfig'.pyright.setup{
  capabilities = capabilities,
}
require'lspconfig'.dockerls.setup{
  capabilities = capabilities,
}
require'lspconfig'.terraformls.setup{
  capabilities = capabilities,
}
require'lspconfig'.vimls.setup{
  capabilities = capabilities,
}
require'lspconfig'.yamlls.setup{
  capabilities = capabilities,
}
require'lspconfig'.ccls.setup{
  capabilities = capabilities,
}

require'lspconfig'.tsserver.setup{
  capabilities = capabilities,
}

require'lspconfig'.bashls.setup{
  capabilities = capabilities,
}

require'lspconfig'.jsonls.setup{
	commands = {
		Format = {
			function()
				vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
			end
		}
	},
  capabilities = capabilities,
}

vim.opt.runtimepath = vim.opt.runtimepath + '~/.local/share/nvim/site/pack/packer/opt/flutter-tools.nvim'
require("flutter-tools").setup{
  flutter_lookup_cmd = 'asdf where flutter',
  capabilities = capabilities,
}
