return {
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			default_file_explorer = false,
			view_options = {
				show_hidden = true,
			}
		},
		cmd = "Oil",
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		lazy = true,
	},
}
