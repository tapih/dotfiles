local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspkind').init()

vim.cmd('sign define LspDiagnosticsSignError text=')
vim.cmd('sign define LspDiagnosticsSignWarning text=')
vim.cmd('sign define LspDiagnosticsSignInformation text=')
vim.cmd('sign define LspDiagnosticsSignHint text=')
vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

require'lspconfig'.gopls.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.jsonls.setup{
	commands = {
		Format = {
			function()
				vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
			end
		}
	}
}

vim.opt.runtimepath = vim.opt.runtimepath + '~/.local/share/nvim/site/pack/packer/opt/flutter-tools.nvim'
require("flutter-tools").setup{}
