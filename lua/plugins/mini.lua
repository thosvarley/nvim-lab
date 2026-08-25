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
		require("mini.completion").setup()
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

		-- An active snippet session leaves a "." /"∎" virtual-text marker on
		-- unvisited tabstops (e.g. the final $0 after a function call's
		-- closing paren) until the session is stopped; nothing here jumps
		-- through tabstops, so stop the session on InsertLeave instead.
		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				if MiniSnippets.session.get() ~= nil then
					MiniSnippets.session.stop()
				end
			end,
		})
	end,
}
