-- LSP configs for python.

require('lspconfig').pylsp.setup({
	settings = {
		pylsp = {
			plugins = {
				pyflakes = { enabled = true },
				pylint = { enabled = false },
				black = { enabled = true },
				yapf = { enabled = false },
				autopep8 = { enabled = false },
			},
		},
	},
	filetypes = { "python" },
	on_attach = function(client, bufnr)
		print("Python now attached to buffer " .. bufnr)
  	end,
  	root_dir = require('lspconfig').util.root_pattern("pyproject.toml", ".git", "setup.py"),
})
