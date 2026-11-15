return {
	"neovim/nvim-lspconfig",
	ft = {
		"nix",
		"python",
		"lua",
		"r",
		"julia",
		"rust",
		"tex",
		"haskell",
		"c",
		"cpp",
		"objc",
		"objcpp",
		"cuda",
	},
	config = function()
		local languages = require("languages")

		-- Shared attach logic lives in an LspAttach autocmd rather than a
		-- per-server `on_attach`, so it doesn't replace the `on_attach` that
		-- nvim-lspconfig ships for some servers (clangd, texlab,
		-- rust_analyzer, julials use theirs to define buffer commands).
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("nvim_lab_lsp", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end
				vim.notify("LSP attached: " .. client.name, vim.log.levels.INFO)

				-- LspAttach fires once per buffer; only wrap each client once.
				if client._nvim_lab_patched then
					return
				end
				client._nvim_lab_patched = true

				-- Work around a mini.completion bug (completion.lua:1711).
				-- It picks an active parameter via
				-- `signature.activeParameter or response.activeParameter or 0`,
				-- but JSON `null` decodes to the userdata sentinel `vim.NIL`
				-- (not Lua nil) -- which is truthy, so it wins the `or` chain
				-- instead of falling through to 0, and then gets compared
				-- against a number and crashes. jedi-language-server sends an
				-- explicit `null` here for signatures it can't pin an active
				-- parameter for (e.g. numpy.ix_, a *args-taking callable
				-- class rather than a plain def). Strip vim.NIL out of
				-- signatureHelp responses before mini.completion sees them.
				local orig_request = client.request
				client.request = function(self, method, params, handler, ...)
					if method == "textDocument/signatureHelp" and handler then
						local orig_handler = handler
						handler = function(err, result, ctx, config)
							if result then
								if result.activeParameter == vim.NIL then
									result.activeParameter = nil
								end
								if result.activeSignature == vim.NIL then
									result.activeSignature = nil
								end
								for _, sig in ipairs(result.signatures or {}) do
									if sig.activeParameter == vim.NIL then
										sig.activeParameter = nil
									end
								end
							end
							return orig_handler(err, result, ctx, config)
						end
					end
					return orig_request(self, method, params, handler, ...)
				end
			end,
		})

		-- Nix
		if languages.nix then
			vim.lsp.config("nixd", {
				cmd = { "nixd" },
				root_markers = { "flake.nix", ".git" },
				filetypes = { "nix" },
			})
			vim.lsp.enable("nixd")
		end

		-- Python
		if languages.python then
			vim.lsp.config("jedi_language_server", {
				root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
				init_options = {
					diagnostics = { enable = false },
				},
				filetypes = { "python" },
			})
			vim.lsp.enable("jedi_language_server")

			vim.lsp.config("ruff", {
				root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
				filetypes = { "python" },
			})
			vim.lsp.enable("ruff")
		end

		-- Lua (for Neovim config)
		if languages.lua then
			vim.lsp.config("lua_ls", {
				filetypes = { "lua" },
				root_markers = {
					".luarc.json",
					".luarc.jsonc",
					".luacheckrc",
					".stylua.toml",
					"stylua.toml",
					"selene.toml",
					"selene.yml",
					".git",
				},
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT", -- Neovim uses LuaJIT
						},
						diagnostics = {
							globals = { "vim" }, -- Recognize vim global
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			vim.lsp.enable("lua_ls")
		end

		-- Rust (name matches nvim-lspconfig's config so its defaults apply)
		if languages.rust then
			vim.lsp.config("rust_analyzer", {
				cmd = { "rust-analyzer" },
				root_markers = { "Cargo.toml", "rust-project.json", ".git" },
				filetypes = { "rust" },
			})
			vim.lsp.enable("rust_analyzer")
		end

		-- LaTeX
		-- VimTeX owns compilation (latexmk) and viewing (zathura), so texlab
		-- doesn't build on save -- otherwise every save compiles twice.
		-- :TexlabBuild still works on demand.
		if languages.latex then
			vim.lsp.config("texlab", {
				cmd = { "texlab" },
				root_markers = { ".latexmkrc", ".git", "main.tex" },
				filetypes = { "tex" },
				settings = {
					texlab = {
						completion = {
							enabled = true,
						},
						build = {
							executable = "latexmk",
							args = {
								"-pdf",
								"-interaction=nonstopmode",
								"-synctex=1",
								"%f",
							},
							onSave = false,
						},
						forwardSearch = {
							executable = "zathura",
							args = {
								"--synctex-forward",
								"%l:1:%f",
								"%p",
							},
						},
					},
				},
			})
			vim.lsp.enable("texlab")
		end

		-- R (air provides both the language server and the formatter;
		-- nvim-lspconfig ships an `air` config for it)
		if languages.r then
			vim.lsp.config("air", {
				cmd = { "air", "language-server" },
				root_markers = { "air.toml", ".air.toml", ".Rprofile", "DESCRIPTION", ".git" },
				filetypes = { "r" },
			})
			vim.lsp.enable("air")
		end

		-- Julia
		if languages.julia then
			vim.lsp.config("julials", {
				cmd = {
					"julia",
					"--startup-file=no",
					"--history-file=no",
					"-e",
					[[
						using LanguageServer
						runserver()
					]],
				},
				root_markers = { "Project.toml", "JuliaProject.toml", ".git" },
				filetypes = { "julia" },
				flags = {
					exit_timeout = 5000,
				},
			})
			vim.lsp.enable("julials")
		end

		-- C/C++
		-- clangd finds compile_commands.json by searching parent directories
		-- (and their build/ subdirectories) on its own.
		if languages.c_cpp then
			vim.lsp.config("clangd", {
				cmd = { "clangd", "--background-index", "--clang-tidy" },
				init_options = {
					clangdFileStatus = true,
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
				root_markers = {
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git",
				},
			})
			vim.lsp.enable("clangd")
		end

		-- Haskell
		if languages.haskell then
			vim.lsp.config("hls", {
				cmd = { "haskell-language-server-wrapper", "--lsp" },
				root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "package.yaml", ".git" },
				filetypes = { "haskell" },
			})
			vim.lsp.enable("hls")
		end
	end,
}
