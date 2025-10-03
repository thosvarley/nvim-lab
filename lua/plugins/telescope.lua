return {
	-- Telescope is installed as a stand-alone and a dependency.
	{
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
	}
}
