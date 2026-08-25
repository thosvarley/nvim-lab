return {
	-- Telescope is installed as a stand-alone and a dependency.
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		lazy = true,
		config = function()
			require("telescope").setup({
				defaults = {
					generic_sorter = require("mini.fuzzy").get_telescope_sorter,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		cmd = "Telescope file_browser",
		lazy = true,
	},
	{
		"nvim-telescope/telescope-bibtex.nvim",
		cmd = "Telescope bibtex",
		config = function()
			require("telescope").load_extension("bibtex")
		end,
		lazy = true,
	},
}
