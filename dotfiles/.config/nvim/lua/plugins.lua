vim.cmd [[packadd packer.nvim]]

require 'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'marko-cerovac/material.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'MunifTanjim/nui.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'ntpeters/vim-better-whitespace'
  use 'junegunn/vim-easy-align'
  use 'ruanyl/vim-gh-line'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'google/vim-jsonnet'
  use 'andymass/vim-matchup'
  use 'myusuf3/numbers.vim'
  use 'airblade/vim-rooter'
  use 'dstein64/nvim-scrollview'
  use 'haya14busa/vim-asterisk'
  use 'jsborjesson/vim-uppercase-sql'
  use 'kana/vim-operator-replace'
  use 'kana/vim-operator-user'
  use 'markonm/traces.vim'
  use 'bkad/CamelCaseMotion'
  use 'ggandor/lightspeed.nvim'
  use 'unblevable/quick-scope'
  use 'windwp/nvim-spectre'
  use 'RRethy/vim-illuminate'
  use {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
        require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
  }
  use {
      'filipdutescu/renamer.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('renamer').setup{}]],
  }
  use {
      'gelguy/wilder.nvim',
      config = function()
        local wilder = require('wilder')
        wilder.setup {
            modes = { ':', '/', '?' },
        }
        wilder.set_option('renderer', wilder.popupmenu_renderer({
            highlighter = wilder.basic_highlighter(),
        }))
      end
  }

  use { 'hashivim/vim-terraform', ft = 'terraform' }
  use { 'juliosueiras/vim-terraform-completion', ft = 'terraform' }

  use { 'kevinhwang91/nvim-hlslens', config = [[require'hlslens'.setup()]] }
  use { 'dstein64/vim-startuptime', config = [[vim.g.startuptime_tries = 10]], cmd = { "StartupTime" } }

  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
  use { 'ray-x/go.nvim', ft = 'go' }

  use { 'mattn/vim-sonictemplate', opt = true, cmd = { 'Template' } }
  use { 'lfilho/cosco.vim', opt = true, cmd = { 'CommaOrSemiColon' } }
  use { 'famiu/bufdelete.nvim', opt = true, cmd = { 'Bdelete' } }
  use { 'segeljakt/vim-silicon', opt = true, cmd = { 'Silicon' } }
  use { 'voldikss/vim-translator', opt = true, cmd = { 'Translate', 'TranslateW' } }

  use { 'numToStr/Comment.nvim', config = [[require('Comment').setup()]] }
  use { "akinsho/toggleterm.nvim", config = [[require'plugins/toggleterm']] }

  use {
      'stevearc/aerial.nvim',
      opt = true,
      cmd = { 'AerialToggle' },
      config = [[require'aerial'.setup()]],
  }

  use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup({
            disable_filetype = { "TelescopePrompt", "vim" },
        })
      end,
  }
  use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require'alpha'.setup(require'alpha.themes.startify'.config)]],
  }
  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('lualine').setup { options = { theme  = 'material' } }]],
  }
  use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require("indent_blankline").setup {
            show_current_context = true,
            show_current_context_start = true,
        }
      end,
  }

  -- Widget
  use 'romgrk/barbar.nvim'
  use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
  }
  use({
      "utilyre/barbecue.nvim",
      requires = {
          "SmiteshP/nvim-navic",
          "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      after = "nvim-web-devicons", -- keep this if you're using NvChad
      config = function()
        require("barbecue").setup()
      end,
  })
  use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
          "nvim-lua/plenary.nvim",
          "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
      }
  }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'm-demare/hlargs.nvim', requires = { 'nvim-treesitter/nvim-treesitter' }, config = [[require('hlargs').setup()]] }
  use {
      "yioneko/nvim-yati",
      requires = "nvim-treesitter/nvim-treesitter",
      confifg = function()
        require("nvim-treesitter.configs").setup {
            yati = { enable = true }
        }
      end,
  }

  -- Git
  use 'f-person/git-blame.nvim'
  use { 'sindrets/diffview.nvim', opt = true, cmd = { 'DiffviewOpen' } }
  use { 'mattn/vim-gist', opt = true, cmd = { 'Gist' } }
  use { 'akinsho/git-conflict.nvim', config = [[require('git-conflict').setup()]] }
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = [[require('plugins.gitsigns')]] }
  use {
      'pwntester/octo.nvim',
      opt = true,
      cmd = { 'Octo' },
      requires = {
          'nvim-lua/plenary.nvim',
          'nvim-telescope/telescope.nvim',
          'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require "octo".setup()
      end,
  }

  -- nvim-cmp
  use { 'hrsh7th/nvim-cmp', config = [[require('plugins.nvim-cmp')]] }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use { "github/copilot.vim", cmd = "Copilot", event = "InsertEnter" }

  -- Telescope
  use {
      'nvim-telescope/telescope.nvim',
      requires = {
          'nvim-lua/popup.nvim',
          'nvim-lua/plenary.nvim',
          'nvim-telescope/telescope-fzf-native.nvim',
      },
      config = function()
        local telescope = require('telescope')
        telescope.setup {
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = {
                    horizontal = {
                        width = 0.8,
                    },
                },
            },
            extensions = {
                repo = {
                    list = {
                        fd_opts = {
                            "--no-ignore-vcs",
                        },
                        search_dirs = {
                            "~/src",
                        },
                    },
                },
            },
        }

        telescope.load_extension('fzf')
        telescope.load_extension('repo')
      end,
  }
  use 'cljoly/telescope-repo.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use { 'j-hui/fidget.nvim', config = [[require'fidget'.setup {}]] }
  use { 'ray-x/lsp_signature.nvim', config = [[require'lsp_signature'.setup {}]] }
  use { "folke/trouble.nvim", requires = { "kyazdani42/nvim-web-devicons" }, on = { 'Trouble', 'TroubleToggle' } }
  use { 'williamboman/nvim-lsp-installer', config = [[require("nvim-lsp-installer").setup { automatic_installation = true }]] }
  use {
      'onsails/lspkind-nvim',
      config = function()
        require('lspkind').init({
            symbol_map = {
                Text = '',
                Method = 'ƒ',
                Function = '',
                Constructor = '',
                Variable = '',
                Class = '',
                Interface = 'ﰮ',
                Module = '',
                Property = '',
                Unit = '',
                Value = '',
                Enum = '了',
                Keyword = '',
                Snippet = '﬌',
                Color = '',
                File = '',
                Folder = '',
                EnumMember = '',
                Constant = '',
                Struct = ''
            },
        })
      end,
  }

  -- markdown
  use { 'ekickx/clipboard-image.nvim', ft = "markdown" }
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
})
end)
