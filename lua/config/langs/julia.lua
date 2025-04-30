-- Julia LSP
require('lspconfig').julials.setup({
	cmd = {
		"julia",
		"--startup-file=no",
		"--history-file=no",
		"-e",
		[[
		using LanguageServer, SymbolServer, Pkg; 
		env_path = dirname(Pkg.Types.Context().env.project_file); 
		server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, ""); 
		run(server);
		]]
	},
  	settings = {
		julia = {
			format = {
				indent = 2,
				margin = 92,
			},
		}
  	},
	filetypes = { "julia" },
	on_attach = function(client, bufnr)
		print("Julia now attached to buffer " .. bufnr)
  	end,
	root_dir = function(fname)
		return require('lspconfig').util.root_pattern("Project.toml", ".git")(fname)
		or vim.loop.cwd()
	end
})
