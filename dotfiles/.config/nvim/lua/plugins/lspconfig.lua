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

lspconfig = require('lspconfig')
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

lspconfig.lua_ls.setup {
    capabilities = capabilities,
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

local yaml_config = require("yaml-companion").setup({
        schemas = {
            {
                name = "Kubernetes 1.25.6",
                uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.25.6-standalone-strict/all.json",
            },
        },
        lspconfig = {
            settings = {
                yaml = {
                    schemas = yaml_schemas,
                }
            }
        }
    })
lspconfig.yamlls.setup(yaml_config)

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
