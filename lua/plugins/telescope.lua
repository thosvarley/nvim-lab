return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		lazy = true,
		-- Extensions load with Telescope; `:Telescope file_browser` and
		-- `:Telescope bibtex` register them on first use.
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-bibtex.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					generic_sorter = require("mini.fuzzy").get_telescope_sorter,
				},
			})
		end,
	},
}
