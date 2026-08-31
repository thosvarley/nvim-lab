return {
	"petertriho/nvim-scrollbar",
	lazy = false,
	-- 1. Add the dependencies so Neovim actually installs hlslens and gitsigns
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"kevinhwang91/nvim-hlslens",
	},
	config = function()
		-- 2. Setup your dependencies first
		require("gitsigns").setup()
		require("hlslens").setup({
			-- Keep the scrollbar pipeline active
			build_position_cb = function(plist, _, _, _)
				require("scrollbar.handlers.search").handler.show(plist.start_pos)
			end,
			-- DISABLE the inline bracket boxes in your code lines
			enable_virt_text = false,
			override_lens = function() end,
		})
		-- 3. Core scrollbar configuration
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
				"blink-cmp-menu",
				"dropbar_menu",
				"dropbar_menu_fzf",
				"DressingInput",
				"cmp_docs",
				"cmp_menu",
				"noice",
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
				diagnostic = true, -- Native LSP Diagnostics should work instantly now
				gitsigns = true, -- FIXED: Set to true to allow git markers
				handle = true,
				search = true, -- FIXED: Set to true to allow search markers
				ale = false,
			},
		})

		-- 4. CRITICAL: Initialize the scrollbar-specific handlers so they fetch the data
		require("scrollbar.handlers.gitsigns").setup()
		require("scrollbar.handlers.search").setup()
	end,
}
