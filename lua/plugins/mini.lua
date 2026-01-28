return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.pairs").setup()
		require("mini.basics").setup()
		require("mini.clue").setup({
			triggers = {
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },
				{ mode = "n", keys = "g" },
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
			},
		})
		require("mini.completion").setup({
			window = {
				info = { border = "rounded" },
				signature = { border = "rounded" },
			},
		})
		require("mini.comment").setup()
		require("mini.files").setup()
		require("mini.fuzzy").setup()
		require("mini.git").setup()
		require("mini.icons").setup()
		require("mini.notify").setup()
		require("mini.statusline").setup()
		require("mini.snippets").setup()
		require("mini.surround").setup()
		require("mini.tabline").setup()
	end,
}
