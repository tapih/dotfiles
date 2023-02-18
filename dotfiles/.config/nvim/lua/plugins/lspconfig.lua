local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspkind').init()

vim.cmd('sign define LspDiagnosticsSignError text=')
vim.cmd('sign define LspDiagnosticsSignWarning text=')
vim.cmd('sign define LspDiagnosticsSignInformation text=')
vim.cmd('sign define LspDiagnosticsSignHint text=')
vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

local json_schemas = require('schemastore').json.schemas {}
local yaml_schemas = {}
vim.tbl_map(function(schema)
  yaml_schemas[schema.url] = schema.fileMatch
end, json_schemas)

lspconfig=require('lspconfig')
lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.gopls.setup { capabilities = capabilities }
lspconfig.rust_analyzer.setup { capabilities = capabilities }
lspconfig.pyright.setup { capabilities = capabilities }
lspconfig.tsserver.setup { capabilities = capabilities }
lspconfig.dartls.setup { capabilities = capabilities }
lspconfig.terraformls.setup { capabilities = capabilities }
lspconfig.tflint.setup { capabilities = capabilities }
lspconfig.dockerls.setup { capabilities = capabilities }
lspconfig.vimls.setup { capabilities = capabilities }
lspconfig.bashls.setup { capabilities = capabilities }
lspconfig.yamlls.setup {
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = yaml_schemas,
        }
    }
}
lspconfig.jsonls.setup {
    capabilities = capabilities,
    settings = {
        json = {
            schemas = json_schemas,
        }
    },
    commands = {
        Format = {
            function()
              vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
            end
        }
    },
}
