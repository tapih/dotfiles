local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup {
  -- Development
  {
    "folke/neodev.nvim",
    tag = "v2.4.0",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    ft = { 'lua' },
  },

  -- Basic
  {
    'nvim-lua/plenary.nvim',
    tag = "v0.1.3",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    'nvim-lua/popup.nvim',
    commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    'MunifTanjim/nui.nvim',
    commit = "d147222a1300901656f3ebd5b95f91732785a329",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    'nvim-tree/nvim-web-devicons',
    commit = "4709a504d2cd2680fb511675e64ef2790d491d36",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    'kevinhwang91/nvim-bqf',
    tag = "v1.1.0",
    lazy = true,
    ft = 'qf',
  },

  -- Project
  {
    "ahmedkhalf/project.nvim",
    commit = "1c2e9c93c7c85126c2197f5e770054f53b1926fb",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require("project_nvim").setup {
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git" },
      }
      require('telescope').load_extension('projects')
    end
  },
  {
    'glepnir/dashboard-nvim',
    commit = '398ba8d9390c13c87a964cbca756319531fffdb7',
    lazy = true,
    event = { 'VimEnter' },
    config = [[require('dashboard').setup()]],
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    commit = "59d4c14a1a4262cf637ff2420032593afa062749",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    build = [[vim.api.nvim_command("TSUpdate")]],
    dependencies = {
      {
        "yioneko/nvim-yati",
        commit = "c4307e6855f17ff89f0132787e2daba27495d254",
      },
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        yati = { enable = true },
        highlight = {
          enable = true,
        },
        auto_install = true,
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
    commit = "e45fd1f18f2fadf7d4ebe6f14ed1e70c7fca02da",
    lazy = true,
    event = { "VeryLazy" },
    config = [[require('hlargs').setup()]],
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    commit = "62856b20751b748841b0f3ec5a10b1e2f6a6dbc9",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require 'plugins.lspconfig',
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        commit = "93e58e100f37ef4fb0f897deeed20599dae9d128",
        -- This is slow on startup.
        --[[ config = function()
          require 'mason-lspconfig'.setup {
            automatic_installation = true,
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
          }
        end ]]
      },
      {
        "williamboman/mason.nvim",
        commit = "01dfdfd36be77cb1195b60d580315bf4e2d8e62c",
        config = [[require'mason'.setup()]],
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        commit = '689cdd78f70af20a37b5309ebc287ac645ae4f76',
        dependencies = {
          { "nvim-lua/plenary.nvim" },
          {
            "jay-babu/mason-null-ls.nvim",
            tag = 'v1.1.0',
          },
        },
        config = function()
          require("null-ls").setup {
            ensure_installed = {
              'buf',
              'cue_fmt',
              'cueimports',
              'dart_format',
              'hclfmt',
              'goimports',
              'markdownlint',
              'pg_format',
              'prettier',
              'prettier_eslint',
              'protolint',
              'rego',
              'sqlfluff',
              'terraform_fmt',
            },
          }
        end,
      },
    },
  },
  {
    'j-hui/fidget.nvim',
    commit = "688b4fec4517650e29c3e63cfbb6e498b3112ba1",
    lazy = true,
    config = [[require'fidget'.setup()]],
    event = { "LspAttach" },
  },
  {
    'ray-x/lsp_signature.nvim',
    commit = "6f6252f63b0baf0f2224c4caea33819a27f3f550",
    lazy = true,
    event = { "LspAttach" },
  },
  {
    'onsails/lspkind-nvim',
    commit = "c68b3a003483cf382428a43035079f78474cd11e",
    lazy = true,
    event = { "LspAttach" },
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
          Struct = '',
          Copilot = "",
        },
      })
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end,
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    tag = '0.1.3',
    lazy = true,
    ft = { "yaml", "json" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "neovim/nvim-lspconfig" },
      {
        "b0o/schemastore.nvim",
        commit = "6f2ffb8420422db9a6c43dbce7227f0fdb9fcf75",
      },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
      local lspconfig = require('lspconfig')
      local json_schemas = require('schemastore').json.schemas {}
      local yaml_schemas = {}
      vim.tbl_map(function(schema)
        yaml_schemas[schema.url] = schema.fileMatch
      end, json_schemas)

      local yaml_config = require("yaml-companion").setup({
        schemas = {
          {
            name = "Kubernetes",
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
    end,
  },

  --Completion
  {
    'hrsh7th/nvim-cmp',
    commit = "7a3b1e76f74934b12fda82158237c6ad8bfd3d40",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    config = require('plugins.nvim-cmp'),
    dependencies = {
      {
        'hrsh7th/cmp-nvim-lsp',
        commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef",
      },
      {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        commit = "3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1",
      },
      {
        'hrsh7th/cmp-buffer',
        commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
      },
      {
        'hrsh7th/cmp-path',
        commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
      },
      {
        'hrsh7th/cmp-cmdline',
        commit = "8fcc934a52af96120fe26358985c10c035984b53",
      },
      {
        'hrsh7th/cmp-emoji',
        commit = "19075c36d5820253d32e2478b6aaf3734aeaafa0",
      },
      {
        'hrsh7th/cmp-vsnip',
        commit = "989a8a73c44e926199bfd05fa7a516d51f2d2752",
      },
      {
        'hrsh7th/vim-vsnip',
        commit = "8dde8c0ef10bb1afdbb301e2bd7eb1c153dd558e",
      },
      {
        'lukas-reineke/cmp-under-comparator',
        commit = '6857f10272c3cfe930cece2afa2406e1385bfef8',
      },
      {
        'golang/vscode-go',
        tag = "v0.37.1",
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = true,
    commit = '92535dfd9c430b49ca7d9a7da336c5db65826b65',
    event = { "InsertEnter" },
    config = function()
      require("copilot_cmp").setup()
    end,
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        commit = 'b41d4c9c7d4f5e0272bcf94061b88e244904c56f',
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        end,
      },
    },
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = "0.1.1",
    lazy = true,
    cmd = { "Telescope" },
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-frecency.nvim',
        commit = 'e5696afabd8753d772987ea48434d9c0d8b0aa6b',
        dependencies = {
          {
            'kkharji/sqlite.lua',
            tag = "v1.2.2",
          },
        },
      },
      {
        'cljoly/telescope-repo.nvim',
        commit = "50b5fc6eba11b5f1fcb249d5f7490551f86d1a00",
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        commit = "580b6c48651cabb63455e97d7e131ed557b8c7e2",
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        commit = "6eb6bb45b7a9bed94a464a3e1dadfe870459628c",
      },
    },
    config = function()
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('repo')
      require("telescope").load_extension "file_browser"
      require "telescope".load_extension("frecency")

      local actions = require("telescope.actions")
      local telescope = require('telescope')
      telescope.setup {
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              width = 0.8,
            },
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-u>"] = false,
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
  {
    'haringsrob/nvim_context_vt',
    commit = 'e592a9142fbfe0878ce886cd0d745963604c61d2',
    lazy = true,
    event = "VeryLazy",
    config = function()
      require('nvim_context_vt').setup {
        disable_ft = { 'markdown', 'yaml' }
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    commit = "e99d733e0213ceb8f548ae6551b04ae32e590c80",
    lazy = true,
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
        },
      }
    end
  },
  {
    "folke/todo-comments.nvim",
    tag = 'v1.0.0',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    config = [[require("todo-comments").setup {}]],
  },
  {
    'RRethy/vim-illuminate',
    commit = "3bd2ab64b5d63b29e05691e624927e5ebbf0fb86",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'ntpeters/vim-better-whitespace',
    commit = "1b22dc57a2751c7afbc6025a7da39b7c22db635d",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    'mvllow/modes.nvim',
    tag = 'v0.2.1',
    lazy = true,
    event = { "InsertEnter" },
    config = [[require('modes').setup()]],
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    tag = "v2.20.4",
    lazy = true,
    event = { "VeryLazy" },
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },

  -- Widget
  {
    'romgrk/barbar.nvim',
    commit = '4573b19e9ac29a58409a9445bf93753fb5a3e0e4',
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    'dstein64/nvim-scrollview',
    tag = "v3.0.3",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    "SmiteshP/nvim-navic",
    commit = "7e9d2b2b601149fecdccd11b516acb721e571fe6",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "utilyre/barbecue.nvim",
    tag = "v0.4.1",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup {
        theme = 'tokyonight',
      }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    commit = '74040b34278910d9b467fd914862e2a9a1ebacaa',
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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require('neo-tree').setup {
        filesystem = {
          filtered_items = {
            visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        },
      }
    end
  },
  {
    'famiu/bufdelete.nvim',
    commit = "8933abc09df6c381d47dc271b1ee5d266541448e",
    lazy = true,
    cmd = { 'Bdelete' },
  },
  {
    'voldikss/vim-floaterm',
    commit = "ca44a13a379d9af75092bc2fe2efee8c5248e876",
    lazy = true,
    cmd = { 'FloatermToggle', 'FloatermNew' },
    config = function()
      vim.g.floaterm_height = 0.9
      vim.g.floaterm_width = 0.9
    end
  },
  {
    'mrjones2014/legendary.nvim',
    tag = 'v2.7.1',
    lazy = true,
    event = { "VeryLazy" },
    config = require('plugins.legendary'),
    dependencies = {
      {
        "stevearc/dressing.nvim",
        commit = '5f44f829481640be0f96759c965ae22a3bcaf7ce',
      },
    },
  },
  {
    "folke/which-key.nvim",
    tag = 'v1.1.1',
    lazy = true,
    event = { "VeryLazy" },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  },

  -- Enhanced motions
  {
    'bkad/CamelCaseMotion',
    commit = "de439d7c06cffd0839a29045a103fe4b44b15cdc",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
  },
  {
    'mg979/vim-visual-multi',
    commit = '724bd53adfbaf32e129b001658b45d4c5c29ca1a',
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
  },
  {
    'terryma/vim-expand-region',
    commit = '966513543de0ddc2d673b5528a056269e7917276',
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
  },
  -- Editing
  {
    'EtiamNullam/deferred-clipboard.nvim',
    tag = "v0.7.0",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    config = function()
      require('deferred-clipboard').setup {
        fallback = 'unnamedplus', -- or your preferred setting for clipboard
      }
    end,
  },
  {
    'bennypowers/nvim-regexplainer',
    commit = '8af9a846644982ab1e11cc99b6e4831e12479207',
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
  },
  {
    'AndrewRadev/splitjoin.vim',
    commit = '503e56ed103b58b6bd0880a3e61225c8b1c40033',
    lazy = true,
    cmd = { "SplitjoinSplit", 'SplitjoinJoin' },
  },
  {
    'Wansmer/treesj',
    commit = "90248883bdb2d559ff4ba7f0148eb0145d3f0908",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup {}
    end,
  },
  {
    'gbprod/substitute.nvim',
    tag = 'v1.1.1',
    lazy = true,
    event = 'VeryLazy',
    config = [[require'substitute'.setup {}]],
  },
  {
    'haya14busa/vim-edgemotion',
    commit = '8d16bd92f6203dfe44157d43be7880f34fd5c060',
    lazy = true,
    event = 'VeryLazy',
  },
  {
    'junegunn/vim-easy-align',
    commit = "12dd6316974f71ce333e360c0260b4e1f81169c3",
    lazy = true,
    cmd = { 'EasyAlign' },
  },
  {
    'tpope/vim-surround',
    commit = "3d188ed2113431cf8dac77be61b842acb64433d9",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
  },
  {
    'AndrewRadev/sideways.vim',
    commit = "e683ed0fc57eda718c6b28dce0ff5190089d13d3",
    lazy = true,
    cmd = { 'SidewaysLeft', 'SidewaysRight' },
  },
  {
    'lfilho/cosco.vim',
    tag = "v0.10.0",
    lazy = true,
    cmd = { 'CommaOrSemiColon' },
  },
  {
    'numToStr/Comment.nvim',
    tag = "v0.7.0",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    config = [[require('Comment').setup()]] },
  {
    "danymat/neogen",
    tag = "2.13.1",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    config = [[require('neogen').setup {}]],
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    }
  },
  {
    'windwp/nvim-autopairs',
    commit = "6a5faeabdbcc86cfbf1561ae430a451a72126e81",
    lazy = true,
    event = { "InsertEnter" },
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt", "vim" },
      })
    end,
  },

  -- Search
  {
    'markonm/traces.vim',
    commit = "9663fcf84de5776bee71b6c816c25ccb6ea11d1a",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
  },
  {
    'haya14busa/vim-asterisk',
    commit = "77e97061d6691637a034258cc415d98670698459",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
  },
  {
    'rhysd/clever-f.vim',
    commit = "6a3ac5e3688598af9411ab741737f98c47370c22",
    lazy = true,
    keys = { "f", "F", "t", "T" },
  },
  {
    'unblevable/quick-scope',
    tag = "v2.5.16",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    'windwp/nvim-spectre',
    commit = "b71b64afe9fedbfdd25a8abec897ff4af3bd553a",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    'kevinhwang91/nvim-hlslens',
    tag = "v1.0.0",
    lazy = true,
    event = { "VeryLazy" },
    config = [[require'hlslens'.setup()]],
  },
  {
    'phaazon/hop.nvim',
    tag = "v2.0.3",
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
    config = function()
      require 'hop'.setup {
        keys = 'jkhlfdgsieurowyta;qpmv,c',
      }
    end
  },
  {
    'andymass/vim-matchup',
    commit = "3a48818a8113a502f245c29d894201421727577a",
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    commit = 'f388995990aba04cfdc7c3ab870c33e280601109',
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = require('plugins.gitsigns'),
  },
  {
    'ruanyl/vim-gh-line',
    commit = "fbf368bdfad7e5478009a6dc62559e6b2c72d603",
    lazy = true,
    cmd = { 'GH', 'GHInteractive' },
  },
  {
    'f-person/git-blame.nvim',
    commit = "ed84c1cfc49828a917af52bd92cac882851eca25",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    'akinsho/git-conflict.nvim',
    commit = "2957f747e1a34f1854e4e0efbfbfa59a1db04af5",
    lazy = true,
    event = { "VeryLazy" },
    config = [[require('git-conflict').setup()]],
  },
  {
    'pwntester/octo.nvim',
    commit = "f336322f865cfa310ae15435c6bec337687b6b20",
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
    "jackMort/ChatGPT.nvim",
    lazy = true,
    commit = '3008b38171b3137448fe33c5edc1bba2641bfcad',
    cmd = { 'ChatGPT', 'ChatGPTActAs', 'ChatGPTEditWithInstructions' },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("chatgpt").setup {}
    end,
  },
  {
    'mattn/vim-sonictemplate',
    commit = "0e4d422c85decd8d159c663f234eb484b1b04b25",
    lazy = true,
    cmd = { 'Template' },
  },
  {
    'segeljakt/vim-silicon',
    commit = "4a93122ae2139a12e2a56f064d086c05160b6835",
    lazy = true,
    cmd = { 'Silicon' },
  },
  {
    'voldikss/vim-translator',
    commit = "681c6b2f650b699572e6bb55162a3d6e62ee5d43",
    lazy = true,
    cmd = { 'Translate', 'TranslateW' },
  },

  -- Language specific tools
  -- Go
  {
    'ray-x/go.nvim',
    commit = "4d066613379d85094bb4ddd52e34e6d3f55fc24e",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    ft = "go",
  },
  {
    'ray-x/guihua.lua',
    commit = "a19ac4447021f21383fadd7a9e1fc150d0b67e1f",
    lazy = true,
    event = { "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" },
    ft = "go",
  },

  -- Markdown
  {
    'ekickx/clipboard-image.nvim',
    commit = "d1550dc26729b7954f95269952e90471b838fa25",
    lazy = true,
    cmd = { 'PasteImg' },
    ft = "markdown",
  },
  {
    "iamcco/markdown-preview.nvim",
    tag = "v0.0.10",
    lazy = true,
    ft = "markdown",
    cmd = { 'MarkdownPreview' },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Others
  {
    'jsborjesson/vim-uppercase-sql',
    commit = "58bfde1d679a1387dabfe292b38d51d84819b267",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    ft = { 'sql' },
  },
  {
    'google/vim-jsonnet',
    commit = "4ebc6619ddce5d032a985b42a9864154c3d20e4a",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    ft = { 'jsonnet' },
  },
  {
    'hashivim/vim-terraform',
    commit = "d00503de9bed3a1da7206090cb148c6a1acce870",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    ft = { 'terraform', 'hcl' },
  },
  {
    'juliosueiras/vim-terraform-completion',
    commit = "125d0e892f5fd8f32b57a5a5983d03f1aa611949",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    ft = { 'terraform', 'hcl' },
  },

  -- Color
  {
    'xiyaowong/nvim-transparent',
    commit = '4c3c392f285378e606d154bee393b6b3dd18059c',
    config = function()
      require 'transparent'.setup {
        enable = true,
      }
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    commit = '36c610a9717cc9ec426a07c8e6bf3b3abcb139d6',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  { 'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    tag = 'v1.3.0',
    config = function()
      require 'tokyonight'.setup {
        -- Disable italic because Windows Terminal does not support it.
        on_highlights = function(highlights, colors)
          highlights['@keyword'].style.italic = false
          highlights['Comment'].style.italic = false
          highlights['DashboardFooter'].italic = false
          highlights['Keyword'].style.italic = false
        end,
      }
      vim.cmd [[highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE]]
    end
  },
}

vim.cmd [[colorscheme tokyonight-night]]
