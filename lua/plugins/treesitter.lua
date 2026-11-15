local parsers = {
	"python",
	"r",
	"haskell",
	"julia",
	"rust",
	"lua",
	"bash",
	"markdown",
	"markdown_inline", -- inline markdown (code spans, links, emphasis)
	"c",
	"cpp",
	"nix",
	"vim",
	"vimdoc",
	"query",
	-- No `latex`: VimTeX's own syntax handles .tex (its math-zone detection
	-- and motions depend on it), so tree-sitter isn't used there.
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- The main branch's setup() no longer takes ensure_installed/highlight/indent
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if lang and pcall(vim.treesitter.start, args.buf, lang) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
