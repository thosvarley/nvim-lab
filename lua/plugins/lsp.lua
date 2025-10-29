return {
	{
		"neovim/nvim-lspconfig",
		ft = {
			"python",
			"r",
			"julia",
			"rust",
			"lua",
			"latex",
			"octave",
			"haskell",
			"c",
			"cpp"
		},
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp", -- 👈 required for completion capabilities
			"nvimtools/none-ls.nvim"
		},
		config = function()
			-- Setup Mason
			require("mason").setup()

			-- Add nvim-cmp completion capabilities to all LSPs
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			
			-- Function that tells us when LSP is attached. 
			local on_attach = function(client, bufnr)
				vim.notify("LSP attached: " .. client.name, vim.log.levels.INFO)
			end

			-- Configure LSP servers using new vim.lsp.config API
			vim.lsp.config("ruff", {
				cmd = { "ruff", "server" },
				root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
				capabilities = capabilities,
				on_attach = on_attach,
			})

			vim.lsp.config("pylsp", {
				cmd = { "pylsp" },
				root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					pylsp = {
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							mccabe = { enabled = false },
							rope_completion = { enabled = false},
							rope_rename = {enabled = false},
						},
					},
				},
			})

			vim.lsp.config("rust_analyzer", {
				cmd = { "rust-analyzer" },
				root_markers = { "Cargo.toml", "rust-project.json", ".git" },
				capabilities = capabilities,
				on_attach = on_attach,
			})

			vim.lsp.config("texlab", {
				cmd = { "texlab" },
				root_markers = { ".latexmkrc", ".git", "main.tex" },
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					texlab = {
						build = {
							executable = "latexmk",
							args = {
								"-pdf",
								"-interaction=nonstopmode",
								"-synctex=1",
								"%f",
							},
							onSave = true,
						},
						forwardSearch = {
							executable = "latexmk",
							args = {
								"--synctex-forward",
								"%l:1:%f",
								"%p",
							},
						},
					},
				},
			})

			vim.lsp.config("hls", {
				cmd = { "haskell-language-server-wrapper", "--lsp" },
				root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "package.yaml", ".git" },
				capabilities = capabilities,
				on_attach = on_attach,
			})

			vim.lsp.config("r_language_server", {
				cmd = { "R", "--slave", "-e", "languageserver::run()" },
				root_markers = { ".Rprofile", "DESCRIPTION", ".git" },
				capabilities = capabilities,
				on_attach = on_attach,
			})


			vim.lsp.config("julials", {
				cmd = { "julia", "--startup-file=no", "--history-file=no", "-e", [[
					using LanguageServer
					runserver()
				]] },
				root_markers = { "Project.toml", "JuliaProject.toml", ".git" },
				capabilities = capabilities,
				on_attach = on_attach,
				flags = {
					exit_timeout = 5000,
				},
			})
			
			vim.lsp.config("clangd", {
				cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
				init_options = {
					clangdFileStatus = true,
					clangdSemanticHighlighting = true
				},
				filetypes = { "c", "cpp", "cxx", "cc", "h", "hpp", "objc", "objcpp", "cuda" },
				root_markers = {
				    '.clangd',
				    '.clang-tidy',
				    '.clang-format',
				    'compile_commands.json',
				    'compile_flags.txt',
				    'configure.ac', -- AutoTools
				    '.git',
				},
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					['clangd'] = {
					    ['compilationDatabasePath'] = 'cmake'
					}
			  	}
			})

			-- Setup Mason LSPConfig to ensure servers are installed
			-- Note: julials is NOT in ensure_installed because we configure it manually
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ruff",
					"pylsp",
					"rust_analyzer",
					"texlab",
					"hls",
					"r_language_server",
					"clangd"
				},
			})

			-- Enable all configured LSP servers
			vim.lsp.enable({
				"ruff",
				"pylsp",
				"rust_analyzer",
				"texlab",
				"hls",
				"r_language_server",
				"julials",
				"clangd"
			})

			-- ✨ Add MyPy diagnostics via none-ls
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.mypy.with({
						extra_args = {
							"--ignore-missing-imports",
							"--check-untyped-defs",
							"--follow-imports=silent",
							"--strict",
						},
					}),
				},
				on_attach = on_attach,
			})
		end,
	},
}
