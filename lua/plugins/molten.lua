return {
	{
		"GCBallesteros/jupytext.nvim",
		config = true,
		-- Depending on your nvim distro or config you may need to make the loading not lazy
		lazy = false,
	},
	-- image.nvim
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
				},
			},
			-- Inline rendering settings
			max_width = 100,
			max_height = 20,
			max_width_window_percentage = nil,
			max_height_window_percentage = nil,

			-- Keep images inline with text
			window_overlap_clear_enabled = false,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

			-- Inline behavior
			editor_only_render_when_focused = true,
			tmux_show_only_in_active_window = false,

			-- Hijack file protocol for inline display
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
		},
	},
	-- Molten
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 40 -- Give more room for images
			vim.g.molten_auto_open_output = true
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
		end,
		config = function()
			-- Function to evaluate code between # %% markers
			local function evaluate_cell()
				local cursor_pos = vim.api.nvim_win_get_cursor(0)
				local current_line = cursor_pos[1]

				-- Search backward for cell delimiter
				local start_line = current_line
				for i = current_line, 1, -1 do
					local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
					if line:match("^#%s*%%%%") then
						start_line = i + 1
						break
					end
					if i == 1 then
						start_line = 1
					end
				end

				-- Search forward for cell delimiter
				local end_line = current_line
				local total_lines = vim.api.nvim_buf_line_count(0)
				for i = current_line, total_lines do
					local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
					if line:match("^#%s*%%%%") and i ~= current_line then
						end_line = i - 1
						break
					end
					if i == total_lines then
						end_line = total_lines
					end
				end

				-- Set visual selection marks
				vim.api.nvim_buf_set_mark(0, '<', start_line, 0, {})
				vim.api.nvim_buf_set_mark(0, '>', end_line, 0, {})

				-- Evaluate the cell
				vim.cmd('MoltenEvaluateVisual')
			end

			-- Create the command
			vim.api.nvim_create_user_command('MoltenEvaluateCell', evaluate_cell, {})

			-- Keybindings
			vim.keymap.set('n', '<localleader>rc', ':MoltenEvaluateCell<CR>',
				{ silent = true, desc = 'Evaluate cell' })
			vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",
				{ silent = true, desc = "Initialize Molten" })
			vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
				{ silent = true, desc = "Evaluate line" })
			vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
				{ silent = true, desc = "Evaluate visual" })
		end,
	}
}
