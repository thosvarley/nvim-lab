-- Plugin management
return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1001, -- this plugin needs to run before anything else
		opts = {
			rocks = { "magick" },
		},
	},
	-- General QoL plugins
	{
		'tpope/vim-sensible'
	},
	{
		-- Telescope is installed as a stand-alone and a dependency.
		-- This is an odd quirk of nvim package management - installing as a standalone lets us write a seperate config file. Listing it as a dependnecy of the file_browser ensures that it is loaded as-needed when the browser is called.
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		cmd = "Telescope",
	},
	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim'
		},
		cmd = "Telescope file_browser",
	},
	{
		"nvim-telescope/telescope-bibtex.nvim",
		dependencies = {
			'nvim-telescope/telescope.nvim'
		},
		config = function()
			require "telescope".load_extension("bibtex")
		end,
	},
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		}
	},
	{
		'jake-stewart/multicursor.nvim'
	},
	{
		'nvimdev/indentmini.nvim',
		event = 'BufEnter',
		config = function()
			require('indentmini').setup()
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = 'BufReadPost',
	},
	{
		'christoomey/vim-tmux-navigator',
		lazy = false
	},
	-- Notebook and REPLs - IronREPL
	{
		'Vigemus/iron.nvim'
	},
	{
		"GCBallesteros/jupytext.nvim",
		config = true,
		-- Depending on your nvim distro or config you may need to make the loading not lazy
		lazy = false,
	},
	{
		"benlubas/molten-nvim",
		dependencies = { "3rd/image.nvim" },
		ft = { "python", "julia", "r" },
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_use_border_highlights = true
			-- add a few new things

			-- don't change the mappings (unless it's related to your bug)
			vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>")
			vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>")
			vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>")
			vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv")
			vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>")
			vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>")
			vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>")
		end,
	},
	{
		"3rd/image.nvim",
		dependencies = { "luarocks.nvim" },
		opts = {
			backend = "kitty",
			integrations = {},
			processor = "magick_cli",
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
		version = "1.1.0", -- or comment out for latest
	},
	-- Color schemes
	-- These are a few of my favorites.
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000
	},
	{
		'rebelot/kanagawa.nvim',
		priority = 1000
	},
	{
		'thesimonho/kanagawa-paper.nvim',
		priority = 1000
	},
	-- LSP Configuration
	{
		'neovim/nvim-lspconfig',
		lazy = true,
		ft = {
			"python",
			"julia",
			"r",
			"rust",
			"lua"
		},
		dependencies = {
			-- Mason for managing LSP servers
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			-- Completion engine
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			-- Snippets
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip'
		}
	},
	{
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig',
		event = { "BufReadPre", "BufNewFile" },
	},
	-- CMP + Snippets
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
	},
	{
		'hrsh7th/cmp-nvim-lsp'
	},
	{
		'L3MON4D3/LuaSnip',
		dependencies = { 'rafamadriz/friendly-snippets' },
		event = 'InsertEnter',
	},
	-- Rust
	{
		'simrat39/rust-tools.nvim',
		dependencies = { 'neovim/nvim-lspconfig' },
		lazy = true
	},
	-- latex
	{
		'lervag/vimtex',
		dependencies = { 'micangl/cmp-vimtex' },
		ft = { 'tex' },
		lazy = false,
		init = function()
			-- vimtex settings
			vim.g.vimtex_view_method = "zathura" -- set Zathura as the PDF viewer
			vim.g.tex_compiler_method = "latexmk" -- use latexmk to compile LaTeX files

			-- Forward search configuration
			vim.g.vimtex_view_forward_search_on_start = true
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.vimtex_view_general_options = "--synctex-forward %l:1:%f %p"

			-- Automatically open PDF in split after compilation
			vim.g.vimtex_quickfix_mode = 0
			vim.g.vimtex_view_forward_search_on_start = 1
		end
	},
	-- git integration
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
	},
	-- Markdown integration
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1
		end
	},
	-- Wezterm integration
	{
		'willothy/wezterm.nvim',
		config = true
	},
}
