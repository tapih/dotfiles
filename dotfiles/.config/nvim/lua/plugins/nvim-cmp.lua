return function()
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-b>']  = cmp.mapping.scroll_docs( -4),
        ['<C-f>']  = cmp.mapping.scroll_docs(4),
        ['<C-k>']  = cmp.mapping.complete(),
        ['<C-n>']  = cmp.mapping.select_next_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<C-p>']  = cmp.mapping.select_prev_item(),
        ['<Up>']   = cmp.mapping.select_prev_item(),
        ['<C-e>']  = cmp.mapping.abort(),
        ['<CR>']   = cmp.mapping.confirm({ select = true }),
        ['<Tab>']  = cmp.mapping.confirm({ select = true }),
        ['<C-g>'] = cmp.mapping(function(fallback)
          vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n',
              true)
        end)
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' },
    }),
    formatting = {
        format = function(entry, vim_item)
          -- fancy icons and a name of kind
          vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

          -- set a name for each source
          vim_item.menu = ({
                  buffer = "[Buffer]",
                  nvim_lsp = "[LSP]",
                  luasnip = "[LuaSnip]",
                  nvim_lua = "[Lua]",
              })[entry.source.name]
          return vim_item
        end,
    },
    experimental = {
        ghost_text = false -- this feature conflict to the copilot.vim's preview.
    }
})
end
