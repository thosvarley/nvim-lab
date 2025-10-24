return {
	{
		'lervag/vimtex',
		dependencies = { 'micangl/cmp-vimtex' },
		ft = { 'tex' },
		lazy = false,
		init = function()
			-- vimtex settings
			vim.g.vimtex_view_method = "zathura" -- set Zathura as the PDF viewer
			vim.g.tex_compiler_method = "latexmk" -- use latexmk to compile LaTeX files
			
			vim.cmd([[
				    let g:vimtex_compiler_latexmk = {
					\ 'executable' : 'latexmk',
					\ 'aux_dir' : './build',
					\ 'out_dir' : './'
					\}
				]])


			-- Forward search configuration
			vim.g.vimtex_view_forward_search_on_start = true
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.vimtex_view_general_options = "--synctex-forward %l:1:%f %p"

			-- Automatically open PDF in split after compilation
			vim.g.vimtex_quickfix_mode = 0
			vim.g.vimtex_view_forward_search_on_start = 1
		end
	},
}
