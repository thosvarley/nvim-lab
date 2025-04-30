-- config/ironrepl.lua
local iron = require("iron.core")
local view = require("iron.view")


-- Runs current script in it's entirety
vim.api.nvim_create_user_command("IronRunCurrent", function()
	vim.cmd('write') -- Save the file first
	local filepath = vim.fn.expand('%:p')
	local cmd = string.format("%%run %s", filepath)
	iron.send(nil, { cmd })
end, {})


-- Runs cell
vim.api.nvim_create_user_command("IronRunCell", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local cur_line = cursor[1]

	-- Get all lines in the buffer
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	-- Find start of cell
	local start_idx = 1
	for i = cur_line, 1, -1 do
		if lines[i]:match("^%s*# %%") and i ~= cur_line then
			start_idx = i + 1
			break
		elseif lines[i]:match("^%s*# %%") then
			start_idx = i + 1
			break
		end
	end

	-- Find end of cell
	local end_idx = #lines
	for i = cur_line + 1, #lines do
		if lines[i]:match("^%s*# %%") then
			end_idx = i - 1
			break
		end
	end

	-- Extract the lines for the cell
	local cell_lines = {}
	for i = start_idx, end_idx do
		table.insert(cell_lines, lines[i])
	end

	-- Send to Iron
	require("iron.core").send(nil, cell_lines)
end, {})

-- Runs a cell and moves to the start of the next cell.
vim.api.nvim_create_user_command("IronRunCellAndMove", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local cur_line = cursor[1]

	-- Get all lines in the buffer
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	-- Find start of cell
	local start_idx = 1
	for i = cur_line, 1, -1 do
		if lines[i]:match("^%s*# %%") and i ~= cur_line then
			start_idx = i + 1
			break
		elseif lines[i]:match("^%s*# %%") then
			start_idx = i + 1
			break
		end
	end

	-- Find end of cell
	local end_idx = #lines
	for i = cur_line + 1, #lines do
		if lines[i]:match("^%s*# %%") then
			end_idx = i - 1
			break
		end
	end

	-- Extract the lines for the cell
	local cell_lines = {}
	for i = start_idx, end_idx do
		table.insert(cell_lines, lines[i])
	end

	-- Send to IronRepl
	require("iron.core").send(nil, cell_lines)

	-- Move cursor to next cell header if it exists
	for i = end_idx + 1, #lines do
		if lines[i]:match("^%s*# %%") then
			vim.api.nvim_win_set_cursor(0, { i, 0 })
			return
		end
	end
end, {})


iron.setup {
	config = {
		scratch_repl = true,
		repl_definition = {
			python = {
				command = { "ipython", "-i", "-c", "import matplotlib.pyplot as plt; plt.ion()" },
				format = require("iron.fts.common").bracketed_paste,
				block_dividers = { "# %%", "#%%" },
			},
			haskell = {
				command = { "ghci" },
			},
			r = {
				command = { "R" },
				block_divides = {"# %%", "#%%" },
			},
			julia = {
				command = { "julia" },
			},
			lua = {
				command = { "lua "},
			},
			octave = {
				command = { "octave" },
			},
			matlab = {
				command = { "octave" },
			},
		},
		repl_open_cmd = {
			view.split.rightbelow(),
			view.split.vertical.rightbelow(),
		}
	},
	keymaps = {
		toggle_repl = "<space>rr",
		toggle_repl_with_cmd_1 = "<space>rv",
		toggle_repl_with_cmd_2 = "<space>rh",
		restart_repl = "<space>rR",
		send_motion = "<space>sc",
		visual_send = "<space>sv",
		mark_motion = "<space>mc",
		mark_visual = "<space>mc",
		remove_mark = "<space>md",
		cr = "<space>s<cr>",
		interrupt = "<space>s<space>",
		exit = "<space>sq",
		clear = "<space>cl",
	},
	highlight = {
		italic = true
	},
	ignore_blank_lines = true,
}
