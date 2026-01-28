return {
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("kanagawa-paper-ink")
		end,
		integrations = {
			wezterm = {
				enabled = true,
				path = (os.getenv("TEMP") or "/tmp") .. "/nvim-theme"
			},
		},
		opts = { ... },
	},
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("kanagawa")
	-- 	end
	-- },
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("gruvbox")
	-- 	end,
	-- 	integrations = {
	-- 		wezterm = {
	-- 			enabled = true,
	-- 			path = (os.getenv("TEMP") or "/tmp") .. "/nvim-theme"
	-- 		},
	-- 	},
	-- 	opts = { ... },
	-- },
	-- {
	-- 	"catppuccin/nvim", name = "catppuccin", priority = 1000
	-- },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- },
	-- {
	-- 	'AlexvZyl/nordic.nvim',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- }
}

