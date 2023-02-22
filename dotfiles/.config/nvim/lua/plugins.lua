require 'lazy'.setup {
  -- Development
  {
    "folke/neodev.nvim",
    lazy = true,
    ft = { 'lua' },
  },
  {
    'dstein64/vim-startuptime',
    lazy = true,
    cmd = { "StartupTime" }
  },

  -- Basic
  {
    'EtiamNullam/deferred-clipboard.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      require('deferred-clipboard').setup {
        fallback = 'unnamedplus', -- or your preferred setting for clipboard
      }
    end,
  },
  { 'nvim-lua/popup.nvim' },
  { 'nvim-lua/plenary.nvim' },
  { 'MunifTanjim/nui.nvim' },
  {
    'kevinhwang91/nvim-bqf',
    lazy = true,
    ft = 'qf',
  },

  -- Project
  { 'airblade/vim-rooter' },
  -- {
  --    'goolord/alpha-nvim',
  --    dependencies = { 'nvim-tree/nvim-web-devicons' },
  --    config = [[require'alpha'.setup(require'alpha.themes.startify'.config)]],
  -- },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.api.nvim_command("TSUpdate")
      end
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
        ensure_installed = {
          'bash',
          'dart',
          'gitignore',
          'go',
          'gosum',
          'gomod',
          'hcl',
          'lua',
          'javascript',
          'json',
          'jsonnet',
          'make',
          'markdown',
          'proto',
          'python',
          'rego',
          'sql',
          'terraform',
          'typescript',
          'yaml',
        },
      }
    end
  },
  {
    'm-demare/hlargs.nvim',
    lazy = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = [[require('hlargs').setup()]],
  },
  {
    "yioneko/nvim-yati",
    lazy = true,
    dependencies = "nvim-treesitter/nvim-treesitter",
    confifg = function()
      require("nvim-treesitter.configs").setup {
        yati = { enable = true }
      }
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require 'plugins.lspconfig',
    dependencies = {
      { 'ray-x/lsp_signature.nvim' },
      {
        "williamboman/mason-lspconfig.nvim",
        ensure_installed = {
          'bashls',
          'dagger',
          'dockerls',
          'docker_compose_language_service',
          'golangci_lint_ls',
          'gopls',
          'graphql',
          'jsonls',
          'jsonnet_ls',
          'tsserver',
          'lua_ls',
          'pyright',
          'pyright',
          'zk',
          'sqlls',
          'terraformls',
          'tflint',
          'yamlls',
        },
      },
      {
        "williamboman/mason.nvim",
        config = [[require'mason'.setup()]],
      },
      {
        'j-hui/fidget.nvim',
        config = [[require'fidget'.setup()]],
      },
      {
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
      },
    },
  },
  {
    'filipdutescu/renamer.nvim',
    lazy = true,
    keys = {
      {'<leader>m' },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = [[require('renamer').setup{}]],
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    lazy = true,
    ft = { "yaml", "json" },
    dependencies = {
      { "b0o/schemastore.nvim" },
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  },

  --Completion
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = "InsertEnter",
    config = require('plugins.nvim-cmp'),
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
      { 'golang/vscode-go' },
      { 'Dart-Code/Dart-Code' },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = "Copilot",
    event = "InsertEnter",
    config = [[require("copilot").setup()]],
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = [[require("copilot_cmp").setup()]],
      },
    },
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'cljoly/telescope-repo.nvim',
        config = function()
          require('telescope').load_extension('repo')
        end,
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
          require("telescope").load_extension "file_browser"
        end
      },
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
    end,
  },

  -- Apperance
  { 'nvim-tree/nvim-web-devicons' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = [[require('lualine').setup { options = { theme  = 'tokyonight' } }]],
  },
  {
    'RRethy/vim-illuminate',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'ntpeters/vim-better-whitespace',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  { 'myusuf3/numbers.vim' },
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  {
    'mvllow/modes.nvim',
    tag = 'v0.2.1',
    lazy = true,
    event = "InsertEnter",
    config = [[require('modes').setup()]],
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },

  -- Widget
  { 'romgrk/barbar.nvim' },
  { 'dstein64/nvim-scrollview' },
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    cmd = {
      'NeoTreeFocus',
      'NeoTreeFocusToggle',
      'NeoTreeFloat',
      'NeoTreeFloatToggle',
      'NeoTreeShow',
      'NeoTreeShowToggle',
      'NeoTreeShowInSplit',
      'NeoTreeShowInSplitToggle',
      'NeoTreeReveal',
      'NeoTreeRevealToggle',
      'NeoTreeRevealInSplit',
      'NeoTreeRevealInSplitToggle',
    },
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  },
  {
    'famiu/bufdelete.nvim',
    lazy = true,
    cmd = { 'Bdelete' },
  },
  {
    'voldikss/vim-floaterm',
    lazy = true,
    cmd = {
      'FloatermToggle',
      'FloatermNew',
    },
    config = function()
      vim.g.floaterm_height = 0.9
      vim.g.floaterm_width = 0.9
    end
  },
  {
    'mrjones2014/legendary.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    tag = 'v2.7.1',
    config = require('plugins.legendary'),
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  },

  -- Editing
  {
    'junegunn/vim-easy-align',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'tpope/vim-surround',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'andymass/vim-matchup',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'bkad/CamelCaseMotion',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'AndrewRadev/sideways.vim',
    lazy = true,
    cmd = { 'SidewaysLeft', 'SidewaysRight' },
  },
  {
    'lfilho/cosco.vim',
    lazy = true,
    cmd = { 'CommaOrSemiColon' },
  },
  {
    'numToStr/Comment.nvim',
    lazy = true,
    event = "InsertEnter",
    config = [[require('Comment').setup()]] },
  {
    "danymat/neogen",
    lazy = true,
    event = "InsertEnter",
    config = [[require('neogen').setup {}]],
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    }
  },
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt", "vim" },
      })
    end,
  },

  -- Search
  {
    'markonm/traces.vim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'haya14busa/vim-asterisk',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'rhysd/clever-f.vim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'unblevable/quick-scope',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'windwp/nvim-spectre',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'kevinhwang91/nvim-hlslens',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = [[require'hlslens'.setup()]],
  },
  {
    'phaazon/hop.nvim',
    lazy = true,
    cmd = {
      'HopWord',
      'HopChar1',
      'HopChar2',
      'HopPattern',
      'HopLine',
      'HopLineStart',
      'HopAnywhere',
    },
    tag = 'v2.0.3',
    config = function()
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = require('plugins.gitsigns'),
  },
  {
    'ruanyl/vim-gh-line',
    lazy = true,
    cmd = { 'GH', 'GHInteractive' },
  },
  {
    'mattn/vim-gist',
    lazy = true,
    cmd = { 'Gist' },
  },
  {
    'f-person/git-blame.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'akinsho/git-conflict.nvim',
    lazy = true,
    config = [[require('git-conflict').setup()]],
  },
  {
    'pwntester/octo.nvim',
    lazy = true,
    cmd = { 'Octo' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = [[require "octo".setup()]],
  },

  -- General tools
  {
    'mattn/vim-sonictemplate',
    lazy = true,
    cmd = { 'Template' },
  },
  {
    'segeljakt/vim-silicon',
    lazy = true,
    cmd = { 'Silicon' },
  },
  {
    'voldikss/vim-translator',
    lazy = true,
    cmd = { 'Translate', 'TranslateW' },
  },

  -- Language specific tools
  -- Go
  {
    'ray-x/go.nvim',
    lazy = true,
    ft = "go",
  },
  {
    'ray-x/guihua.lua',
    lazy = true,
    ft = "go",
  },

  -- Markdown
  {
    'ekickx/clipboard-image.nvim',
    lazy = true,
    ft = "markdown",
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Others
  {
    'jsborjesson/vim-uppercase-sql',
    lazy = true,
    ft = { 'sql' },
  },
  {
    'google/vim-jsonnet',
    lazy = true,
    ft = { 'jsonnet' },
  },
  {
    'hashivim/vim-terraform',
    lazy = true,
    ft = { 'terraform', 'hcl' },
  },
  {
    'juliosueiras/vim-terraform-completion',
    ft = { 'terraform', 'hcl' },
  },

  -- Color
  {
    'folke/tokyonight.nvim',
    tag = 'v1.3.0',
    config = function()
      vim.cmd [[colorscheme tokyonight-night]]
    end
  },
}
