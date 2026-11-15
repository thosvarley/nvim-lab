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
		-- Icons come from mini.icons (set up in mini.lua), which oil prefers.
		lazy = true,
	},
}
