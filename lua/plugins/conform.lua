return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>fmt",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {},
	config = function()
		local languages = require("languages")
		
		local formatters_by_ft = {}

		if languages.lua then
			formatters_by_ft.lua = { "stylua" }
		end

		if languages.python then
			formatters_by_ft.python = { "ruff_fix", "ruff_format" }
		end

		if languages.rust then
			formatters_by_ft.rust = { "rustfmt" }
		end

		if languages.latex then
			formatters_by_ft.tex = { "tex-fmt" }
		end

		if languages.r then
			formatters_by_ft.r = { "air" }
		end

		if languages.julia then
			formatters_by_ft.julia = { "runic" }
		end

		if languages.octave then
			formatters_by_ft.matlab = { "mh_style" }
			formatters_by_ft.octave = { "mh_style" }
		end

		if languages.c_cpp then
			formatters_by_ft.c = { "clang-format" }
			formatters_by_ft.cpp = { "clang-format" }
		end

		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
		})
	end,
}
