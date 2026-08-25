return {
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		integrations = {
			wezterm = {
				enabled = true,
				path = (os.getenv("TEMP") or "/tmp") .. "/nvim-theme"
			},
		},
		opts = { ... },
	},
}

