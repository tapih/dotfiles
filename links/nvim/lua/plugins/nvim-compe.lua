vim.g.loaded_compe_treesitter = true
vim.g.loaded_compe_snippets_nvim = true
vim.g.loaded_compe_spell = true
vim.g.loaded_compe_tags = true
vim.g.loaded_compe_ultisnips = true
vim.g.loaded_compe_vim_lsc = true
vim.g.loaded_compe_vim_lsp = true

require('compe').setup {
  enabled          = true,
  autocomplete     = true,
  debug            = false,
  min_length       = 1,
  preselect        = 'enable',
  throttle_time    = 80,
  source_timeout   = 200,
  incomplete_delay = 400,
  max_abbr_width   = 100,
  max_kind_width   = 100,
  max_menu_width   = 100,
  documentation    = true,

  source       = {
    path       = true,
    treesitter = true,
    nvim_lsp   = true,
    omni       = false,
    buffer     = true,
    tags       = true,
    spell      = false,
    calc       = false,
    ultisnips  = false,
  }
}

