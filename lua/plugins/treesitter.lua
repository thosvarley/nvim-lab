return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = 'BufReadPost',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					"python", "r", "haskell", "julia", "rust", "lua", "bash", "markdown", "c", "cpp"
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<C-s>",
						node_decremental = "<C-backspace>",
					},
				},
			})
		end
	}
}
