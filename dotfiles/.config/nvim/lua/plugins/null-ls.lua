require("null-ls").config({
    sources = { require("null-ls").builtins.formatting.stylua }
})
require("lspconfig")["null-ls"].setup({
    on_attach = my_custom_on_attach
})
