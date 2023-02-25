require 'lazy'.setup {
  -- Development
  {
    "folke/neodev.nvim",
    lazy = true,
    tag = "v2.4.0",
    ft = { 'lua' },
  },
  {
    'dstein64/vim-startuptime',
    lazy = true,
    tag = "v4.3.0",
    cmd = { "StartupTime" }
  },

  -- Basic
  {
    'EtiamNullam/deferred-clipboard.nvim',
    lazy = true,
    tag = "v0.7.0",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      require('deferred-clipboard').setup {
        fallback = 'unnamedplus', -- or your preferred setting for clipboard
      }
    end,
  },
  { 'nvim-lua/plenary.nvim', tag = "v0.1.3" },
  { 'nvim-lua/popup.nvim',   commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" },
  { 'MunifTanjim/nui.nvim',  commit = "d147222a1300901656f3ebd5b95f91732785a329" },
  {
    'kevinhwang91/nvim-bqf',
    lazy = true,
    tag = "v1.1.0",
    ft = 'qf',
  },

  -- Project
  { 'airblade/vim-rooter',         commit = "4f52ca556a0b9e257bf920658714470ea0320b7a" },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    tag = "v0.8.5.2",
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
    commit = "88b925d699fb39633cdda02c24f0b3ba5d0e6964",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = [[require('hlargs').setup()]],
  },
  {
    "yioneko/nvim-yati",
    lazy = true,
    commit = "8240f369d47c389ac898f87613e0901f126b40f3",
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
    -- Use commit instead of tag to use lua_ls.
    commit = "62856b20751b748841b0f3ec5a10b1e2f6a6dbc9",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require 'plugins.lspconfig',
    dependencies = {
      { 'ray-x/lsp_signature.nvim', commit = "6f6252f63b0baf0f2224c4caea33819a27f3f550" },
      {
        "williamboman/mason-lspconfig.nvim",
        commit = "93e58e100f37ef4fb0f897deeed20599dae9d128",
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
          'zk',
          'sqlls',
          'terraformls',
          'tflint',
          'yamlls',
        },
      },
      {
        "williamboman/mason.nvim",
        commit = "01dfdfd36be77cb1195b60d580315bf4e2d8e62c",
        config = [[require'mason'.setup()]],
      },
      {
        'j-hui/fidget.nvim',
        commit = "688b4fec4517650e29c3e63cfbb6e498b3112ba1",
        config = [[require'fidget'.setup()]],
      },
      {
        'onsails/lspkind-nvim',
        commit = "c68b3a003483cf382428a43035079f78474cd11e",
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
    tag = 'v5.1.0',
    keys = {
      { '<leader>m' },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = [[require('renamer').setup{}]],
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    lazy = true,
    tag = '0.1.3',
    ft = { "yaml", "json" },
    dependencies = {
      { "b0o/schemastore.nvim",         commit = "6f2ffb8420422db9a6c43dbce7227f0fdb9fcf75" },
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
    commit = "7a3b1e76f74934b12fda82158237c6ad8bfd3d40",
    event = "InsertEnter",
    config = require('plugins.nvim-cmp'),
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp',                commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef" },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', commit = "3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1" },
      { 'hrsh7th/cmp-buffer',                  commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
      { 'hrsh7th/cmp-path',                    commit = "91ff86cd9c29299a64f968ebb45846c485725f23" },
      { 'hrsh7th/cmp-cmdline',                 commit = "8fcc934a52af96120fe26358985c10c035984b53" },
      { 'hrsh7th/cmp-emoji',                   commit = "19075c36d5820253d32e2478b6aaf3734aeaafa0" },
      { 'hrsh7th/cmp-vsnip',                   commit = "989a8a73c44e926199bfd05fa7a516d51f2d2752" },
      { 'hrsh7th/vim-vsnip',                   commit = "8dde8c0ef10bb1afdbb301e2bd7eb1c153dd558e" },
      { 'golang/vscode-go',                    commit = "v0.37.1" },
      { 'Dart-Code/Dart-Code',                 commit = "v3.58.0" },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    commit = "ca68fc39f656d4025c5e0acc2faf07a28be3a389",
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
    lazy = true,
    cmd = { "Telescope" },
    tag = "0.1.1",
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'cljoly/telescope-repo.nvim',
        commit = "50b5fc6eba11b5f1fcb249d5f7490551f86d1a00",
        config = function()
          require('telescope').load_extension('repo')
        end,
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        commit = "580b6c48651cabb63455e97d7e131ed557b8c7e2",
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        commit = "6eb6bb45b7a9bed94a464a3e1dadfe870459628c",
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
  { 'nvim-tree/nvim-web-devicons', commit = "4709a504d2cd2680fb511675e64ef2790d491d36" },
  {
    'nvim-lualine/lualine.nvim',
    commit = "e99d733e0213ceb8f548ae6551b04ae32e590c80",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = [[require('lualine').setup { options = { theme  = 'tokyonight' } }]],
  },
  {
    'RRethy/vim-illuminate',
    lazy = true,
    commit = "49062ab1dd8fec91833a69f0a1344223dd59d643",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'ntpeters/vim-better-whitespace',
    lazy = true,
    commit = "1b22dc57a2751c7afbc6025a7da39b7c22db635d",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'myusuf3/numbers.vim',
    lazy = true,
    commit = "1867e76e819db182a4fb71f48f4bd36a5e2c6b6e",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
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
    tag = "v2.20.4",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },

  -- Widget
  { 'romgrk/barbar.nvim',       tag = "release/1.4.1" },
  { 'dstein64/nvim-scrollview', tag = "v3.0.3" },
  {
    "SmiteshP/nvim-navic",
    commit = "7e9d2b2b601149fecdccd11b516acb721e571fe6",
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "utilyre/barbecue.nvim",
    tag = "v0.4.1",
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
    commit = "8933abc09df6c381d47dc271b1ee5d266541448e",
    cmd = { 'Bdelete' },
  },
  {
    'voldikss/vim-floaterm',
    lazy = true,
    commit = "ca44a13a379d9af75092bc2fe2efee8c5248e876",
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
    tag = 'v2.7.1',
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require('plugins.legendary'),
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    tag = 'v1.1.1',
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
    commit = "12dd6316974f71ce333e360c0260b4e1f81169c3",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'tpope/vim-surround',
    lazy = true,
    commit = "3d188ed2113431cf8dac77be61b842acb64433d9",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  -- Lazy load by event is not recommended.
  { 'andymass/vim-matchup', commit = "3a48818a8113a502f245c29d894201421727577a" },
  {
    'bkad/CamelCaseMotion',
    lazy = true,
    commit = "de439d7c06cffd0839a29045a103fe4b44b15cdc",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'AndrewRadev/sideways.vim',
    lazy = true,
    commit = "e683ed0fc57eda718c6b28dce0ff5190089d13d3",
    cmd = { 'SidewaysLeft', 'SidewaysRight' },
  },
  {
    'lfilho/cosco.vim',
    lazy = true,
    tag = "v0.10.0",
    cmd = { 'CommaOrSemiColon' },
  },
  {
    'numToStr/Comment.nvim',
    lazy = true,
    tag = "v0.7.0",
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    config = [[require('Comment').setup()]] },
  {
    "danymat/neogen",
    lazy = true,
    tag = "2.13.1",
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    config = [[require('neogen').setup {}]],
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    }
  },
  {
    'windwp/nvim-autopairs',
    lazy = true,
    commit = "6a5faeabdbcc86cfbf1561ae430a451a72126e81",
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
    commit = "9663fcf84de5776bee71b6c816c25ccb6ea11d1a",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'haya14busa/vim-asterisk',
    lazy = true,
    commit = "77e97061d6691637a034258cc415d98670698459",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'rhysd/clever-f.vim',
    lazy = true,
    commit = "6a3ac5e3688598af9411ab741737f98c47370c22",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'unblevable/quick-scope',
    lazy = true,
    tag = "v2.5.16",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'windwp/nvim-spectre',
    lazy = true,
    commit = "b71b64afe9fedbfdd25a8abec897ff4af3bd553a",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'kevinhwang91/nvim-hlslens',
    lazy = true,
    tag = "v1.0.0",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = [[require'hlslens'.setup()]],
  },
  {
    'phaazon/hop.nvim',
    lazy = true,
    tag = "v2.0.3",
    cmd = {
      'HopWord',
      'HopChar1',
      'HopChar2',
      'HopPattern',
      'HopLine',
      'HopLineStart',
      'HopAnywhere',
    },
    config = function()
      require 'hop'.setup { keys = 'jkhlfdgsieurowyta;qpmv,c' }
    end
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    tag = "v0.6",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = require('plugins.gitsigns'),
  },
  {
    'ruanyl/vim-gh-line',
    lazy = true,
    commit = "fbf368bdfad7e5478009a6dc62559e6b2c72d603",
    cmd = { 'GH', 'GHInteractive' },
  },
  {
    'mattn/vim-gist',
    lazy = true,
    commit = "5bfbb5450d9eff248f6c074de0b7800392439304",
    cmd = { 'Gist' },
  },
  {
    'f-person/git-blame.nvim',
    lazy = true,
    commit = "17840d01f42ee308e1dbbcc2cde991297aee36c9",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'akinsho/git-conflict.nvim',
    lazy = true,
    commit = "2957f747e1a34f1854e4e0efbfbfa59a1db04af5",
    config = [[require('git-conflict').setup()]],
  },
  {
    'pwntester/octo.nvim',
    lazy = true,
    commit = "f336322f865cfa310ae15435c6bec337687b6b20",
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
    commit = "0e4d422c85decd8d159c663f234eb484b1b04b25",
    cmd = { 'Template' },
  },
  {
    'segeljakt/vim-silicon',
    lazy = true,
    commit = "4a93122ae2139a12e2a56f064d086c05160b6835",
    cmd = { 'Silicon' },
  },
  {
    'voldikss/vim-translator',
    lazy = true,
    commit = "681c6b2f650b699572e6bb55162a3d6e62ee5d43",
    cmd = { 'Translate', 'TranslateW' },
  },

  -- Language specific tools
  -- Go
  {
    'ray-x/go.nvim',
    lazy = true,
    commit = "4d066613379d85094bb4ddd52e34e6d3f55fc24e",
    ft = "go",
  },
  {
    'ray-x/guihua.lua',
    lazy = true,
    commit = "a19ac4447021f21383fadd7a9e1fc150d0b67e1f",
    ft = "go",
  },

  -- Markdown
  {
    'ekickx/clipboard-image.nvim',
    lazy = true,
    commit = "d1550dc26729b7954f95269952e90471b838fa25",
    ft = "markdown",
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    tag = "v0.0.10",
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Others
  {
    'jsborjesson/vim-uppercase-sql',
    lazy = true,
    commit = "58bfde1d679a1387dabfe292b38d51d84819b267",
    ft = { 'sql' },
  },
  {
    'google/vim-jsonnet',
    lazy = true,
    commit = "4ebc6619ddce5d032a985b42a9864154c3d20e4a",
    ft = { 'jsonnet' },
  },
  {
    'hashivim/vim-terraform',
    lazy = true,
    commit = "d00503de9bed3a1da7206090cb148c6a1acce870",
    ft = { 'terraform', 'hcl' },
  },
  {
    'juliosueiras/vim-terraform-completion',
    lazy = true,
    commit = "125d0e892f5fd8f32b57a5a5983d03f1aa611949",
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
