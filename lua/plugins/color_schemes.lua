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
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("gruvbox")
		end,
		integrations = {
			wezterm = {
				enabled = true,
				path = (os.getenv("TEMP") or "/tmp") .. "/nvim-theme"
			},
		},
		opts = { ... },
	}
}
