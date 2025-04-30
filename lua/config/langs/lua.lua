-- Configure Lua Language server
require("lspconfig").lua_ls.setup({ 
	settings = { 
		Lua = { 
			runtime = { 
				version = 'LuaJIT',
			},
			diagnostics = { 
				globals = {'vim'}, -- Recognize vim global in your config 
			},
			workspace = {
				-- Make the server aware of Neovim runtime files 
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		}
	},
	filetypes = { "lua" },
	on_attach = function(client, bufnr)
		print("Lua now attached to buffer " .. bufnr)
	end,
  	root_dir = function(fname)
		return require('lspconfig').util.root_pattern("init.lua", ".luarc.json", ".git")(fname)
		or vim.loop.cwd()
	end
})
