return {
	"Vigemus/iron.nvim",
	lazy = true,
	cmd = { "IronRunCurrent", "IronRunCell" },
	keys = {
		{
			"<Leader>rh",
			function()
				require("iron.core").send_line()
			end,
			desc = "Send line to REPL",
		},
		-- add other iron keymaps here
		{
			"<Leader>rv",
			function()
				require("iron.core").send_line()
			end,
			desc = "Send line to REPL",
		},
	},
	config = function()
		local view = require("iron.view")
		require("iron.core").setup({
			config = {
				scratch_repl = true,
				repl_definition = {
					python = {
						command = { "ipython", "-i", "-c", "import matplotlib.pyplot as plt; plt.ion()" },
						format = require("iron.fts.common").bracketed_paste,
						block_dividers = { "# %%", "#%%" },
					},
					rust = {
						command = { "evcxr" },
					},
					r = {
						command = { "R" },
						block_divides = { "# %%", "#%%" },
					},
					haskell = {
						command = { "ghci" },
					},
					lua = {
						command = { "lua" },
					},
					octave = {
						command = { "octave " },
					},
				},
				repl_open_cmd = {
					view.split.rightbelow(),
					view.split.vertical.rightbelow(),
				},
			},
			keymaps = {
				toggle_repl = "<space>rr",
				toggle_repl_with_cmd_1 = "<space>rh",
				toggle_repl_with_cmd_2 = "<space>rv",
				interrupt = "<space>s<space>",
				exit = "<space>sq",
				clear = "<space>cl",
			},
			highlight = { italic = true },
			ignore_blank_lines = true,
		})

		-- Set up commands in config block if you want to keep it all together
		vim.api.nvim_create_user_command("IronRunCurrent", function()
			vim.cmd("write") -- Save the file first
			local filepath = vim.fn.expand("%:p")
			local cmd = string.format("%%run %s", filepath)
			require("iron.core").send(nil, { cmd })
		end, {})

		vim.api.nvim_create_user_command("IronRunCell", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local cursor = vim.api.nvim_win_get_cursor(0)
			local cur_line = cursor[1]

			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

			local start_idx = 1
			for i = cur_line, 1, -1 do
				if lines[i]:match("^%s*# %%") then
					start_idx = i + 1
					break
				end
			end

			local end_idx = #lines
			for i = cur_line + 1, #lines do
				if lines[i]:match("^%s*# %%") then
					end_idx = i - 1
					break
				end
			end

			local cell_lines = {}
			for i = start_idx, end_idx do
				table.insert(cell_lines, lines[i])
			end

			require("iron.core").send(nil, cell_lines)
		end, {})
	end,
}
