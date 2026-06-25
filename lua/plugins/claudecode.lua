return {
	"greggh/claude-code.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for git operations
	},
	config = function()
		require("claude-code").setup({
			-- Terminal window settings
			window = {
				split_ratio = 0.33, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
				position = "vertical", -- Position of the window: "botright", "topleft", "vertical", "float", etc.
			},
		})
	end,
}
