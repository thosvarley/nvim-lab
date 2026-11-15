return {
	"petertriho/nvim-scrollbar",
	lazy = false,
	branch = "v1",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"kevinhwang91/nvim-hlslens",
	},
	config = function()
		require("gitsigns").setup()
		-- Search marks go to the scrollbar only; no inline [n/m] lens boxes.
		-- (scrollbar's search handler hooks hlslens' build_position_cb itself.)
		require("hlslens").setup({
			enable_virt_text = false,
			override_lens = function() end,
		})
		require("scrollbar").setup({
			show = true,
			show_in_active_only = false,
			set_highlights = true,
			folds = 1000,
			max_lines = false,
			hide_if_all_visible = false,
			throttle_ms = 100,
			handle = {
				text = " ",
				blend = 0,
				color = nil,
				color_nr = nil,
				highlight = "CursorColumn",
				hide_if_all_visible = true,
			},
			marks = {
				Cursor = { text = "•", priority = 0, highlight = "Normal" },
				Search = { text = { "-", "=" }, priority = 1, color = "#DCA561", highlight = "Search" },
				Error = {
					text = { "-", "=" },
					priority = 2,
					color = "#E82424",
					highlight = "DiagnosticVirtualTextError",
				},
				Warn = { text = { "-", "=" }, priority = 3, color = "#FF9E3B", highlight = "DiagnosticVirtualTextWarn" },
				Info = { text = { "-", "=" }, priority = 4, color = "#658594", highlight = "DiagnosticVirtualTextInfo" },
				Hint = { text = { "-", "=" }, priority = 5, color = "#6A9589", highlight = "DiagnosticVirtualTextHint" },
				Misc = { text = { "-", "=" }, priority = 6, color = "#957FB8", highlight = "Normal" },
				GitAdd = { text = "┆", priority = 7, highlight = "GitSignsAdd" },
				GitChange = { text = "┆", priority = 7, highlight = "GitSignsChange" },
				GitDelete = { text = "▁", priority = 7, highlight = "GitSignsDelete" },
			},
			excluded_buftypes = { "terminal" },
			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
			},
			autocmd = {
				render = {
					"BufWinEnter",
					"TabEnter",
					"TermEnter",
					"WinEnter",
					"CmdwinLeave",
					"TextChanged",
					"VimResized",
					"WinScrolled",
				},
				clear = { "BufWinLeave", "TabLeave", "TermLeave", "WinLeave" },
			},
			handlers = {
				cursor = true,
				diagnostic = true,
				gitsigns = true, -- also sets up the gitsigns handler
				handle = true,
				search = true, -- also sets up the hlslens handler
				ale = false,
			},
		})
	end,
}
