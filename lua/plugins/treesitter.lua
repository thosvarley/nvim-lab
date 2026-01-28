return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"python",
				"r",
				"haskell",
				"julia",
				"rust",
				"lua",
				"bash",
				"markdown",
				"c",
				"cpp",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false, -- don't run both
			},
			indent = { enable = true },
		})
	end,
}
