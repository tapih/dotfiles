local packer = nil
local function init()
  if packer == nil then
    packer = require('packer')
    packer.init { disable_commands = true }
  end

  local use = packer.use
  packer.reset()

  -- Packer can manage packer on its own :)
  use '~/.config/nvim/packer.nvim'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'morhetz/gruvbox'
  use 'kyazdani42/nvim-web-devicons'
  use 'airblade/vim-rooter'
  use 'mhinz/vim-startify'
  use 'bronson/vim-trailing-whitespace'
  use 'junegunn/vim-easy-align'
  use 'roxma/vim-tmux-clipboard'
  use 'ruanyl/vim-gh-line'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'google/vim-jsonnet'
  use { 'famiu/feline.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
  use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
  use { 'tpope/vim-commentary', opt = true, cmd = {'Commentary'} }
  use { 'lukas-reineke/indent-blankline.nvim', config = [[require('plugins.indent-blackline')]] }
  use { 'easymotion/vim-easymotion', config = [[require('plugins.vim-easymotion')]] }
  use { 'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]] }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use { 'onsails/lspkind-nvim', config = [[require('plugins.lspkind')]] }
  use { 'ray-x/lsp_signature.nvim', config = [[require'lsp_signature'.setup {}]] }

  -- Git
  use {
    'sindrets/diffview.nvim',
    opt = true,
    cmd = {'DiffviewOpen'},
    condig = [[require('plugins.diffview')]],
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = [[require('plugins.gitsigns')]],
  }

  -- Autocomplete
  use 'andymass/vim-matchup'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use { 'windwp/nvim-autopairs', config = [[require('plugins.nvim-autopairs')]] }
  use { 'hrsh7th/nvim-cmp', config = [[require('plugins.nvim-cmp')]] }

  -- Telescope
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzy-native.nvim',
      },
      config = [[require('plugins.telescope')]],
      opt = true,
      cmd = {'Telescope'},
    },
    {
      'nvim-telescope/telescope-fzy-native.nvim',
      run = 'git submodule update --init --recursive',
    },
  }

  end

  return setmetatable({}, {
    __index = function(_, key)
      init()
      return packer[key]
    end,
  })
