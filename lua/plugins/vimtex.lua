return {
	"lervag/vimtex",
	ft = { "tex" },
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"

		vim.g.vimtex_compiler_latexmk = {
			executable = "latexmk",
			aux_dir = "./build",
			out_dir = "./",
		}

		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_view_forward_search_on_start = 1
	end,
}
