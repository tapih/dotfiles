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

	-- Profiling
	use { 'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]] }

	-- Basic
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'

	-- Appearance
	use 'morhetz/gruvbox'
	use 'kyazdani42/nvim-web-devicons'
	use { 'famiu/feline.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
	use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
	use {
		'norcalli/nvim-colorizer.lua',
		ft = { 'css', 'javascript', 'typescript', 'vim', 'html', 'dart' },
		config = [[require('colorizer').setup {'css', 'javascript', 'vim', 'html'}]],
	}
	use { 'lukas-reineke/indent-blankline.nvim', config = [[require('plugins.indent-blackline')]] }
	use { 'nvim-treesitter/nvim-treesitter',     config = [[require('plugins.nvim-treesitter')]], run = ':TSUpdate' }
	use { 'romgrk/nvim-treesitter-context',      requires = {'nvim-treesitter/nvim-treesitter'} }

	-- Project
	use 'airblade/vim-rooter'
	use 'mhinz/vim-startify'
	use {
		'kyazdani42/nvim-tree.lua',
		opt = true,
		cmd = {'NvimTreeToggle'},
		config = [[require('plugins.nvim-tree')]],
	}

	-- Terminal
	use { 'numToStr/FTerm.nvim', config = [[require('plugins.fterm')]] }

	-- Syntax
	-- use 'zinit-zsh/zplugin-vim-syntax'
	use 'bronson/vim-trailing-whitespace'
	use 'junegunn/vim-easy-align'

	-- Search
	use 'coderifous/textobj-word-column.vim'
	use { 'dyng/ctrlsf.vim',           config = [[require('plugins.ctrlsf')]] }
	use { 'easymotion/vim-easymotion', config = [[require('plugins.vim-easymotion')]] }

	-- Clipboard
	use 'roxma/vim-tmux-clipboard'
	use { 'tversteeg/registers.nvim', opt = true, cmd = {"Registers"} }

	-- Browser
	use 'tyru/open-browser.vim'
	use 'ruanyl/vim-gh-line'
	use { 'xavierchow/vim-swagger-preview', ft = {'yaml'} }

  -- Comment
  use { 'terrortylor/nvim-comment', config =[[require('nvim_comment').setup {}]] }

	-- Tim Pope docet
	use 'tpope/vim-surround'
	use 'tpope/vim-repeat'
	use { 'tpope/vim-fugitive',   opt = true, cmd = {'Gdiff', 'Gblame'} }
	use { 'tpope/vim-commentary', opt = true, cmd = {'Commentary'} }
	use { 'tpope/vim-dispatch',   opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'} }

	-- LSP
	use 'neovim/nvim-lspconfig'
	use { 'onsails/lspkind-nvim', config = [[require('plugins.lspkind')]] }
  use { "ray-x/lsp_signature.nvim", config = [[require'lsp_signature'.setup {}]] }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = [[require("trouble").setup {}]]
  }
  -- use {
  --   'stevearc/aerial.nvim',
  --   config = [[require('plugins.aerial')]],
  --   cmd = {"AerialToggle"},
  -- }

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
	use {
		'pwntester/octo.nvim',
		opt = true,
		cmd = {
			'Octo',
			'OctoAddReviewComment',
			'OctoAddReviewSuggestion',
			'OctoAddReviewSuggestions',
		},
		requires = {
			{'nvim-lua/plenary.nvim'},
		},
	}

  -- Autocomplete
  use { 'windwp/nvim-autopairs', config = [[require('plugins.nvim-autopairs')]] }
  use 'andymass/vim-matchup'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use { 'hrsh7th/nvim-cmp', config = [[require('plugins.nvim-cmp')]] }
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'windwp/nvim-ts-autotag'

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
	-- use { 'folke/todo-comments.nvim', requires = "nvim-lua/plenary.nvim" }

	-- Markdown
	use { 'godlygeek/tabular', ft = {'markdown'} }
	use {
		'plasticboy/vim-markdown',
		ft = {'markdown'},
		config = function()
			vim.g['vim_markdown_folding_disabled'] = 1
		end,
	}
	use {
		'iamcco/markdown-preview.nvim',
		ft = {'markdown'},
		run = 'cd app && yarn install',
		config = [[require('plugins.markdown-preview')]],
	}

	-- Flutter
	use { 'akinsho/flutter-tools.nvim', ft = {'dart'}, requires = {'nvim-lua/plenary.nvim'} }

	-- Go
	use { 'buoto/gotests-vim',   ft = {'go'}, cmd = {'GoTests', 'GoTestsAll'} }
	use { 'mattn/vim-goimports', ft = {'go'}, cmd = {'w'} }

	end

	return setmetatable({}, {
		__index = function(_, key)
			init()
			return packer[key]
		end,
	})
