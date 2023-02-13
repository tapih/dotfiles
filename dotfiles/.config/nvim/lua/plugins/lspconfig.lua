local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspkind').init()

vim.cmd('sign define LspDiagnosticsSignError text=')
vim.cmd('sign define LspDiagnosticsSignWarning text=')
vim.cmd('sign define LspDiagnosticsSignInformation text=')
vim.cmd('sign define LspDiagnosticsSignHint text=')
vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

require 'lspconfig'.lua_ls.setup { capabilities = capabilities }
require 'lspconfig'.gopls.setup { capabilities = capabilities }
require 'lspconfig'.rust_analyzer.setup { capabilities = capabilities }
require 'lspconfig'.pyright.setup { capabilities = capabilities }
require 'lspconfig'.tsserver.setup { capabilities = capabilities }
require 'lspconfig'.terraformls.setup { capabilities = capabilities }
require 'lspconfig'.tflint.setup { capabilities = capabilities }
require 'lspconfig'.dockerls.setup { capabilities = capabilities }
require 'lspconfig'.vimls.setup { capabilities = capabilities }
require 'lspconfig'.yamlls.setup {
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = { kubernetes = "globPattern" },
        }
    }
}
require 'lspconfig'.bashls.setup { capabilities = capabilities }
require 'lspconfig'.jsonls.setup {
    capabilities = capabilities,
    commands = {
        Format = {
            function()
              vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
            end
        }
    },
}

-- https://github.com/golang/tools/blob/556c550a381650eb5b7b2ca5126b4bed281d47f9/gopls/doc/vim.md#neovim-imports
function GoImport(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.cmd 'au BufWritePre *.go lua GoImport(300)'
