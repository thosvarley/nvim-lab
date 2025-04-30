
-- Haskell LSP
require('lspconfig').hls.setup({
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	settings = { 
		haskell = {
			formattingProvider = "fourmolu", -- or "ormolu" or "stylish-haskell"
		}
	},
	filetypes = { "haskell", "lhaskell" },
	on_attach = function(client, bufnr)
    		print("Haskell now attached to buffer " .. bufnr)
	end,
	-- If a root dir can't be found, defaults to the current working dir.
	root_dir = function(fname)
		return require('lspconfig').util.root_pattern("hie.yaml", "stack.yaml", ".cabal")(fname)
		or vim.loop.cwd()
	end
})
