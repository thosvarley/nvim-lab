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
		require("mini.fuzzy").setup()
		require("mini.git").setup()
		require("mini.icons").setup()
		-- Serve icons to plugins that ask for nvim-web-devicons (telescope, etc.)
		MiniIcons.mock_nvim_web_devicons()
		require("mini.notify").setup()
		require("mini.statusline").setup()
		require("mini.snippets").setup()
		require("mini.surround").setup()
		require("mini.tabline").setup()

		-- An active snippet session leaves a "." /"∎" virtual-text marker on
		-- unvisited tabstops (e.g. the final $0 after a function call's
		-- closing paren) until the session is stopped. <Tab>/<S-Tab> in
		-- keymaps.lua jump between tabstops while typing; once you leave
		-- insert mode, stop the session so leftover markers are cleared.
		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				if MiniSnippets.session.get() ~= nil then
					MiniSnippets.session.stop()
				end
			end,
		})
	end,
}
