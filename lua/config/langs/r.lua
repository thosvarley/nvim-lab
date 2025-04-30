
-- R Language Server configuration
require('lspconfig').r_language_server.setup({
	cmd = { "R", "--slave", "-e", "languageserver::run()" },
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	settings = {
		r = {
			lsp = {
				diagnostics = true,
				document_formatting = true,
			},
			editor = {
				tabSize = 2,           -- R typically uses 2-space indentation
				formatOnSave = false,  -- Set to true if you want auto-formatting
				formatOnType = false,
			},
			rpath = {
				-- Add any custom R library paths here if needed
				-- "/path/to/my/r/library",
				}
			}
		},
		filetypes = { "r", "rmd" }, -- Only activate for R and RMarkdown files 
		on_attach = function(client, bufnr)
			print("R now attached to buffer " .. bufnr)
		end,
		-- If a root dir can't be found, defaults to the current working dir. 
		root_dir = function(fname)
			return require("lspconfig").util.root_pattern('DESCRIPTION', '.Rproj', '.git')(fname) 
			or vim.loop.cwd()
		end
	})
