-- Rust LSP configuration
require('rust-tools').setup({ 
	server = { 
		on_attach = on_attach, 
		capabilities = capabilities, 
		settings = { 
			["rust-analyzer"] = { 
				checkOnSave = { 
					command = "clippy" 
				}, 
				inlayHints = { 
					enable = true, 
					showParameterNames = true, 
					parameterHintsPrefix = "<- ", 
					otherHintsPrefix = "=> ",
				}, 
				procMacro = {
					enable = true 
				},
				cargo = { 
					allFeatures = true 
				} 
			} 
		} 
	}, 
	filetypes = { "rust" },
	on_attach = function(client, bufnr)
    		print("Rust now attached to buffer " .. bufnr)
  	end,
	root_dir = require("lspconfig").util.root_pattern("Cargo.toml"),
})
